import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  TextEditingController? searchController;
  FocusNode? searchNodeFocus;
  NostrEventsStream? userStream;

  StreamSubscription? userSearchSub;
  OnBoardingCubit() : super(OnBoardingInitial()) {
    _init();
  }

  void showSearchSheet(BuildContext context) {
    BottomSheetService.showOnBoardingSearchSheet(context);
  }

  void showRelaysSheet(BuildContext context) {
    BottomSheetService.showOnBoardingRelaysSheet(context);
  }

  Future<void> executeSearch() async {
    searchNodeFocus?.unfocus();
    if (userSearchSub != null) {
      userSearchSub?.cancel();
      userSearchSub = null;
    }
    String pubKey;
    final searchQuery = searchController?.text;

    if (searchQuery == null || searchQuery.isEmpty) {
      emit(state.copyWith(error: "search query is empty"));

      return;
    }

    if (searchQuery.contains("@")) {
      final lengthOfEmailElems = 2;

      if (searchQuery.split("@").length != lengthOfEmailElems) {
        emit(
          state.copyWith(
            error:
                "the search query is not a valid identifier, it should be like an email",
          ),
        );

        return;
      }
      pubKey = await NostrService.instance.getPubKeyFromEmail(searchQuery);
    } else {
      final requiredHexLength = 64;
      if (searchQuery.length != requiredHexLength) {
        emit(
          state.copyWith(
            error:
                "the search query is not a valid identifier or 64 hex string (pubkey)",
          ),
        );

        return;
      }
      pubKey = searchQuery;
    }

    try {
      userStream = NostrService.instance.userMetadata(pubKey);
      userSearchSub = userStream!.stream.listen(
        (event) {
          emit(state.copyWith(searchedUser: event));
        },
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  void resetSearch() {
    searchController?.clear();
    emit(state.copyWith(searchedUser: null));
  }

  @override
  Future<void> close() {
    resetSearch();
    userStream?.close();
    searchNodeFocus?.dispose();
    searchController?.dispose();
    userSearchSub?.cancel();

    return super.close();
  }

  void _init() {
    searchNodeFocus = FocusNode();

    searchController = TextEditingController()
      ..addListener(() {
        final isNotEmpty = searchController?.text.isNotEmpty;
        final isEmail = searchController?.text.split("@").length == 2;
        final is64Hex = searchController?.text.length == 64;
        emit(
          state.copyWith(
            shouldShowSearchButton:
                (isNotEmpty ?? true) && (isEmail || is64Hex),
          ),
        );
      });
  }
}
