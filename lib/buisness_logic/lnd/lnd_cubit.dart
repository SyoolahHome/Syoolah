import 'dart:convert';
import 'dart:typed_data';
import 'package:bip39/bip39.dart' as bip39;

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
import 'package:pointycastle/export.dart';

import '../../model/pending.dart';
import '../../services/zaplocker/temporaryçnip04.dart';

part 'lnd_state.dart';

class LndCubit extends Cubit<LndState> {
  TextEditingController? usernameController;
  late ZapLockerReflectedUtils zaplocker;

  LndCubit() : super(LndInitial(domain: "sakhir.me")) {
    _init();
    zaplocker = ZapLockerReflectedUtils();
  }

  Future<void> close() {
    usernameController?.dispose();

    return super.close();
  }

  _init() {
    usernameController = TextEditingController()
      ..addListener(() {
        emit(state.copyWith(username: usernameController!.text));
      });
  }

  void startLndLoading() async {
    emit(state.copyWith(isLoading: true));

    final userPrivateKey = LocalDatabase.instance.getPrivateKey()!;

    final userPublicKey =
        Nostr.instance.keysService.derivePublicKey(privateKey: userPrivateKey);

    emit(state.copyWith(loadingMessages: [
      ...(state.loadingMessages ?? []),
      "Checking user data if it exists...",
    ]));

    final userData = await zaplocker.getUserData(userPublicKey);

    if (userData != null) {
      emit(state.copyWith(
        loadingMessages: [
          ...(state.loadingMessages ?? []),
          "User data exists, loading user data...",
        ],
        shouldLoadUser: true,
        userData: userData,
      ));
    } else {
      emit(state.copyWith(
        loadingMessages: [
          ...(state.loadingMessages ?? []),
          "User data does not exist, creating a new user...",
        ],
        shouldCreateUser: true,
      ));
    }
  }

  Future<void> loadUser({
    required void Function() onRelaysSigIsUnverifiedAndShouldNotBeUsed,
    required void Function() onRelaysSigIsVerifiedAndShouldBeUsed,
    required Map<String, dynamic> userData,
    required void Function(
      List pending,
      String preimages,
      bool v2,
      Map<String, dynamic> userData,
    ) onAllValidatedAndSuccess,
  }) async {
    final privateKey = LocalDatabase.instance.getPrivateKey()!;

    final userPublicKey =
        Nostr.instance.keysService.derivePublicKey(privateKey: privateKey);

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
        userPubkey: userPublicKey,
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
      privateKey,
      userPublicKey,
      cipherText,
    );

    final pending = userData["pending"] as List?;

    onAllValidatedAndSuccess(
      pending!,
      preimages,
      v2,
      userData,
    );
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
      relaysSig: relaysSig,
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

  Future<void> createUser({
    required void Function(String username) onChosenUsernameNotGood,
    required void Function() onChosenUsernameEmpty,
    required void Function() onStartCreatingUserAndLoading,
    required void Function() onTrialEventToRelayFailed,
    required void Function(Map<String, dynamic> userData)
        onUserCreatedSuccesfully,
    required String? username,
  }) async {
    final userPrivKey = LocalDatabase.instance.getPrivateKey()!;
    final userPubKey = Nostr.instance.keysService.derivePublicKey(
      privateKey: userPrivKey,
    );

    final wsRelay = "wss://relay.damus.io";

    if (username == null) {
      throw Exception("username is null");
    }

    username = username.trim().toLowerCase();

    if (username.isEmpty) {
      onChosenUsernameEmpty();

      return;
    }

    if (username.length > 60) {
      print("Please try again with a shorter username");
      onChosenUsernameNotGood(username);

      return;
    }

    final isUsernameGood = await zaplocker.isUsernameGood(username);

    if (!isUsernameGood) {
      print("Please try again with a valid username");
      onChosenUsernameNotGood(username);

      return;
    }

    if (wsRelay.isEmpty ||
        !wsRelay.startsWith("wss://") ||
        wsRelay.length < 10 ||
        !wsRelay.contains(".")) {
      print("Please try again with a valid relay");
      return;
    }

    // submit it.
    emit(state.copyWith(
      loadingMessages: [
        ...(state.loadingMessages ?? []),
        "Creating account with username $username...",
      ],
    ));

    final event = await NostrService.instance.zaplocker
        .createEventSignedByNewKeysToBeSent(
      message: "Test Message",
      recipientPubKey: userPubKey,
    );

    final didEventSentAndReceived =
        await NostrService.instance.zaplocker.eventWasReplayedTilSeen(
      event: event,
      relays: [wsRelay],
      triesToLookForEvent: 5,
    );

    if (!didEventSentAndReceived) {
      print("Please try again with a valid relay, the trial event failed");

      onTrialEventToRelayFailed();
      return;
    }

    String preimages = _generateThousandChainedBip39();
    String hashes = "";
    String sigs = "";

    RegExp regex = RegExp(".{1,64}");
    Iterable<RegExpMatch> split64lenghtsPreimages = regex.allMatches(preimages);

    if (split64lenghtsPreimages
        .any((element) => element.group(0)!.length != 64)) {
      throw Exception("A preimage match was null");
    }

    final userKeyPair = Nostr.instance.keysService
        .generateKeyPairFromExistingPrivateKey(userPrivKey);

    for (int index = 0; index < split64lenghtsPreimages.length; index++) {
      print(index);

      final preimage = split64lenghtsPreimages.elementAt(index).group(0);

      if (preimage == null) {
        throw Exception("A preimage match at index $index was null");
      }

      final hash = zaplocker
          .bytesToHex(sha256.convert(zaplocker.hexToBytes(preimage)).bytes);

      hashes += hash;

      String sig = NostrService.instance.zaplocker.signSchnorrHash(
        hash,
        userKeyPair,
      );

      // await Future.delayed(Duration(milliseconds: 50));

      sigs += sig;
    }

    final ciphertext = await NostrService.instance.utils.nip04Encrypt(
      pubKey: userPubKey,
      privKey: userPrivKey,
      text: preimages,
    );

    final relaysList = [wsRelay];
    final relaysListAsJson = jsonEncode(relaysList);

    final relaysHash = sha256.convert(utf8.encode(relaysListAsJson)).toString();

    final relaysSig = NostrService.instance.zaplocker
        .signSchnorrHash(relaysHash, userKeyPair);

    final lspPubkey = await zaplocker.getLspPubKey();
    final lspPubKeyHash =
        sha256.convert(zaplocker.hexToBytes(lspPubkey)).toString();

    final lspPubKeySig = NostrService.instance.zaplocker
        .signSchnorrHash(lspPubKeyHash, userKeyPair);

    final setUserRes = await zaplocker.setUser(
      ciphertext: ciphertext,
      relaysList: relaysList,
      relaysSig: relaysSig,
      lspPubKeySig: lspPubKeySig,
      hashes: hashes,
      sigs: sigs,
      username: username,
      lspPubKeyHash: lspPubKeyHash,
      relay: wsRelay,
      userPubKey: userPubKey,
    );

    if (setUserRes == "user created") {
      final userData = await zaplocker.getUserData(userPubKey);

      if (userData != null) {
        onUserCreatedSuccesfully(userData);
      } else {
        print("Please try again, the user was not created");
      }
    }
  }

  String _generateThousandChainedBip39() {
    String result = "";

    for (int index = 0; index < 1000; index++) {
      final generatedMnemonic = bip39.generateMnemonic(strength: 256);
      result += bip39.mnemonicToEntropy(generatedMnemonic);
    }

    return result;
  }
}
