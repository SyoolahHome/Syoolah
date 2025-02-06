import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:ditto/constants/app_enums.dart';
import 'package:ditto/model/phoenixD_balance_res.dart';
import 'package:ditto/model/phoenixD_node_info.dart';
import 'package:ditto/services/12cash/12cash.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/phoenixd/phoenixd.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'wallet_version_two_state.dart';

class WalletVersionTwoCubit extends Cubit<WalletVersionTwoState> {
  WalletVersionTwoCubit() : super(WalletVersionTwoInitial()) {
    _init();
  }

  final domain = "syoolah.me";

  late final TextEditingController manualServerBaseUrlController;
  late final TextEditingController walletApiKeyPasswordController;

  List<Future<void>> get walletRelatedFutures {
    return <Future<void>>[
      _loadBalance(),
      _loadBolt12Offer(),
      _loadNodeInfo(),
    ];
  }

  Future<void> _loadBolt12Offer() async {
    try {
      emit(state.copyWith(isLoadingBolt12Offer: true));
      final newBolt12Offer = await PhoenixD.instance.getBolt12Offer();
      emit(state.copyWith(bolt12Offer: newBolt12Offer));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      emit(state.copyWith(isLoadingBolt12Offer: false));
    }
  }

  Future<void> _loadNodeInfo() async {
    try {
      emit(state.copyWith(isLoadingNodeInfo: true));
      final nodeInfo = await PhoenixD.instance.getNodeInfo();
      emit(state.copyWith(nodeInfo: nodeInfo));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      emit(state.copyWith(isLoadingNodeInfo: false));
    }
  }

  Future<void> _loadBalance() async {
    try {
      emit(state.copyWith(isLoadingBalance: true));
      final newBalanceRes = await PhoenixD.instance.getBalance();
      emit(state.copyWith(balance: newBalanceRes));
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      emit(state.copyWith(isLoadingBalance: false));
    }
  }

  Future<void> reloadRequests() {
    emit(state.copyWith(isReloadingAllRequests: true));
    return Future.wait(walletRelatedFutures).then((e) {
      emit(state.copyWith(isReloadingAllRequests: false));
    });
  }

  @override
  Future<void> close() {
    manualServerBaseUrlController.dispose();
    walletApiKeyPasswordController.dispose();

    return super.close();
  }

  @override
  void onChange(Change<WalletVersionTwoState> change) {
    final curr = change.currentState;
    final next = change.nextState;

    if (curr.walletServerBaseUrl != next.walletServerBaseUrl) {
      PhoenixD.setBaseUrl(next.walletServerBaseUrl ?? "");

      Future.wait(walletRelatedFutures);
    }

    if (curr.walletServerPassword != next.walletServerPassword) {
      PhoenixD.setPasswordKey(next.walletServerPassword ?? "");
    }

    super.onChange(change);
  }

  void _handleServerManualInputValidation(String textValue) {
    emit(state.copyWith(allowApplyButtonForServer: textValue.isNotEmpty));
  }

  void _init() async {
    manualServerBaseUrlController = TextEditingController();
    walletApiKeyPasswordController = TextEditingController();

    TwelveCash.setBaseUrl("https://$domain");

    _getBip353FromLocalCache();

    final credentialsFoundInCache =
        _getWalletCredentialsFromLocalCacheAndApplyIfAny();

    if (credentialsFoundInCache) {
      debugPrint(
          "Credentials found in cache, no need to prompt user for credentials");

      return;
    } else {
      manualServerBaseUrlController.addListener(() {
        return _handleServerManualInputValidation(
          manualServerBaseUrlController.text.trim(),
        );
      });

      walletApiKeyPasswordController.addListener(() {
        return _handleServerManualInputValidation(
          walletApiKeyPasswordController.text.trim(),
        );
      });

      // manualServerBaseUrlController.text = "http://10.0.2.2:9740";
      // walletApiKeyPasswordController.text =
      //     'd74728046b947b8e66bf62068f2ed208d144704eb0fe2ce6c9ac5d9e0edc23ef';
    }
  }

