import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../constants/app_configs.dart';
import '../../model/note.dart';
import '../../model/search_option.dart';
import '../../services/bottom_sheet/bottom_sheet_service.dart';

part 'global_feed_state.dart';

class GlobalFeedCubit extends Cubit<GlobalFeedState> {
  ScrollController? scrollController;
  TextEditingController? searchController;
  NostrEventsStream feedPostsStream;
  StreamSubscription? _streamSubscription;

  GlobalFeedCubit({
    required this.feedPostsStream,
  }) : super(GlobalFeedInitial(searchOptions: AppConfigs.feedsSearchOptions)) {
    _init();
  }

  @override
  Future<void> close() {
    feedPostsStream.close();
    searchController?.dispose();
    _streamSubscription?.cancel();
    scrollController?.dispose();

    print("FeedCubit close");

    return super.close();
  }

  void showSearch(BuildContext context) {
    return BottomSheetService.showSearch(context, this);
  }

  void selectedSearchOption(int index, bool value) {
    final searchOptions = [...state.searchOptions];
    searchOptions[index] = searchOptions[index].copyWith(isSelected: value);
    emit(state.copyWith(searchOptions: searchOptions));

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

  void pickDateRange(BuildContext context) async {
    final rangeDate = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        builder: (context, widget) {
          return Theme(
            data: ThemeData.from(
              colorScheme: Theme.of(context).brightness == Brightness.light
                  ? ColorScheme.light(primary: Colors.black)
                  : ColorScheme.dark(primary: Colors.white),
            ),
            child: widget!,
          );
        });

    if (rangeDate != null) {
      emit(state.copyWith(dateRange: rangeDate));
    }
  }

  void executeSearch() {
    try {
      List<Note> notes = state.feedPosts.map((e) => Note.fromEvent(e)).toList();
      Set<Note> notesResults = {};

      final searchQuery = searchController?.text ?? "";
      for (final option in state.searchOptions.where((e) => e.isSelected)) {
        if (option.useSearchQuery) {
          if (searchQuery.isNotEmpty) {
            notesResults.addAll(option.searchFunction(notes, searchQuery));
          }
        } else {
          notesResults.addAll(option.searchFunction(notes, ""));
        }
      }

      if (state.dateRange != null) {
        notes = notes.where((note) {
          final dateRange = state.dateRange;
          if (dateRange == null) {
            return false;
          }

          final isAfter = note.event.createdAt.isAfter(dateRange.start);
          final isBefore = note.event.createdAt.isBefore(dateRange.end);

          return isAfter && isBefore;
        }).toList();
      }
      emit(state.copyWith(searchedFeedNotesPosts: notesResults.toList()));
    } catch (e) {
      print(e);
    }
  }

  void resetSearch() {
    searchController?.clear();
    emit(
      state.copyWith(
        searchedFeedNotesPosts: [],
        dateRange: null,
        searchOptions: state.searchOptions
            .map((e) => e.copyWith(isSelected: false))
            .toList(),
        feedPosts: state.feedPosts,
      ),
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
        final sortedList = [event, ...state.feedPosts];
        sortedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        if (!isClosed) {
          emit(state.copyWith(feedPosts: sortedList.toList()));
        }

        if (shouldWaitXSecondsToUpdateFirstUI) {
          Future.delayed(Duration(milliseconds: 1000), () {
            showNewestPostsToUI();
            shouldWaitXSecondsToUpdateFirstUI = false;
          });
        }
      },
    );
  }

  void showNewestPostsToUI() {
    emit(state.copyWith(shownFeedPosts: state.feedPosts));
  }

  void goTop() {
    scrollController?.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
