import 'package:bloc/bloc.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  void showSearchSheet(BuildContext context) {
    BottomSheetService.showOnBoardingSearchSheet(context);
  }

  void showRelaysSheet(BuildContext context) {
    BottomSheetService.showOnBoardingRelaysSheet(context);
  }
}
