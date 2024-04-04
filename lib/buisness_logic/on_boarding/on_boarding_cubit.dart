import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../constants/app_annotations.dart';

part 'on_boarding_state.dart';

/// {@template on_boarding_cubit}
/// The responsible cubit about the on boarding UI.
/// {@endtemplate}
class OnBoardingCubit extends Cubit<OnBoardingState> {
  /// The text field controller where the user can search for users via pubkey or identifier.
  TextEditingController? searchController;

  /// The focus node of the [searchController].
  FocusNode? searchNodeFocus;

  final searchSubIds = <String>[];

  /// {@macro on_boarding_cubit}
  OnBoardingCubit() : super(OnBoardingState.initial()) {
    _init();
  }

  @override
  Future<void> close() {
    resetSearch();

    searchNodeFocus?.dispose();
    searchController?.dispose();

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
    final searchQuery = searchController?.text;
    if (searchQuery?.isEmpty ?? true) {
      return;
    }

    searchNodeFocus?.unfocus();
    closeAllOpenSearchSubs();

    if (searchQuery == null || searchQuery.isEmpty) {
      emit(state.copyWith(error: "searchQueryEmpty".tr()));

      return;
    }

    emit(state.copyWith(
      searchingForUser: true,
      searchQuery: searchQuery,
    ));

    Future.delayed(const Duration(seconds: 5), () {
      emit(state.copyWith(searchingForUser: false));
    });

    try {
      const requiredHexLength = 64;

      if (searchQuery.contains("@")) {
        const lengthOfEmailElems = 2;

        if (searchQuery.split("@").length != lengthOfEmailElems) {
          emit(state.copyWith(error: "invalidOnBoardingSearchInput".tr()));

          return;
        }

        final pubKey =
            await NostrService.instance.send.getPubKeyFromEmail(searchQuery);
        startListeningToUserMetadata(pubKey);
      } else if (searchQuery.length == requiredHexLength) {
        final pubKey = searchQuery;

        startListeningToUserMetadata(pubKey);
      } else {
        startNip50Search(searchQuery);
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      // emit(state.copyWith(searchingForUser: false));
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

  void closeAllOpenSearchSubs() {
    for (final subId in searchSubIds) {
      NostrService.instance.subs.close(subId);
    }

    searchSubIds.clear();
  }

  void startListeningToUserMetadata(String pubKey) {
    final sub = NostrService.instance.subs.userMetaData(
      userPubKey: pubKey,
    );

    searchSubIds.add(sub.subscriptionId);

    sub.stream.listen((event) {
      emit(state.copyWith(searchedUserEvents: {
        ...state.searchedUserEvents,
        pubKey: [event, ...state.searchedUserEvents[pubKey] ?? []],
      }));
    });
  }

  void startNip50Search(String searchQuery) {
    final sub = NostrService.instance.subs.nip50Search(
      searchQuery: searchQuery,
    );

    searchSubIds.add(sub.subscriptionId);

    sub.stream.listen((event) {
      emit(state.copyWith(searchedUserEvents: {
        ...state.searchedUserEvents,
        searchQuery: [event, ...state.searchedUserEvents[searchQuery] ?? []],
      }));
    });
  }
}
