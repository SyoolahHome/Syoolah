import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'on_boarding_state.dart';

/// {@template on_boarding_cubit}
/// The responsible cubit about the on boarding UI.
/// {@endtemplate}
class OnBoardingCubit extends Cubit<OnBoardingState> {
  /// The text field controller where the user can search for users via pubkey or identifier.
  TextEditingController? searchController;

  /// The focus node of the [searchController].
  FocusNode? searchNodeFocus;

  /// The Nostr stream for the user metadata.
  NostrEventsStream? userStream;

  /// The stream subscription for the [userStream.stream].
  StreamSubscription? userSearchSub;

  /// {@macro on_boarding_cubit}
  OnBoardingCubit() : super(OnBoardingState.initial()) {
    _init();
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

  /// Shows the search bottom sheet.
  void showSearchSheet(BuildContext context) {
    BottomSheetService.showOnBoardingSearchSheet(context);
  }

  /// Shows the relays bottom sheet.
  void showRelaysSheet(BuildContext context) {
    BottomSheetService.showOnBoardingRelaysSheet(context);
  }

  /// Executes the search functioality using the [searchController] input.
  /// if the controller is not initialized, it does nothing.
  /// if the controller text is empty, it does nothing.
  /// TODO: rafactor and clarify more this code.
  Future<void> executeSearch() async {
    searchNodeFocus?.unfocus();

    _restartSubscription();

    String pubKey;
    final searchQuery = searchController?.text;

    if (searchQuery == null || searchQuery.isEmpty) {
      emit(state.copyWith(error: "searchQueryEmpty".tr()));

      return;
    }

    if (searchQuery.contains("@")) {
      const lengthOfEmailElems = 2;

      if (searchQuery.split("@").length != lengthOfEmailElems) {
        emit(state.copyWith(error: "invalidOnBoardingSearchInput".tr()));

        return;
      }
      pubKey = await NostrService.instance.send.getPubKeyFromEmail(searchQuery);
    } else {
      const requiredHexLength = 64;
      if (searchQuery.length != requiredHexLength) {
        emit(state.copyWith(error: "invalidIdentifierOrPubKey".tr()));

        return;
      }

      pubKey = searchQuery;
    }

    try {
      userStream = NostrService.instance.subs.userMetadata(pubKey);
      userSearchSub = userStream!.stream.listen(
        (event) {
          emit(state.copyWith(searchedUser: event));
        },
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith());
    }
  }

  /// Resets the search functionality.
  void resetSearch() {
    searchController?.clear();
    emit(state.copyWith());
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

  Future<void> _restartSubscription() async {
    if (userSearchSub != null) {
      await userSearchSub?.cancel();
      userSearchSub = null;
    }
  }
}