  Future<void> applyManualServerUrl() async {
    final url = manualServerBaseUrlController.text.trim();
    final apiKeyPassword = walletApiKeyPasswordController.text.trim();

    emit(state.copyWith(isLoadingServer: true));

    final isSavedToLocalCache = await _setWalletCredentialsToLocalCache(
      walletServerUrl: url,
      walletServerApiPassword: apiKeyPassword,
    );

    if (!isSavedToLocalCache) {
      debugPrint("server creedentials couldn't be cached.");
      return;
    }

    emit(
      state.copyWith(
        walletServerBaseUrl: url,
        walletServerPassword: apiKeyPassword,
      ),
    );

    emit(state.copyWith(isLoadingServer: false));
  }

  Future<void> requestBolt11Invoice(BuildContext context) async {
    try {
      final entry = await getPaymentInfo(context);

      int amountInSats = entry.$1;
      String description = entry.$2;

      emit(state.copyWith(isLoadingGeneratingBolt11Invoice: true));
      await Future.delayed(Duration(milliseconds: 500));

      final invoiceRes = await PhoenixD.instance.createBolt11Invoice(
        description: description,
        amountInSats: amountInSats,
      );

      emit(state.copyWith(isLoadingGeneratingBolt11Invoice: false));

      final invoice = invoiceRes.serialized;

      await BottomSheetService.presentTextValueAsQrCode(
        context,
        title: "Your Invoice ($amountInSats Sats)",
        value: invoice,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoadingGeneratingBolt11Invoice: false));
      _loadBalance();
    }
  }

  Future<void> payBolt12Invoice(BuildContext context) async {
    try {
      final bolt12Input =
          await BottomSheetService.promptUserForBolt12Offer(context);

      if (bolt12Input == null) {
        return;
      }

      final infoEntry = await getPaymentInfo(context);
      final amountInSats = infoEntry.$1;
      final description = infoEntry.$2;

      final paymentRes = await PhoenixD.instance.payBol12Offer(
        amountInSats: amountInSats,
        message: description,
        bolt12Offer: bolt12Input,
      );

      debugPrint(paymentRes.toString());
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<(int, String)> getPaymentInfo(
    BuildContext context, {
    bool enableMessageField = true,
  }) async {
    final infoEntry =
        await BottomSheetService.getBolt11InvoiceAmountAndDescription(
      context,
      enableMessageField: enableMessageField,
      initialDescription: "",
    );

    if (infoEntry == null) {
      throw Exception("User cancelled the operation");
    }

    return (infoEntry.$1, infoEntry.$2);
  }

  Future<void> showReusableBolt12Offer(BuildContext context) async {
    try {
      final bolt12Offer = state.bolt12Offer;

      if (bolt12Offer == null) {
        throw Exception("No bolt12 offer available");
      }

      await BottomSheetService.presentTextValueAsQrCode(
        context,
        title: "Your Bolt12 Offer (Reusable)",
        value: bolt12Offer,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      _loadBalance();
    }
  }

  Future<void> promptUserToSelectDepositMethod(
    BuildContext Function() onContextGet,
  ) async {
    final depositMethodType =
        await BottomSheetService.promptUserToSelectDepositMethod(
      onContextGet(),
    );

    if (depositMethodType == null) {
      return;
    }

    switch (depositMethodType) {
      case WalletV2DepositType.createInvoiceWithBol11:
        requestBolt11Invoice(onContextGet());

        break;
      case WalletV2DepositType.showReusableBolt12OfferOrBip353Identifier:
        showReusableBolt12Offer(onContextGet());

        break;
    }
  }

  Future<void> promptUserToWithdrawMethod(
    BuildContext Function() onContextGet,
  ) async {
    try {
      emit(state.copyWith(isLoadingWithdraw: true));

      final withdrawMethodType =
          await BottomSheetService.promptUserToSelectWithdrawMethod(
        onContextGet(),
      );

      if (withdrawMethodType == null) {
        return;
      }

      switch (withdrawMethodType) {
        case WalletV2WithdrawType.formInput:
          final input = await BottomSheetService.promptUserWithWithdrawInput(
            onContextGet(),
          );

          if (input == null || input.trim().isEmpty) {
            return;
          }

          await handleWithDrawInput(
            onContextGet,
            input: input,
          );

          break;

        case WalletV2WithdrawType.qrCodeCameraScan:
          final inputFromScannedQrCode = await BottomSheetService.scanQrCode(
            onContextGet(),
          );

          if (inputFromScannedQrCode == null ||
              inputFromScannedQrCode.trim().isEmpty) {
            return;
          }

          await handleWithDrawInput(
            onContextGet,
            input: inputFromScannedQrCode,
          );
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      _loadBalance();
      emit(state.copyWith(isLoadingWithdraw: false));
    }
  }

  Future<void> handleWithDrawInput(
    BuildContext Function() onGetContext, {
    required String input,
  }) async {
    try {
      final splitByAt = input.split("@");

      if (splitByAt.length == 2) {
        final username = splitByAt.first;
        final domain = splitByAt.last;

        await _handleWithdrawFromLightningOrBip353Address(
          username: username,
          domain: domain,
          onGetContext: onGetContext,
        );
      }

      final isBolt11Invoice = input.startsWith("lnbc") ||
          input.startsWith("lntb") ||
          input.startsWith("lightning:");

      //! maybe try decode it here.

      if (isBolt11Invoice) {
        final toUse = input.startsWith("lightning:")
            ? input.substring("lightning:".length)
            : input;

        await _handleWithdrawFromBolt11Invoice(
          onGetContext: onGetContext,
          bolt11Invoice: toUse,
        );
      }

      final isBolt12Offer = input.startsWith("lno");

      if (isBolt12Offer) {
        await _handleWithdrawFromBolt12Offer(
          onGetContext: onGetContext,
          bolt12Offer: input,
        );
      }

      await _notifyAboutUnsupporedWithdrawMethod();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {}
  }

  Future<void> _handleWithdrawFromLightningOrBip353Address({
    required String username,
    required String domain,
    required BuildContext Function() onGetContext,
  }) async {
    final payInfo = await getPaymentInfo(onGetContext());
    final message = payInfo.$2;
    final amountInSats = payInfo.$1;

    final payResponse =
        await PhoenixD.instance.payLightningAddressOrBip353Identifier(
      address: "$username@$domain",
      message: message,
      amountInSats: amountInSats,
    );

    debugPrint(payResponse.toString());
  }

  Future<void> _handleWithdrawFromBolt11Invoice({
    required BuildContext Function() onGetContext,
    required String bolt11Invoice,
  }) async {
    //! Get decoded invoice and lock amount if any.

    final payInfo = await getPaymentInfo(
      onGetContext(),
      enableMessageField: false,
    );

    final amountInSats = payInfo.$1;

    final payResponse = await PhoenixD.instance.payBolt11Invoice(
      bolt11Invoice: bolt11Invoice,
      amountInSats: amountInSats,
    );

    debugPrint(payResponse.toString());
  }

  Future<void> _handleWithdrawFromBolt12Offer({
    required BuildContext Function() onGetContext,
    required String bolt12Offer,
  }) async {
    final payInfo = await getPaymentInfo(
      onGetContext(),
    );

    final amountInSats = payInfo.$1;

    final message = payInfo.$2;

    final payResponse = await PhoenixD.instance.payBol12Offer(
      bolt12Offer: bolt12Offer,
      amountInSats: amountInSats,
      message: message,
    );

    debugPrint(payResponse.toString());
  }

  Future<void> _notifyAboutUnsupporedWithdrawMethod() async {}

  Future<void> showNodeInfo(BuildContext context) async {
    final nodeInfo = state.nodeInfo;
    if (nodeInfo == null) {
      debugPrint("No node info available");

      return;
    }

    await BottomSheetService.presentNodeInfo(
      context,
      nodeInfo: nodeInfo,
    );
  }

  Future<void> startCustomBip353UsrenameResreveProcess({
    required BuildContext Function() onContextGet,
  }) async {
    try {
      emit(state.copyWith(isBip353Loading: true));

      // final usernameInput = await BottomSheetService.tryClaimNpubCashUsername(
      //   onContextGet(),
      //   domain: domain,
      // );

      // if (usernameInput == null || usernameInput.trim().isEmpty) {
      //   return;
      // }

      await _bindAndReserveUsernameToBolt12Offer(
        onContextGet: onContextGet,
        //  username: usernameInput,
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isBip353Loading: false));
    }
  }

  Future<void> _bindAndReserveUsernameToBolt12Offer({
    required BuildContext Function() onContextGet,
  }) async {
    final bolt12Offer = state.bolt12Offer;
    final names = [
      'Aiden',
      'Bella',
      'Caleb',
      'Diana',
      'Ethan',
      'Fiona',
      'George',
      'Hannah',
      'Isaac',
      'Jasmine',
      'Kevin',
      'Luna',
      'Mason',
      'Nina',
      'Oscar',
      'Piper',
      'Quinn',
      'Riley',
      'Sophia',
      'Tyler',
      'Uma',
      'Victor',
      'Willow',
      'Xander',
      'Yara',
      'Zane',
    ];

    final randomName = names[Random().nextInt(names.length - 1)];
    final anotherRandom = names[Random().nextInt(names.length - 1)];

    final tmp = "$randomName.$anotherRandom@syoolah";

    _setBip353ToLocalCache(tmp);
    emit(state.copyWith(bip353Identifier: tmp));

    if (bolt12Offer == null || bolt12Offer.isEmpty) {
      throw Exception("No bolt12 offer available");
    }

    final res = await TwelveCash.instance.createUsername(
      bolt12Offer: bolt12Offer,
      domain: domain,
    );

    if (res.bip353.isNotEmpty) {
      _setBip353ToLocalCache(res.bip353);

      emit(state.copyWith(bip353Identifier: res.bip353));
    } else {
      throw Exception("No bip353 identifier available");
    }
  }

  bool _getWalletCredentialsFromLocalCacheAndApplyIfAny() {
    final walletServerFromCache =
        LocalDatabase.instance.getValue("walletServerUrl");

    final walletServerApiPassword =
        LocalDatabase.instance.getValue("walletServerApiPassword");

    final serverUrlExists =
        walletServerFromCache != null && walletServerFromCache.isNotEmpty;

    final serverPasswordExists =
        walletServerApiPassword != null && walletServerApiPassword.isNotEmpty;

    if (serverUrlExists && serverPasswordExists) {
      emit(
        state.copyWith(
          walletServerBaseUrl: walletServerFromCache,
          walletServerPassword: walletServerApiPassword,
        ),
      );
      return true;
    } else {
      return false;
    }
  }

  String? _getBip353FromLocalCache() {
    final bip353 = LocalDatabase.instance.getValue("bip353");

    if (bip353 != null && bip353.isNotEmpty) {
      emit(state.copyWith(bip353Identifier: bip353));
      return bip353;
    } else {
      return null;
    }
  }

  Future<bool> _setBip353ToLocalCache(String bip353) async {
    try {
      await LocalDatabase.instance.setValue("bip353", bip353);
      return true;
    } catch (e) {
      final err = e.toString();

      emit(state.copyWith(error: err));

      debugPrint(err);
      return false;
    }
  }

  Future<bool> _setWalletCredentialsToLocalCache({
    required String walletServerUrl,
    required String walletServerApiPassword,
  }) async {
    try {
      final futures = <Future<void>>[
        LocalDatabase.instance.setValue(
          "walletServerUrl",
          walletServerUrl,
        ),
        LocalDatabase.instance.setValue(
          "walletServerApiPassword",
          walletServerApiPassword,
        ),
      ];

      await Future.wait(futures);
      return true;
    } catch (e) {
      final err = e.toString();

      emit(state.copyWith(error: err));

      debugPrint(err);
      return false;
    }
  }

  void resetWallet() {
    LocalDatabase.instance.deleteValue("walletServerUrl");
    LocalDatabase.instance.deleteValue("walletServerApiPassword");
    LocalDatabase.instance.deleteValue("bip353");

    emit(WalletVersionTwoInitial());
  }
}
