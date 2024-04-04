import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/search_option.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'global_feed_state.dart';

/// {@template global_feed}
/// The responsible cubit about the global feed.
/// {@endtemplate}
class GlobalFeedCubit extends Cubit<GlobalFeedState> {
  /// The scroll controller to manage user scroll.
  ScrollController? scrollController;

  /// The text field search controller which will receive user's search inpuy.git
  TextEditingController? searchController;

  /// The Nostr feed posts stream.
  NostrEventsStream feedPostsStream;

  /// The subscription where we will listen to [feedPostsStream.stream].
  StreamSubscription? _streamSubscription;

  /// {@macro global_feed}
  GlobalFeedCubit({
    required this.feedPostsStream,
  }) : super(GlobalFeedState.initial(
          searchOptions: AppConfigs.feedsSearchOptions,
        )) {
    _init();
  }

  @override
  Future<void> close() {
    feedPostsStream.close();

    _streamSubscription?.cancel();

    searchController?.dispose();
    scrollController?.dispose();

    print("FeedCubit close");

    return super.close();
  }

  /// Shows the advanced search functionality bottom sheet where the user can search for events that are shown.
  Future<void> showSearch(BuildContext context) {
    return BottomSheetService.showSearch(context, this);
  }

  /// Selects the search option at the given [index] assigning the [value] to it.
  void selectedSearchOption(int index, bool value) {
    final searchOptions = List<SearchOption>.of(state.searchOptions);
    searchOptions[index] = searchOptions[index].copyWith(isSelected: value);
    emit(state.copyWith(searchOptions: searchOptions));

    //! The previous implementation.
    // final searchOptions = <SearchOption>[];

    // for (int i = 0; i < state.searchOptions.length; i++) {
    //   final current = state.searchOptions[i];
    //   final isSelectedItem = i == index;

    //   if (isSelectedItem) {
    //     searchOptions.add(current.copyWith(isSelected: value));
    //   } else {
    //     searchOptions.add(current);
    //   }
    // }

    // emit(state.copyWith(searchOptions: searchOptions));
  }

  /// Shows the date range picker with the given [lastDate] & [firstDate] where the user can select a date range.
  Future<void> pickDateRange(
    BuildContext context, {
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final rangeDate = await showDateRangePicker(
      context: context,
      firstDate: firstDate ?? AppConfigs.feedDateRangePickerFirstDate,
      lastDate: lastDate ?? AppConfigs.feedDateRangePickerLastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, widget) {
        return Theme(
          data: ThemeData.from(
            colorScheme: Theme.of(context).brightness == Brightness.light
                ? const ColorScheme.light(primary: Colors.black)
                : const ColorScheme.dark(primary: Colors.white),
          ),
          child: widget!,
        );
      },
    );

    if (rangeDate != null) {
      emit(state.copyWith(dateRange: rangeDate));
    }
  }

  /// Runs the search query with all the selected options.
  void executeSearch() {
    try {
      List<Note> notes = state.feedPosts.map((e) => Note.fromEvent(e)).toList();
      Set<Note> notesResults = {};

      final searchQuery = searchController?.text ?? "";
      for (final option in state.searchOptions
          .where((e) => e.isSelected && !e.manipulatesExistingResultsList)) {
        if (option.useSearchQuery) {
          if (searchQuery.isNotEmpty) {
            notesResults.addAll(option.searchFunction(notes, searchQuery));
          }
        } else {
          notesResults.addAll(option.searchFunction(notes, ""));
        }
      }

      for (final option in state.searchOptions
          .where((e) => e.isSelected && e.manipulatesExistingResultsList)) {
        notesResults =
            option.searchFunction(notesResults.toList(), searchQuery).toSet();
      }

      if (state.dateRange != null) {
        notes = notes.where((note) {
          final dateRange = state.dateRange;
          if (dateRange == null) {
            return false;
          }

          final isAfter = note.event.createdAt!.isAfter(dateRange.start);
          final isBefore = note.event.createdAt!.isBefore(dateRange.end);

          return isAfter && isBefore;
        }).toList();
      }
      emit(state.copyWith(searchedFeedNotesPosts: notesResults.toList()));
    } catch (e) {
      print(e);
    }
  }

  /// Resets the search query & sheet to it's initial state
  void resetSearch() {
    searchController?.clear();
    final unselectedSearchOptions =
        state.searchOptions.map((e) => e.copyWith(isSelected: false)).toList();

    emit(
      state.copyWith(
        searchedFeedNotesPosts: [],
        searchOptions: unselectedSearchOptions,
        feedPosts: state.feedPosts,
      ),
    );
  }

  /// Shows the newest posts to the UI.
  void showNewestPostsToUI() {
    if (!isClosed) {
      emit(state.copyWith(shownFeedPosts: state.feedPosts));
    }
  }

  /// Navigates Top of the screen.
  void goTop() {
    scrollController?.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _init() {
    searchController = TextEditingController();
    scrollController = ScrollController();
    _handleStreams();
  }

  void _handleStreams() {
    bool shouldWaitXSecondsToUpdateFirstUI = true;
    _streamSubscription = feedPostsStream.stream.listen(
      (event) {
        final sortedList = <NostrEvent>[
          event,
          ...state.feedPosts,
        ];
        sortedList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

        if (!isClosed) {
          emit(state.copyWith(feedPosts: sortedList.toList()));
        }

        if (shouldWaitXSecondsToUpdateFirstUI) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            showNewestPostsToUI();
            shouldWaitXSecondsToUpdateFirstUI = false;
          });
        }
      },
    );
  }
}
