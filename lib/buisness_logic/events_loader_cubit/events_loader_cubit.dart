// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:dart_nostr/nostr/model/ease.dart';

import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'events_loader_state.dart';

abstract class RelatedToNostrEvent extends Equatable {
  /// the original nostr event
  final NostrEvent? originalNostrEvent;

  const RelatedToNostrEvent({
    required this.originalNostrEvent,
  });
}

class ResultsAdditionalHandlingParms<T extends RelatedToNostrEvent?>
    extends Equatable {
  const ResultsAdditionalHandlingParms({
    this.generateFiltersForLoadedElements,
  });

  /// The filters that will be used to get the loaded elements data.
  final List<NostrFilter> Function(
    List<T> elements,
    EventsLoaderState<T> state,
    Set<NostrFilter> filtersSet,
  )? generateFiltersForLoadedElements;

  @override
  List<Object?> get props => [
        generateFiltersForLoadedElements,
      ];
}

/// {@template notes_loader_cubit}
/// Cubit for managing a new nostr connection and loading notes, make sure you specify the generic type which will be used in the [eventModifier] function and state results.
/// {@endtemplate}
class EventsLoaderCubit<T extends RelatedToNostrEvent?>
    extends Cubit<EventsLoaderState<T>> {
  /// {@macro notes_loader_cubit}
  EventsLoaderCubit({
    required this.currentUserKeyPair,
    required this.eventModifier,
    required this.relays,
    this.limit,
    this.ignoreInitialEventsRequest = false,
    this.kinds,
    this.infiniteScrollLoading = true,
    this.eventsSorter,
    this.authors,
    this.ids,
    this.t,
    this.e,
    this.p,
    this.a,
    this.searchQuery,
    this.additionalResultsHandling,
    this.customFilterTags,
    this.multiInitialFilters,
    this.instantResultsToAddInitially,
    this.neverCloseInitialLoading = false,
    this.propagateEventsAsSoonAsTheyArrive = false,
  }) : super(EventsLoaderInitial<T>()) {
    _init();
  }

  /// If true, the initial events request will be ignored.
  final bool ignoreInitialEventsRequest;

  /// If true, the infinite scroll loading will be enabled.
  final bool infiniteScrollLoading;

  /// The scroll controller that will be used to handle the scroll events of feeds.
  ScrollController? scrollController;

  /// The function that will be used to modify the event before adding it to the state.
  final FutureOr<T?> Function(NostrEvent event) eventModifier;

  /// The function that will be used to sort the events before adding them to the state.
  final List<T> Function(List<T> events)? eventsSorter;

  /// The kinds of the notes that will be loaded.
  final List<int>? kinds;

  /// The limit of the notes that will be loaded.
  final int? limit;

  ///
  final NostrKeyPairs currentUserKeyPair;

  /// The authors of the notes that will be loaded.
  final List<String>? authors;

  /// The ids of the notes that will be loaded.
  final List<String>? ids;

  /// The tags of the notes that will be loaded.
  final List<String>? e;

  // ignore: public_member_api_docs
  final List<String>? p;

  // ignore: public_member_api_docs
  final List<String>? t;

  // ignore: public_member_api_docs
  final List<String>? a;

  /// The custom filter tags.
  final Map<String, dynamic>? customFilterTags;

  /// The relays that will be used to connect to.
  final List<String> relays;

  /// The search query that will be used to nostr requests.
  final String? searchQuery;

  /// The additional handling for the results.
  final ResultsAdditionalHandlingParms<T>? additionalResultsHandling;

  /// The queue that will be used to get the posts the current user sees to handles the additional results handling.
  final _queue = Queue<List<T>>();

  /// Th map that will hold the main eose commands for the main listening to events declared in the [_init] method
  final _eoseMap = <String, NostrRequestEoseCommand>{};

  /// The main subscription id that will be used to close the main events listening.
  String? mainSubscriptionId;

  /// The set that will hold the filters that will be used to get the loaded elements data.
  final filtersSet = <NostrFilter>{};

  /// The additional initial filters to be used initially with the main filter that is derived from the cubit parameters.
  final List<NostrFilter>? multiInitialFilters;

  /// The initial results that will be added initially to the state.
  final List<T>? instantResultsToAddInitially;

  /// If true, the initial loading will never be closed.
  final bool neverCloseInitialLoading;

  ///
  final bool propagateEventsAsSoonAsTheyArrive;

  @override
  Future<void> close() async {
    if (mainSubscriptionId != null)
      NostrService.instance.subs.close(mainSubscriptionId!);

    scrollController?.dispose();

    return super.close();
  }

  void addItemManually(T item) {
    emit(
      state.copyWith(
        results: [item, ...state.results],
        currentUserEvents: {
          ...state.currentUserEvents,
          if (currentUserKeyPair.public == item!.originalNostrEvent!.pubkey)
            item.originalNostrEvent!.id!: item.originalNostrEvent!,
        },
        eventsMap: {
          ...state.eventsMap,
          item.originalNostrEvent!.id!: item.originalNostrEvent!,
        },
      ),
    );
  }

  Future<void> _init() async {
    if (additionalResultsHandling != null) _timerToGetQueuePostsStream();

    if (instantResultsToAddInitially != null) {
      final eventsMap = {
        for (final event in instantResultsToAddInitially!)
          if (event?.originalNostrEvent?.id != null)
            event!.originalNostrEvent!.id!: event.originalNostrEvent!,
      };

      emit(
        state.copyWith(
          results: [
            ...instantResultsToAddInitially!,
            ...state.results,
          ],
          eventsMap: {
            ...state.eventsMap,
            ...eventsMap,
          },
        ),
      );
    }

    scrollController ??= ScrollController()..addListener(_scrollListener);

    if (ignoreInitialEventsRequest) {
      _markInitialLoadingAsDone();

      return;
    }

    late NostrEventsStream sub;

    if (multiInitialFilters != null) {
      sub = NostrService.instance.subs.multiFilterEvents(
        filters: multiInitialFilters!,
        onEose: (relay, eose) {
          if (neverCloseInitialLoading) {
            return;
          }

          _eoseMap[relay] = eose;

          if (_eoseMap.length ==
              NostrService.instance.subs?.relayConnectionsLength) {
            _markInitialLoadingAsDone();
          }
        },
      );
    } else {
      sub = NostrService.instance.subs!.events(
        authors: authors,
        limit: limit,
        e: e,
        ids: ids,
        kinds: kinds,
        p: p,
        t: t,
        a: a,
        search: searchQuery,
        onEose: (relay, eose) {
          _eoseMap[relay] = eose;
          if (_eoseMap.length ==
              NostrService.instance.subs?.relayConnectionsLength) {
            _markInitialLoadingAsDone();
          }
        },
      );
    }

    mainSubscriptionId = sub.subscriptionId;

    sub.stream.listen((event) async {
      if (state.eventsMap.containsKey(event.id)) {
        return;
      }

      if (isClosed) return;

      final modifierResult = await eventModifier(event);

      if (modifierResult == null) {
        return;
      }

      final newResult = <T>[modifierResult, ...state.results];

      if (eventsSorter != null) {
        eventsSorter!.call(newResult);
      }

      if (state.gotInitialEventsLoaded && !propagateEventsAsSoonAsTheyArrive) {
        emit(
          state.copyWith(
            resultsToAddLater: [modifierResult, ...state.resultsToAddLater],
            eventsMap: {
              ...state.eventsMap,
              event.id!: event,
            },
            currentUserEvents: {
              ...state.currentUserEvents,
              if (currentUserKeyPair.public == event.pubkey) event.id!: event,
            },
          ),
        );
      } else {
        emit(
          state.copyWith(
            results: newResult,
            eventsMap: {
              ...state.eventsMap,
              event.id!: event,
            },
            currentUserEvents: {
              ...state.currentUserEvents,
              if (currentUserKeyPair.public == event.pubkey) event.id!: event,
            },
          ),
        );
      }
    });
  }

  void addPostToNextQueue(T element) {
    if (_queue.isEmpty) {
      _queue.add([element]);
    } else {
      _queue.last.add(element);
    }
  }

  Future<void> addLatePostsToMainResults() async {
    await scrollController?.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    await Future.delayed(const Duration(milliseconds: 500));

    emit(
      state.copyWith(
        results: [
          ...state.resultsToAddLater,
          ...state.results,
        ],
        resultsToAddLater: [],
      ),
    );
  }

  Future<void> loadMoreEvents() async {
    final lastEvent = state.results.last;
    final createdAt = lastEvent?.originalNostrEvent?.createdAt;

    if (createdAt == null) {
      return;
    }

    final completer = Completer<void>();
    final localEoseMap = <String, NostrRequestEoseCommand>{};
    final localEventsMap = <String, NostrEvent>{};
    var counter = 0;

    final sub = NostrService.instance.subs.events(
      authors: authors,
      limit: limit,
      e: e,
      ids: ids,
      kinds: kinds,
      p: p,
      t: t,
      a: a,
      until: createdAt.copyWith(
        millisecond: createdAt.millisecond - 10,
      ),
      search: searchQuery,
      onEose: (relay, eose) {
        localEoseMap[relay] = eose;

        final shouldClose = localEoseMap.length ==
            NostrService.instance.subs.relayConnectionsLength;

        if (shouldClose) {
          NostrService.instance.subs.close(eose.subscriptionId);
          completer.complete();
        }
      },
    );

    sub.stream.listen((event) async {
      counter++;
      localEventsMap[event.id!] = event;

      if (isClosed) return;

      final modifierResult = await eventModifier(event);

      if (modifierResult == null) {
        return;
      }

      var newResult = <T>[...state.results, modifierResult];

      if (eventsSorter != null) {
        newResult = eventsSorter!(newResult);
      }

      emit(
        state.copyWith(
          results: newResult,
        ),
      );

      if (counter + 1 >= (limit ?? 10)) {
        if (localEventsMap.isNotEmpty) {
          NostrService.instance.subs
              .close(localEoseMap.values.first.subscriptionId);
        }

        completer.complete();
      }
    });

    await completer.future;
  }

  void _timerToGetQueuePostsStream() {
    Future.delayed(const Duration(seconds: 1), () {
      final isQueueEmpty = _queue.isEmpty;

      if (!isQueueEmpty) {
        final posts = _queue.removeFirst();
        _startStreamForPosts(posts);
      }

      _timerToGetQueuePostsStream();
    });
  }

  Future<void> _startStreamForPosts(List<T> elements) async {
    final filters = additionalResultsHandling!.generateFiltersForLoadedElements!
        .call(elements, state, filtersSet);

    if (filters.isEmpty) {
      return;
    }

    final localEoseMap = <String, NostrRequestEoseCommand>{};

    final sub = NostrService.instance.subs!.multiFilterEvents(
      onEose: (relay, eose) {
        localEoseMap[relay] = eose;

        if (localEoseMap.length ==
            NostrService.instance.subs.relayConnectionsLength) {
          NostrService.instance.subs.close(eose.subscriptionId);
        }
      },
      filters: filters,
    );

    sub.stream.listen(
      (event) {
        emit(
          state.copyWith(
            eventsMap: {
              ...state.eventsMap,
              event.id!: event,
            },
          ),
        );

        if (event.kind == 0) {
          if (state.usersMetadataMap.containsKey(event.pubkey)) {
            return;
          }

          final data = UserMetaData.fromEvent(event);

          // _scheduleNip05Verification(event.pubkey, data?.nip05);
          debugPrint('pubkey: ${event.pubkey}, name: ${data?.name}');

          emit(
            state.copyWith(
              usersMetadataMap: {
                ...state.usersMetadataMap,
                event.pubkey: data,
              },
            ),
          );
        } else if (event.kind == 7) {
          final targetEventId =
              event.tags!.firstWhereOrNull((e) => e.first == 'e')?[1] ?? '';

          final eventLikes = state.eventsLikesMap[targetEventId] ?? [];

          if (eventLikes.any((ev) => ev.id == event.id)) {
            return;
          }

          emit(
            state.copyWith(
              eventsLikesMap: {
                ...state.eventsLikesMap,
                targetEventId: [...eventLikes, event],
              },
            ),
          );
        } else if (event.kind == 1) {
          final tag = event.tags!.nostrTags('e').firstOrNull ?? [];

          if (tag.length < 4) {
            return;
          }

          if (tag[3] == 'mention') {
            return;
          }

          final targetEventId = tag[1] ?? '';

          final eventComments = state.eventsCommentsMap[targetEventId] ?? [];

          if (eventComments.any((ev) => ev.id == event.id)) {
            return;
          }

          emit(
            state.copyWith(
              eventsCommentsMap: {
                ...state.eventsCommentsMap,
                targetEventId: [
                  ...eventComments,
                  event,
                ],
              },
            ),
          );
        }
      },
    );
  }

  void _markInitialLoadingAsDone() {
    emit(
      state.copyWith(
        gotInitialEventsLoaded: true,
      ),
    );
  }

  void _scrollListener() {
    final showGoTop = scrollController!.position.pixels > 100;

    if (showGoTop != state.showGoTop) {
      emit(
        state.copyWith(
          showGoTop: showGoTop,
        ),
      );
    }

    if (infiniteScrollLoading) {
      if (scrollController?.position.pixels ==
          scrollController?.position.maxScrollExtent) {
        loadMoreEvents();
      }
    }

    final isAtTheVeryTop = scrollController?.position.pixels == 0;

    if (state.isAtTheVeryTop != isAtTheVeryTop) {
      emit(
        state.copyWith(
          isAtTheVeryTop: isAtTheVeryTop,
        ),
      );
    }

    if (isAtTheVeryTop && state.resultsToAddLater.isNotEmpty) {
      addLatePostsToMainResults();
    }
  }

  // Future<void> _scheduleNip05Verification(String pubkey, String? nip05) async {
  //   if (nip05 == null) {
  //     emit(
  //       state.copyWith(
  //         usersNip05Map: {
  //           ...state.usersNip05Map,
  //           pubkey: false,
  //         },
  //       ),
  //     );

  //     return;
  //   }

  //   if (state.usersNip05Map[nip05] != null) {
  //     debugPrint('NIP05 $nip05 for $pubkey already checked.');
  //     return;
  //   }

  //   final isVerified = await NostrGeneral.instance.nip05IdentifierVerify(
  //     identifier: nip05,
  //     pubKey: pubkey,
  //   );

  //   emit(
  //     state.copyWith(
  //       usersNip05Map: {
  //         ...state.usersNip05Map,
  //         nip05: isVerified,
  //       },
  //     ),
  //   );
  // }

  Future<void> refresh() async {
    final initialState = EventsLoaderInitial<T>();

    if (mainSubscriptionId != null)
      NostrService.instance.subs.close(mainSubscriptionId!);

    //! add other subs to close

    emit(initialState);

    await _init();
  }

  Set<String> completedEvents = {};
}
