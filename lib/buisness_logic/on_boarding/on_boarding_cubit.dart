import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  TextEditingController? searchController;
  FocusNode? searchNodeFocus;
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

  void _init() {
    searchNodeFocus = FocusNode();

    searchController = TextEditingController()
      ..addListener(() {
        final isNotEmpty = searchController!.text.isNotEmpty;
        final isEmail = searchController!.text.split("@").length == 2;
        final is64Hex = searchController!.text.length == 64;
        emit(
          state.copyWith(
              shouldShowSearchButton: isNotEmpty && (isEmail || is64Hex)),
        );
      });
  }

  Future<void> executeSearch() async {
    searchNodeFocus!.unfocus();
    if (userSearchSub != null) {
      userSearchSub!.cancel();
      userSearchSub = null;
    }
    String pubKey;
    if (searchController!.text.contains("@")) {
      if (searchController!.text.split("@").length != 2) {
        emit(
          state.copyWith(
            error:
                "the search query is not a valid identifier, it should be like an email",
          ),
        );
        return;
      }
      pubKey = await NostrService.instance
          .getPubKeyFromEmail(searchController!.text);
    } else {
      if (searchController!.text.length != 64) {
        emit(
          state.copyWith(
            error:
                "the search query is not a valid identifier or 64 hex string (pubkey)",
          ),
        );
        return;
      }
      pubKey = searchController!.text;
    }

    try {
      final userStream = NostrService.instance.userMetadata(pubKey);
      userSearchSub = userStream.listen(
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
    searchController!.clear();
    emit(state.copyWith(searchedUser: null));
  }

  @override
  Future<void> close() {
    searchNodeFocus!.dispose();
    searchController!.dispose();
    userSearchSub?.cancel();
    return super.close();
  }
}
