import 'package:bloc/bloc.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lnd_state.dart';

class LndCubit extends Cubit<LndState> {
  TextEditingController? usernameController;

  LndCubit() : super(LndInitial()) {
    _init();
  }

  Future<void> close() {
    usernameController?.dispose();

    return super.close();
  }

  void onCreateAdressClick(BuildContext context) {
    BottomSheetService.createLndAddress(this, context);
  }

  _init() {
    usernameController = TextEditingController();
  }
}
