import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<bool> {
  ScrollController? privacyScrollController;
  PrivacyPolicyCubit() : super(false) {
    privacyScrollController = ScrollController();
  }

  @override
  Future<void> close() {
    privacyScrollController?.dispose();

    return super.close();
  }

  bool toggle() {
    emit(!state);

    return state;
  }
}
