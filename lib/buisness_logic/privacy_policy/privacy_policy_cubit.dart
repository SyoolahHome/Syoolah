import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// {@template privacy_policy_cubit}
/// The responsible cubit about the privacy policy UI.
/// {@endtemplate}
class PrivacyPolicyCubit extends Cubit<bool> {
  /// The scroll controller of the privacy policy screen.
  ScrollController? privacyScrollController;

  /// {@macro privacy_policy_cubit}
  PrivacyPolicyCubit() : super(false) {
    privacyScrollController = ScrollController();
  }

  @override
  Future<void> close() {
    privacyScrollController?.dispose();

    return super.close();
  }

  /// Toggles the acceptance of the privacy policy by the user.
  bool toggle() {
    emit(!state);

    return state;
  }
}
