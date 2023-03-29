import 'package:bloc/bloc.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/strings.dart';
import '../../services/database/local/local.dart';

part 'private_key_gen_success_state.dart';

class PrivateKeyGenSuccessCubit extends Cubit<PrivateKeyGenSuccessState> {
  PrivateKeyGenSuccessCubit()
      : super(PrivateKeyGenSuccessInitial(
          privateKey: LocalDatabase.instance.getPrivateKey(),
        ));

  void togglePrivateKeyFieldVisibility() {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    ));
  }

  void copyPrivateKey(BuildContext context) async {
    try {
      await Clipboard.setData(ClipboardData(text: state.privateKey));
      SnackBars.text(context, AppStrings.privateKeyCopied);
    } catch (e) {
      SnackBars.text(context, e.toString());
    }
  }
}
