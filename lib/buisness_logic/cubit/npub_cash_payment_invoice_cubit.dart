import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'npub_cash_payment_invoice_state.dart';

class NpubCashPaymentInvoiceCubit extends Cubit<NpubCashPaymentInvoiceState> {
  Timer? timer;

  final String invoice;
  final String paymentToken;
  final String fullDomain;
  final String username;
  final NostrKeyPairs keyPair;

  NpubCashPaymentInvoiceCubit({
    required this.invoice,
    required this.paymentToken,
    required this.fullDomain,
    required this.username,
    required this.keyPair,
  }) : super(NpubCashPaymentInvoiceInitial()) {
    _startCheckTimer();
  }

  void _startCheckTimer() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _checkIfPaid();
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();

    return super.close();
  }

  Future<void> _checkIfPaid() async {
    try {
      final endpoint = "$fullDomain" + "/api/v1/info/username";

      final token = NostrAuthService.requestToken(
        keyPair: keyPair,
        endpoint: endpoint,
        method: "PUT",
      );

      final res = await http.put(
        Uri.parse(endpoint),
        headers: {
          "Authorization": "Nostr $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "username": username,
          "paymentToken": paymentToken,
        }),
      );

      if (res.statusCode == 200) {
        emit(state.copyWith(
          paidSuccessfully: true,
        ));
      }
    } catch (e) {
      //nothing
    }
  }
}
