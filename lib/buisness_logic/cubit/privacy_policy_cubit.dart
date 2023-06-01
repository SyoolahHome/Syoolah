import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<bool> {
  PrivacyPolicyCubit() : super(false);

  bool toggle() {
    emit(!state);

    return state;
  }
}
