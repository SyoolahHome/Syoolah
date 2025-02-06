import 'package:bloc/bloc.dart';
import 'package:ditto/constants/app_enums.dart';
import 'package:ditto/model/phoenixD_outgoing_payment.dart';
import 'package:ditto/model/phoenixd_incoming_payment.dart';
import 'package:ditto/services/phoenixd/phoenixd.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'wallet_two_history_state.dart';

class WalletTwoHistoryCubit extends Cubit<WalletTwoHistoryState> {
  final List<WalletV2HistoryPaymentsType> tabs;

  WalletTwoHistoryCubit({
    required this.tabs,
  }) : super(WalletTwoHistoryInitial()) {
    _init();
  }

  List<Future<void>> futures({
    bool? isAll,
  }) {
    return <Future<void>>[
      _loadIncomingPayments(isAll: isAll),
      _loadOutgoingPayments(isAll: isAll),
    ];
  }

  Future<void> _init() async {
    await Future.wait(
      futures(),
    );
  }

  Future<void> reloadRequests({
    bool? isAll,
  }) async {
    await Future.wait(
      futures(isAll: isAll),
    );
  }

  Future<void> _loadIncomingPayments({
    bool? isAll,
  }) async {
    try {
      emit(state.copyWith(isIncomingLoading: true));

      final incomingPayments = await PhoenixD.instance.incomingPayments(
        all: isAll,
      );

      emit(state.copyWith(incomingPayments: incomingPayments));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      emit(state.copyWith(isIncomingLoading: false));
    }
  }

  Future<void> _loadOutgoingPayments({bool? isAll}) async {
    try {
      emit(state.copyWith(isOutgoingLoading: true));

      final outgoingPayments = await PhoenixD.instance.outgoingPayments(
        all: isAll,
      );

      emit(state.copyWith(outgoingPayments: outgoingPayments));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      emit(state.copyWith(isOutgoingLoading: false));
    }
  }

  Future<void> toggleShowingAll(bool value) async {
    emit(state.copyWith(isAll: value));

    await reloadRequests(isAll: state.isAll);
  }
}
