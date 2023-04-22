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
    if (userSearchSub != null) {
      userSearchSub!.cancel();
      userSearchSub = null;
    }
    String pubKey;
    if (searchController!.text.contains("@")) {
      pubKey = await NostrService.instance
          .getPubKeyFromEmail(searchController!.text);
    } else {
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
      print(e);
    }
  }

  void resetSearch() {
    searchController!.clear();
    emit(state.copyWith(searchedUser: null));
  }
}
