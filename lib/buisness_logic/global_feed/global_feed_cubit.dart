import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../constants/configs.dart';
import '../../model/note.dart';
import '../../model/search_option.dart';
import '../../services/bottom_sheet/bottom_sheet.dart';

part 'global_feed_state.dart';

class FeedCubit extends Cubit<GlobalFeedState> {
  TextEditingController? searchController;
  Stream<NostrEvent> feedPostsStream;
  StreamSubscription? _streamSubscription;
  ScrollController? scrollController;

  FeedCubit({
    required this.feedPostsStream,
  }) : super(GlobalFeedInitial(searchOptions: AppConfigs.feedsSearchOptions)) {
    _init();
  }

  @override
  Future<void> close() {
    searchController?.dispose();
    _streamSubscription?.cancel();
    scrollController?.dispose();

    print("FeedCubit close");
    return super.close();
  }

  void _handleStreams() {
    _streamSubscription = feedPostsStream.listen(
      (event) {
        final sortedList = [...state.feedPosts, event].reversed.toList();
        sortedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        if (!isClosed) {
          emit(state.copyWith(feedPosts: sortedList));
        }
      },
    );
  }

  void showSearch(BuildContext context) {
    BottomSheetService.showSearch(context, this);
  }

  void selectedSearchOption(int index, bool value) {
    final searchOptions = <SearchOption>[];

    for (int i = 0; i < state.searchOptions.length; i++) {
      final current = state.searchOptions[i];
      final isSelectedItem = i == index;

      if (isSelectedItem) {
        searchOptions.add(current.copyWith(isSelected: value));
      } else {
        searchOptions.add(current);
      }
    }

    emit(state.copyWith(searchOptions: searchOptions));
  }

  void pickDateRange(BuildContext context) async {
    final rangeDate = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );

    if (rangeDate != null) {
      emit(state.copyWith(dateRange: rangeDate));
    }
  }

  void executeSearch() {
    try {
      List<Note> notes = state.feedPosts.map((e) => Note.fromEvent(e)).toList();
      Set<Note> notesResults = {};

      for (final option in state.searchOptions.where((e) => e.isSelected)) {
        if (option.useSearchQuery) {
          if (searchController!.text.isNotEmpty) {
            notesResults
                .addAll(option.searchFunction(notes, searchController!.text));
          }
        } else {
          notesResults.addAll(option.searchFunction(notes, ""));
        }
      }

      if (state.dateRange != null) {
        notes = notes.where((note) {
          final isAfter = note.event.createdAt.isAfter(state.dateRange!.start);
          final isBefore = note.event.createdAt.isBefore(state.dateRange!.end);
          final isIncluded = isAfter && isBefore;

          return isIncluded;
        }).toList();
      }
      emit(state.copyWith(searchedFeedNotesPosts: notesResults.toList()));
    } catch (e) {
      print(e);
    }
  }

  void resetSearch() {
    searchController!.clear();
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
    scrollController!.addListener(() {
      if (scrollController!.position.pixels != 0) {
        emit(state.copyWith(shouldShowScrollToTopButton: true));
      } else {
        emit(state.copyWith(shouldShowScrollToTopButton: false));
      }
    });
    _handleStreams();
  }
}
