import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../model/note.dart';
import '../../model/search_option.dart';
import '../../services/bottom_sheet/bottom_sheet.dart';

part 'global_feed_state.dart';

class FeedCubit extends Cubit<GlobalFeedState> {
  TextEditingController? searchController;
  Stream<NostrEvent> feedPostsStream;
  StreamSubscription? _streamSubscription;

  FeedCubit({
    required this.feedPostsStream,
  }) : super(
          GlobalFeedInitial(
            searchOptions: [
              SearchOption(
                name: "Search usernames",
                isSelected: false,
                useSearchQuery: true,
                searchFunction: (noteList, string) => noteList
                    .where(
                      (note) => note.event.pubkey
                          .toLowerCase()
                          .contains(string.toLowerCase()),
                    )
                    .toList(),
              ),
              SearchOption(
                name: 'Search Posts contents',
                isSelected: false,
                useSearchQuery: true,
                searchFunction: (noteList, string) => noteList
                    .where(
                      (note) => note.event.content
                          .toLowerCase()
                          .contains(string.toLowerCase()),
                    )
                    .toList(),
              ),
              SearchOption(
                name: 'Search Posts dates',
                isSelected: false,
                useSearchQuery: true,
                searchFunction: (noteList, string) => noteList
                    .where(
                      (note) =>
                          note.event.createdAt.toString().contains(string) ||
                          note.event.createdAt.millisecondsSinceEpoch
                              .toString()
                              .contains(string),
                    )
                    .toList(),
              ),
              SearchOption(
                name: 'Search hashtags',
                useSearchQuery: true,
                isSelected: false,
                searchFunction: (noteList, string) => noteList
                    .where(
                      (note) => note.event.content
                          .toLowerCase()
                          .contains('#$string'.toLowerCase()),
                    )
                    .toList(),
              ),
              SearchOption(
                name: 'Only posts with images',
                isSelected: false,
                useSearchQuery: false,
                searchFunction: (noteList, string) => noteList
                    .where(
                      (note) => note.imageLinks.isNotEmpty,
                    )
                    .toList(),
              ),
            ],
          ),
        ) {
    searchController = TextEditingController();
    handleStreams();
  }

  @override
  Future<void> close() {
    searchController?.dispose();
    _streamSubscription?.cancel();
    return super.close();
  }

  void handleStreams() {
    _streamSubscription?.cancel();
    feedPostsStream.listen(
      (event) {
        final sortedList = [...state.feedPosts, event].reversed.toList();
        sortedList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        if (!isClosed) {
          emit(
            state.copyWith(
              feedPosts: sortedList,
            ),
          );
        }
      },
    );
  }

  void showSearch(BuildContext context) {
    BottomSheetService.showSearch(context, this);
  }

  void selectedSearchOption(int index, bool value) {
    List<SearchOption> searchOptions = [];

    for (int i = 0; i < state.searchOptions.length; i++) {
      if (i == index) {
        searchOptions.add(
          state.searchOptions[i].copyWith(
            isSelected: value,
          ),
        );
      } else {
        searchOptions.add(state.searchOptions[i]);
      }
    }

    emit(
      state.copyWith(searchOptions: searchOptions),
    );
  }

  void pickDateRange(BuildContext context) async {
    final rangeDate = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );

    if (rangeDate != null) {
      emit(
        state.copyWith(
          dateRange: rangeDate,
        ),
      );
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
          return note.event.createdAt.isAfter(state.dateRange!.start) &&
              note.event.createdAt.isBefore(state.dateRange!.end);
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
}
