part of 'events_loader_cubit.dart';

/// {@template notes_loader_state}
/// The state of the notes loader.
/// {@endtemplate}
class EventsLoaderState<T> extends Equatable {
  /// {@macro notes_loader_state}
  const EventsLoaderState({
    required this.results,
    required this.isLoading,
    required this.eoseTriggered,
    this.error,
    this.usersMetadataMap = const {},
    this.usersNip05Map = const {},
    this.eventsMap = const {},
    this.eventsLikesMap = const {},
    this.eventsZaps = const {},
    this.currentUserEvents = const {},
    this.eventsCommentsMap = const {},
    this.resultsToAddLater = const [],
    this.gotInitialEventsLoaded = false,
    this.showGoTop = false,
    this.isAtTheVeryTop = true,
  });

  ///
  final bool showGoTop;

  /// The results from your events query.
  final List<T> results;

  /// The results that will be added later to the state.
  final List<T> resultsToAddLater;

  /// Whether the loader is currently loading.
  final bool isLoading;

  /// The error message.
  final String? error;

  /// Whether one of relays sent the EOSE command, use this to trigger when a relay initial events query is done.
  final bool eoseTriggered;

  /// The metadata of the users that are loaded mapped by their owners public key.
  final Map<String, UserMetaData?> usersMetadataMap;

  /// The events that are loaded mapped by their event id.
  final Map<String, NostrEvent> eventsMap;

  /// The events that are loaded mapped by their event id which owned by the current user.
  final Map<String, NostrEvent> currentUserEvents;

  /// The verifications of the users with NIP05 mapped by their identifier.
  final Map<String, bool> usersNip05Map;

  /// The reaction events loaded mapped by their event id which is the event that they are reacting to.
  final Map<String, List<NostrEvent>> eventsLikesMap;

  /// The zaps events loaded mapped by their event id which is the event that they are zapping to.
  final Map<String, List<NostrEvent>> eventsZaps;

  /// The comments events loaded mapped by their event id which is the event that they are commenting to.
  final Map<String, List<NostrEvent>> eventsCommentsMap;

  /// Whether the initial events were loaded.
  final bool gotInitialEventsLoaded;

  ///
  final bool isAtTheVeryTop;

  @override
  List<Object?> get props => [
        results,
        error,
        isLoading,
        eoseTriggered,
        usersMetadataMap,
        gotInitialEventsLoaded,
        resultsToAddLater,
        showGoTop,
        eventsMap,
        usersNip05Map,
        eventsLikesMap,
        eventsZaps,
        eventsCommentsMap,
        currentUserEvents,
        isAtTheVeryTop,
      ];

  // ignore: public_member_api_docs
  EventsLoaderState<T> copyWith({
    List<T>? results,
    List<T>? resultsToAddLater,
    String? error,
    bool? isLoading,
    bool? eoseTriggered,
    Map<String, UserMetaData?>? usersMetadataMap,
    Map<String, NostrEvent>? eventsMap,
    bool? gotInitialEventsLoaded,
    bool? showGoTop,
    Map<String, bool>? usersNip05Map,
    Map<String, List<NostrEvent>>? eventsLikesMap,
    Map<String, List<NostrEvent>>? eventsZaps,
    Map<String, List<NostrEvent>>? eventsCommentsMap,
    Map<String, NostrEvent>? currentUserEvents,
    bool? isAtTheVeryTop,
  }) {
    return EventsLoaderState(
      isAtTheVeryTop: isAtTheVeryTop ?? this.isAtTheVeryTop,
      results: results ?? this.results,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      eoseTriggered: eoseTriggered ?? this.eoseTriggered,
      usersMetadataMap: usersMetadataMap ?? this.usersMetadataMap,
      gotInitialEventsLoaded:
          gotInitialEventsLoaded ?? this.gotInitialEventsLoaded,
      resultsToAddLater: resultsToAddLater ?? this.resultsToAddLater,
      showGoTop: showGoTop ?? this.showGoTop,
      eventsMap: eventsMap ?? this.eventsMap,
      usersNip05Map: usersNip05Map ?? this.usersNip05Map,
      eventsLikesMap: eventsLikesMap ?? this.eventsLikesMap,
      eventsZaps: eventsZaps ?? this.eventsZaps,
      eventsCommentsMap: eventsCommentsMap ?? this.eventsCommentsMap,
      currentUserEvents: currentUserEvents ?? this.currentUserEvents,
    );
  }
}

/// {@macro notes_loader_state}
final class EventsLoaderInitial<T> extends EventsLoaderState<T> {
  /// {@macro notes_loader_state}
  const EventsLoaderInitial({
    super.results = const [],
    super.isLoading = false,
    super.eoseTriggered = false,
  });
}
