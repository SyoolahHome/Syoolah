import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:crypto/crypto.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:ditto/services/zaplocker/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hex/hex.dart';
import 'package:http/http.dart' as http;
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart' as pointycastle;

import '../../model/pending.dart';
import '../../services/zaplocker/temporaryçnip04.dart';

part 'lnd_state.dart';

class LndCubit extends Cubit<LndState> {
  TextEditingController? usernameController;
  late ZapLockerReflectedUtils zaplocker;

  LndCubit() : super(LndInitial(domain: "sakhir.me")) {
    _init();
    zaplocker = ZapLockerReflectedUtils("");
  }

  Future<void> close() {
    usernameController?.dispose();

    return super.close();
  }

  void onCreateAdressClick(BuildContext context) {
    BottomSheetService.createLndAddress(this, context);
  }

  _init() {
    usernameController = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(username: usernameController!.text));
      });
  }

  void createAddress({
    required Null Function() onSuccess,
  }) async {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;
    final derivedPublicKey = Nostr.instance.keysService.derivePublicKey(
      privateKey: privateKey,
    );
    try {
      emit(state.copyWith(isLoading: true));
      await _createLndAddress(derivedPublicKey);
      onSuccess();
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _createLndAddress(String userPubkey) async {}

  Future<void> login({
    required String userPublicKey,
    required void Function() onStartLoadingUser,
    required void Function() onEndLoadingUser,
    required void Function(Map<String, dynamic> userData) onUserDataLoaded,
    required void Function() onUserDataNotLoaded,
    required void Function() onRelaysSigIsUnverifiedAndShouldNotBeUsed,
    required void Function() onRelaysSigIsVerifiedAndShouldBeUsed,
  }) async {
    onStartLoadingUser();
    final userData = await zaplocker.getUserData(userPublicKey);
    onEndLoadingUser();

    if (userData != null) {
      onUserDataLoaded(userData);
      final privateKey = LocalDatabase.instance.getPrivateKey()!;

      await loadUser(
        userPrivKey: privateKey,
        userPubkey: userPublicKey,
        userData: userData,
        onRelaysSigIsUnverifiedAndShouldNotBeUsed:
            onRelaysSigIsUnverifiedAndShouldNotBeUsed,
        onRelaysSigIsVerifiedAndShouldBeUsed:
            onRelaysSigIsVerifiedAndShouldBeUsed,
      );
    } else {
      onUserDataNotLoaded();
      // await createUser();
    }
  }

  Future<void> loadUser({
    required String userPubkey,
    required String userPrivKey,
    required Map<String, dynamic> userData,
    required void Function() onRelaysSigIsUnverifiedAndShouldNotBeUsed,
    required void Function() onRelaysSigIsVerifiedAndShouldBeUsed,
  }) async {
    bool v2 = false;

    final username = userData["username"];
    final lndaddress = username + "@" + state.domain;

    final paycodeHexBytes = zaplocker.hexToBytes(
      zaplocker
          .textTohex("https//${state.domain}/.well-known/lnurlp/$username"),
    );

    final paycodeHexEncoded = HEX.encode(paycodeHexBytes);

    final paycode = Nostr.instance.utilsService
        .encodeBech32(
          paycodeHexEncoded,
          "lnurl",
        )
        .toUpperCase();

    emit(state.copyWith(
      username: username,
      lndAddress: lndaddress,
      paycode: paycode,
    ));

    final relays = userData["relays_array"];
    final relaysSig = userData["relays_sig"];

    if (relays != null && relays is List) {
      v2 = true;

      emit(state.copyWith(relays: relays, relaysSig: relaysSig));

      final sigIsGood = await _verifyRelaysSig(
        relays: relays,
        relaysSig: relaysSig,
        userPubkey: userPubkey,
      );

      if (!sigIsGood) {
        onRelaysSigIsUnverifiedAndShouldNotBeUsed();

        return;
      } else {
        onRelaysSigIsVerifiedAndShouldBeUsed();
      }
    }

    final nip04 = Nip04Impl();

    final cipherText = userData["ciphertext"];

    final preimages = nip04.decrypt(
      userPrivKey,
      userPubkey,
      cipherText,
    );

    final pending = userData["pending"] as List?;

    if (pending == null || pending.isEmpty) {
      return;
    } else {
      final nonNullablePending = pending as List;

      for (int index = 0; index > nonNullablePending.length; index++) {
        final pending_pmt = nonNullablePending[index];
        var pmthash = pending_pmt["pmthash"];
        var matching_preimage;

        RegExp exp = RegExp(".{1,64}");
        final matches = exp.allMatches(preimages).toList();

        for (int matchIndex = 0; matchIndex < matches.length; matchIndex++) {
          final preimage = matches[matchIndex].group(0);
          //! 311
          //  zaplocker.bytesToHex()
          final hash = "";

          if (hash == pmthash) {
            matching_preimage = preimage;
            break;
          }
        }

        pending_pmt["preimage"] = matching_preimage;
        userData["pending"][index] = pending_pmt;

        final currentBlockHeight = await zaplocker.getBlockheight("");
        print("currentBlockHeight: $currentBlockHeight");

        final blocksTilExpiry = pending_pmt["expires"] - currentBlockHeight;

        final feeRate = await zaplocker.getMinFeeRate();
        final tryParsed = int.tryParse(feeRate);
        if (tryParsed == null) {
          return;
        }

        final singleMiningFee = tryParsed * 200;
        final miningFee = tryParsed * 2 * 200;

        final amountExpectedInSwapAddress =
            pending_pmt["amount"] - pending_pmt["swap_fee"] - singleMiningFee;

        final amountExpected =
            pending_pmt["amount"] - pending_pmt["swap_fee"] - miningFee;

        final acmountExpectedLnurl =
            pending_pmt["amount"] - pending_pmt["swap_fee"];

        final newPending = PendingPayment(
          amount: pending_pmt["amount"],
          swapFee: pending_pmt["swap_fee"],
          miningFee: miningFee,
          amountExpected: amountExpected,
          blocksTilExpiry: blocksTilExpiry,
          pmtHash: pending_pmt["pmthash"],
          preimage: matching_preimage,
          serverPubKey: pending_pmt["server_pubkey"],
          amountExpectedInSwapAddress: amountExpectedInSwapAddress,
          amountExpectedLnurl: acmountExpectedLnurl,
          v2: v2,
        );

        emit(state.copyWith(
          pendingPayments: [...state.pendingPayments, newPending],
        ));
      }
    }
  }

  Future<bool> _verifyRelaysSig({
    required List relays,
    required String relaysSig,
    required String userPubkey,
  }) async {
    return await zaplocker.verifyrelays(
      relays: relays,
      signature: relaysSig,
      publicKey: userPubkey,
    );
  }

  Future<void> settleOnBaseLayer({
    required BuildContext context,
    required PendingPayment pending,
    required BuildContext Function() onRequestContext,
  }) async {
    var userAddress = await _promptUserForAddress(context);

    if (!await zaplocker.isValidAddress(userAddress)) {
      print("Please try again with a valid bitcoin address");
      return;
    }

    if (userAddress.startsWith("tb1p")) {
      print(
        "Please try again. That was a taproot address and taproot addresses are not supported yet.",
      );
      return;
    }

    final secureRandom = FortunaRandom();

    final keyGenerator = ECKeyGenerator();
    final keyParams = ECCurve_secp256k1();

    final keyGenParams = ECKeyGeneratorParameters(keyParams);
    keyGenerator.init(ParametersWithRandom(keyGenParams, secureRandom));

    final swapPrivKey = keyGenerator.generateKeyPair();
    final swapPubKey = swapPrivKey.publicKey;

    final blockHeight = await zaplocker.getBlockheight("");
    print("blockHeight: $blockHeight");

    final preImage = pending.preimage;

    final pmtHash = pmtHashFromPreimage(preImage);
    final serverPubKey = pending.serverPubKey;
    final timelock = blockHeight + 10;

    final witnessScript = await zaplocker.generateHtlc(
      serverPubkey: serverPubKey,
      userPubkey: swapPubKey.toString(),
      timelock: timelock,
      pmthash: pmtHash,
    );

    final htlcObject = await zaplocker.p2wsh(
      witnessScript: witnessScript,
    );

//! let this unawaited
    zaplocker.startSwap(
      swapPubKey: swapPubKey.toString(),
      address: htlcObject["address"],
      pmtHash: pmtHash,
    );

    final waitIsOver = await zaplocker.waitForMoneyToArriveInAddress(
      htlcObject["address"],
    );

    if (!waitIsOver) {
      print("Please try again. The swap timed out.");
      return;
    }

    final txArray = await zaplocker.addressReceivedMoneyInThisTx(
      htlcObject["address"],
    );

    final txid = txArray[0];
    final txindex = txArray[1];
    final amountReceived = txArray[2];

    final amountExpectedInSwapAddress = pending.amountExpectedInSwapAddress;

    if (double.parse(amountReceived) <
            double.parse(pending.amountExpectedInSwapAddress) &&
        (double.parse(amountReceived) -
                        double.parse(amountExpectedInSwapAddress))
                    .abs() /
                double.parse(amountExpectedInSwapAddress) >
            0.02) {
      bool showModalCondition = double.parse(amountReceived) ==
          double.parse(amountExpectedInSwapAddress);
      if (showModalCondition) {
        print(
            "Server tried to scam you, aborting trade! Amount received: $amountReceived Amount expected: $amountExpectedInSwapAddress Equality: $showModalCondition");
      }
    }

    print(
      "Amount received: $amountReceived Amount expected: $amountExpectedInSwapAddress Equality: ${double.parse(amountReceived) == double.parse(amountExpectedInSwapAddress)}",
    );

    final originalQuantityOfSats = amountReceived;
    final feerate = await zaplocker.getMinFeeRate();
    dynamic newQuantityOfSats = amountReceived - feerate * 200;

    if (newQuantityOfSats < 546) newQuantityOfSats = amountReceived - 200;

    var userPrivkey = swapPrivKey.toString();

    final txHex = await zaplocker.sweepingHTLC(
      txid: txid,
      txindex: txindex,
      original_quantity_of_sats: originalQuantityOfSats,
      new_quantity_of_sats: newQuantityOfSats,
      serverPubkey: pending.serverPubKey,
      preimage: pending.preimage,
      timelock: timelock,
      userPrivkey: userPrivkey,
      useraddress: userAddress,
      userPubkey: swapPubKey.toString(),
    );

    print("txHex: $txHex");
    // sessionStorage.removeItem("modal_cleared");

    showAlmostDoneModal(
      context: onRequestContext(),
      txid: txid,
    );

    final sweepTxid = await zaplocker.pushBTCpmt(txHex);

    print("sweepTxid: $sweepTxid");

    showTransactionSuccessModal(
      sweepTxid: sweepTxid,
      context: onRequestContext(),
    );
  }

  pmtHashFromPreimage(String preImage) {
    final hexToBytes = zaplocker.hexToBytes(preImage);
    final sha256 = SHA256Digest();
    final hash = sha256.process(Uint8List.fromList(hexToBytes));
    final bytesToHex = zaplocker.bytesToHex(hash);

    return bytesToHex;
  }

  void showAlmostDoneModal({
    required BuildContext context,
    required String txid,
  }) {
    AlertsService.showAlmostDoneModal(
      context: context,
      txid: txid,
    );
  }

  void showTransactionSuccessModal({
    required String sweepTxid,
    required BuildContext context,
  }) {
    AlertsService.showTransactionSuccessModal(
      context: context,
      sweepTxid: sweepTxid,
    );

    throw UnimplementedError();
  }

  void settleOverLightning({
    required BuildContext context,
    required PendingPayment pending,
    required void Function() onSettleSuccess,
    required void Function() onUndefinedError,
    required VoidCallback onSettleError,
  }) async {
    final preimage = pending.preimage;

    final userInvoice = await _promptUserForInvoice(
      context,
      amountExpectedLn: pending.amountExpectedLnurl,
      preimage: preimage,
      onSubmit: (String userInvoice) async {
        final status = await zaplocker.payInvoice(
          invoice: userInvoice,
        );
        print("status: $status");

        if (status.contains("success")) {
          onSettleSuccess();
        } else if (status.contains("undefined")) {
          onUndefinedError();
        } else {
          onSettleError();
        }
      },
    );
  }

  Future<String> _promptUserForAddress(BuildContext context) async {
    throw BottomSheetService.promptUserForAddress(context);
  }

  Future<String> _promptUserForInvoice(
    BuildContext context, {
    required String preimage,
    required int amountExpectedLn,
    required void Function(String) onSubmit,
  }) async {
    throw BottomSheetService.promptUserForInvoice(
      context: context,
      onSubmit: onSubmit,
    );
  }
}
