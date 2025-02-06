import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/e_cash_user_info.dart';
import 'package:ditto/presentation/lnd/widgets/npub_cash_proofs_claim_render.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

part 'lnd_view_state.dart';

class LndViewCubit extends Cubit<LndViewState> {
  LndViewCubit({
    required this.keyPair,
  }) : super(LndViewInitial()) {
    _init();
  }

  final NostrKeyPairs keyPair;

  final domain = "npub.cash";

  String get fullDomain => "https://$domain";

  void _init() {
    final nPubKey =
        Nostr.instance.keysService.encodePublicKeyToNpub(keyPair.public);

    emit(state.copyWith(
      npub: nPubKey,
    ));

    _getBalance();
    _getInfo();
  }

  Future<void> _getBalance() async {
    try {
      final endpoint = "$fullDomain" + "/api/v1/balance";

      final token = NostrAuthService.requestToken(
        endpoint: endpoint,
        keyPair: keyPair,
      );

      final res = await http.get(
        Uri.parse(endpoint),
        headers: {
          "Authorization": "Nostr $token",
        },
      );

      if (res.statusCode == 200) {
        final data = res.body;
        final asMap = jsonDecode(data) as Map<String, dynamic>;

        final maybeBalance = asMap["data"];

        final balance = maybeBalance is int
            ? maybeBalance
            : int.tryParse(maybeBalance.toString());

        emit(state.copyWith(
          balance: balance,
          balanceFetched: balance != null,
        ));
      } else {
        throw Exception("Failed to get balance");
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  Future<void> _getInfo() async {
    try {
      final endpoint = "$fullDomain" + "/api/v1/info";

      final token = NostrAuthService.requestToken(
        keyPair: keyPair,
        endpoint: endpoint,
      );

      final res = await http.get(
        Uri.parse(endpoint),
        headers: {
          "Authorization": "Nostr $token",
        },
      );

      if (res.statusCode == 200) {
        final data = res.body;
        final asMap = jsonDecode(data) as Map<String, dynamic>;

        final userInfo = ECashUserInfo.fromMap(asMap);

        emit(state.copyWith(
          userInfo: userInfo,
          userInfoFetched: true,
        ));
      } else {
        throw Exception("Failed to get balance");
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  Future<void> startClaimUserName(BuildContext context, String username) async {
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
        }),
      );

      final body = res.body;
      final asMap = jsonDecode(body) as Map<String, dynamic>;
      final maybeError = asMap["error"];
      final errorMessage = asMap["message"];

      final paymentRequest = asMap["data"]["paymentRequest"];
      final paymentToken = asMap["data"]["paymentToken"];

      if (res.statusCode == 402 && paymentRequest != null) {
        emit(state.copyWith(
          error: errorMessage ?? "Payment required",
        ));

        final isPaid = await BottomSheetService.showNpubCashPaymentRequest(
          context,
          invoice: paymentRequest,
          paymentToken: paymentToken,
          fullDomain: fullDomain,
          keyPair: keyPair,
          username: username,
        );

        if (isPaid is bool && isPaid) {
          emit(state.copyWith(
            success: "Username claimed successfully",
            userInfo: state.userInfo?.copyWith(
              username: username,
            ),
          ));
        }
      } else if ((maybeError is bool && maybeError) || res.statusCode == 400) {
        throw Exception(errorMessage ?? "Failed to claim username");
      } else if (res.statusCode == 200) {
        emit(state.copyWith(
          userInfo: state.userInfo?.copyWith(
            username: username,
          ),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  Future<void> callClaim(
    BuildContext context, {
    required ProofsType type,
  }) async {
    try {
      final endpoint = "$fullDomain" + "/api/v1/claim";

      final token = NostrAuthService.requestToken(
        keyPair: keyPair,
        endpoint: endpoint,
      );

      final res = await http.get(
        Uri.parse(endpoint),
        headers: {
          "Authorization": "Nostr $token",
        },
      );

      final decoded = jsonDecode(res.body) as Map<String, dynamic>;

      final ret = await BottomSheetService.handleProofsRenderingFromResponse(
        context,
        type: type,
        statusCode: res.statusCode,
        data: decoded,
        keyPair: keyPair,
        fullDomain: fullDomain,
      );
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  void openPaymentView(BuildContext context) async {
    await BottomSheetService.openPaymentPageAndQrCode(
      context,
      address: "${state.npub}@$domain",
    );
  }

  Future<void> editMintUrl(BuildContext context) async {
    final mintUrl = await BottomSheetService.promptNewMintUrl(
      context,
      defaultMint: state.userInfo?.mintUrl,
    );

    if (mintUrl == null || mintUrl.isEmpty) {
      return;
    }

    try {
      final endpoint = "$fullDomain" + "/api/v1/info/mint";

      final payload = jsonEncode({
        "mintUrl": mintUrl,
      });

      final token = NostrAuthService.requestToken(
        keyPair: keyPair,
        endpoint: endpoint,
        method: "PUT",
        // payload: payload,
      );

      final res = await http.put(
        Uri.parse(endpoint),
        headers: {
          "Authorization": "Nostr $token",
          "Content-Type": "application/json",
        },
        body: payload,
      );

      if (res.statusCode > 200 && res.statusCode < 300) {
        emit(state.copyWith(
          userInfo: state.userInfo?.copyWith(
            mintUrl: mintUrl,
          ),
        ));
      } else {
        throw Exception("Failed to update mint url");
      }
    } catch (e) {
      emit(state.copyWith(
        error: e.toString(),
      ));
    } finally {
      emit(state.copyWith(error: null));
    }
  }
}
