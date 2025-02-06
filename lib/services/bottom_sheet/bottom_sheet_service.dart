import 'dart:math';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/chat_message.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/model/phoenixD_node_info.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/presentation/add_relay/add_relay.dart';
import 'package:ditto/presentation/feeds/widgets/search.dart';
import 'package:ditto/presentation/general/pattern_widget.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/lnd/widgets/mint_url_prompt.dart';
import 'package:ditto/presentation/lnd/widgets/npub_cash_claim_username.dart';
import 'package:ditto/presentation/lnd/widgets/npub_cash_payment_invoice.dart';
import 'package:ditto/presentation/lnd/widgets/npub_cash_payment_page.dart';
import 'package:ditto/presentation/lnd/widgets/npub_cash_proofs_claim_render.dart';
import 'package:ditto/presentation/mnemonic_words_backup/mnemonic_words_backup.dart';
import 'package:ditto/presentation/new_post/add_new_post.dart';
import 'package:ditto/presentation/private_succes/private_key.dart';
import 'package:ditto/presentation/private_succes/private_key_gen_success.dart';
import 'package:ditto/presentation/profile_options/profile_options.dart';
import 'package:ditto/presentation/mnemonic_words_backup/seed_phrase_deriver_to_private_key.dart';
import 'package:ditto/presentation/qr_code_scanner/qr_code_scanner.dart';
import 'package:ditto/presentation/wallet_v2/widgets/node_info_view.dart';
import 'package:ditto/presentation/wallet_v2/widgets/select_deposit_method.dart';
import 'package:ditto/presentation/wallet_v2/widgets/user_bolt11_prompt.dart';
import 'package:ditto/presentation/wallet_v2/widgets/user_bolt12_prompt.dart';
import 'package:ditto/presentation/wallet_v2/widgets/withdraw_manual_input.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:http/src/response.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../buisness_logic/lnd/lnd_cubit.dart';
import '../../constants/app_enums.dart';
import '../../model/translation_lang.dart';
import '../../presentation/general/widget/bottom_sheet_title_with_button.dart';
import '../../presentation/general/widget/margined_body.dart';
import '../../presentation/general/widget/note_card/wudgets/note_youtube_player.dart';
import '../../presentation/lnd/loading/widgets/username_input_widget.dart';
import '../../presentation/lnd/widgets/bottom_sheet_widget.dart';
import '../../presentation/lnd/widgets/lnd_invoice_adress_prompt copy.dart';
import '../../presentation/lnd/widgets/user_adress_prompt.dart';
import '../../presentation/onboarding_search/widgets/sheet_metadata.dart';
import '../../presentation/report/report.dart';
import '../../presentation/translation/widgets/widgets/langs_selection.dart';
import '../../presentation/voices_selection/voices_selection.dart';

abstract class BottomSheetService {
  static Future showCreatePostBottomSheet(
    BuildContext context, {
    String? initialNoteContent,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AddNewPost(
          initialNoteContent: initialNoteContent,
          expectMultiLine: true,
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future noteComments(
    BuildContext context, {
    required Note note,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return Container();
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future showSearch(BuildContext context, GlobalFeedCubit cubit) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return SearchSections(cubit: cubit);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showProfileBottomSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showNoteCardSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showAddRelaySheet({
    required BuildContext context,
    required Future<void> Function() onAdd,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AddRelayWidget(onAdd: onAdd);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showOnBoardingSearchSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AppUtils.instance
            .widgetFromRoutePath(Paths.onBoardingSearch, context);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showOnBoardingRelaysSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return AppUtils.instance
            .widgetFromRoutePath(Paths.onBoardingRelays, context);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showRelayOptionsSheet({
    required BuildContext context,
    required RelayConfiguration relay,
    required List<BottomSheetOption> options,
    RelayInformations? relayInformations,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title: relayInformations?.name != null
              ? "relayName".tr(args: [relayInformations!.name!])
              : "",
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showOnBoardingTranslationsSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title: "translations".tr(),
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showRouteAsBottomSheet(
    BuildContext context, {
    required String route,
    double? height,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return SizedBox(
          height: height,
          child: AppUtils.instance.widgetFromRoutePath(route, context),
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future showPrivateKeyGenSuccess(
    BuildContext context, {
    required VoidCallback onCopy,
    String? customText,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return PrivateKeyGenSuccess(
          onCopy: onCopy,
          customText: customText,
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
    );
  }

  static Future<void> showKey(
    BuildContext context, {
    required HiddenPrivateKeySectionType type,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          child: PrivateKey(
            type: type,
            title: type == HiddenPrivateKeySectionType.privateKey
                ? "myPrivateKey".tr()
                : "myNsecKey".tr(),
          ),
        );
      },
    );
  }

  static Future<void> showProfileFollowings(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showChatMessageOptionsSheet(
    BuildContext context, {
    required ChatMessage message,
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      builder: (context) {
        return BottomSheetOptionsWidget(
          options: options,
          title:
              '${message.message.substring(0, min(message.message.length, 20))}...',
        );
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static Future<void> showChatOptionsSheet(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
    );
  }

  static Future showYoututbeVideoBottomSheet(
    BuildContext context, {
    required String url,
    required VoidCallback onAccept,
    required VoidCallback onRemove,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,

      // isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return PatternScaffold(
          body: Container(
            padding: EdgeInsets.all(MarginedBody.defaultMargin.left),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BottomSheetTitleWithIconButton(title: "youtubeVideo".tr()),
                SizedBox(height: 15),
                NoteYoutubePlayer(url: url),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 35,
                      child: RoundaboutButton(
                        onTap: () {
                          onRemove();
                          Navigator.of(context).pop();
                        },
                        text: "remove".tr(),
                        isSmall: true,
                        isOnlyBorder: true,
                        mainColor: Colors.red,
                        icon: FlutterRemix.close_fill,
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: RoundaboutButton(
                        onTap: () {
                          onAccept();
                          Navigator.of(context).pop();
                        },
                        text: "accept".tr(),
                        isSmall: true,
                        mainColor: Colors.green,
                        icon: FlutterRemix.check_line,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showReportSheet(BuildContext context, Note note) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return ReportSheetWidget(
          note: note,
          noteCardContext: context,
        );
      },
    );
  }

  static void showWidgetAsBottomSheet(
    Widget screen,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return screen;
      },
    );
  }

  static void showOnBoardingSearchUserMetadataPropertiesSheet(
    BuildContext context, {
    required Iterable<MapEntry<String, dynamic>> properties,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return OnBoardingSearchUserMetadataPropertiesSheet(
          properties: properties,
        );
      },
    );
  }

  static Future<void> showCommentOptions(
    BuildContext context, {
    required List<BottomSheetOption> options,
  }) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheetOptionsWidget(options: options);
      },
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
    );
  }

  static void createLndAddress(LndCubit lndCubit, BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
      clipBehavior: Clip.hardEdge,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return LndAdressCreationWidget(
          lndCubit: lndCubit,
        );
      },
    );
  }

  static Future<String> promptUserForAddress(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return UserAddressPromptWidget();
      },
    );
  }

  static promptUserForInvoice({
    required BuildContext context,
    required void Function(String) onSubmit,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return UserLndInvoicePromptWidget(
          onSubmit: onSubmit,
        );
      },
    );
  }

  static Future<String?> promptUserForNewLndUsername({
    required BuildContext context,
  }) async {
    return showModalBottomSheet<String?>(
      context: context,
      builder: (context) {
        return UserLndUsernamePromptWidget();
      },
    );
  }

  static Future<TranslationLang?> showLangSelection(
    BuildContext context, {
    required TranslationLang? initialLang,
  }) {
    return showModalBottomSheet<TranslationLang>(
      context: context,
      builder: (context) {
        return LangsSelectionWidget(
          initial: initialLang,
        );
      },
    );
  }

  static Future<String?> getVoiceId(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      builder: (context) => ElevenLabsVoicesSelection(),
    );
  }

  static Future<bool?> mnemonicBackup({
    required BuildContext context,
    required String mnemonic,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MnemonicWordsBackUp(
          mnemonic: mnemonic,
        );
      },
    );
  }

  static Future<String?> privateKeyFromSeedPhrase(BuildContext context) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SeedPhrasePromptAndPrivateKeyDeriver();
      },
    );
  }

  static Future<String?> tryClaimNpubCashUsername(
    BuildContext context, {
    required String domain,
  }) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NpubCashClaimUsername(
          domain: domain,
        );
      },
    );
  }

  static Future<bool?> showNpubCashPaymentRequest(
    BuildContext context, {
    required String invoice,
    required String paymentToken,
    required String fullDomain,
    required NostrKeyPairs keyPair,
    required String username,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      builder: (context) {
        return NpubCashPaymentInvoice(
          invoice: invoice,
          paymentToken: paymentToken,
          fullDomain: fullDomain,
          keyPair: keyPair,
          username: username,
        );
      },
    );
  }

  static Future<dynamic> handleProofsRenderingFromResponse(
    BuildContext context, {
    required Map<String, dynamic> data,
    required int statusCode,
    required NostrKeyPairs keyPair,
    required String fullDomain,
    required ProofsType type,
  }) async {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NpubCashProofsClaimRender(
          type: type,
          data: data,
          statusCode: statusCode,
          keyPair: keyPair,
          fullDomain: fullDomain,
        );
      },
    );
  }

  static Future<dynamic> openPaymentPageAndQrCode(
    BuildContext context, {
    required String address,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MyNpubCashPaymentPage(
          address: address,
        );
      },
    );
  }

  static Future<String?> promptNewMintUrl(
    BuildContext context, {
    required String? defaultMint,
  }) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return MintUrlPrompt(
          defaultMint: defaultMint,
        );
      },
    );
  }

  static Future<(int, String)?> getBolt11InvoiceAmountAndDescription(
    BuildContext context, {
    required String initialDescription,
    required bool enableMessageField,
  }) async {
    return showModalBottomSheet<(int, String)>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return UserBolt11InvoicePrompt(
          initialDescription: initialDescription,
          enableMessageField: enableMessageField,
        );
      },
    );
  }

  static Future<void> presentTextValueAsQrCode(
    BuildContext context, {
    String? title,
    required String value,
  }) {
    final heightSpace = 10.0;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PatternScaffold(
          body: Builder(
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(MarginedBody.defaultMargin.left),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: heightSpace * 2),
                    BottomSheetTitleWithIconButton(
                      title: title ?? "",
                    ),
                    SizedBox(height: heightSpace * 2),
                    Center(
                      child: MarginedBody(
                        child: QrImageView(
                          data: value.toUpperCase(),
                          version: QrVersions.auto,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: heightSpace * 2),
                    SizedBox(
                      width: double.infinity,
                      child: RoundaboutButton(
                        text: "Copy to clipboard",
                        onTap: () {
                          AppUtils.instance.copy(
                            value,
                            onSuccess: () {
                              SnackBars.text(context, "Copied to clipboard!");
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(height: heightSpace * 2),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  static Future<String?> promptUserForBolt12Offer(BuildContext context) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return UserBolt12OfferPrompt();
      },
    );
  }

  static Future<WalletV2DepositType?> promptUserToSelectDepositMethod(
    BuildContext context,
  ) async {
    return showModalBottomSheet<WalletV2DepositType>(
      context: context,
      builder: (context) {
        return UserEnumSelection(
          title: "Select Your Deposit\nMethod",
          enumValues: WalletV2DepositType.values.toList(),
        );
      },
    );
  }

  static Future<WalletV2WithdrawType?> promptUserToSelectWithdrawMethod(
    BuildContext context,
  ) async {
    return showModalBottomSheet<WalletV2WithdrawType>(
      context: context,
      builder: (context) {
        return UserEnumSelection(
          title: "Select Your Withdraw\nMethod",
          enumValues: WalletV2WithdrawType.values.toList(),
        );
      },
    );
  }

  static Future<String?> promptUserWithWithdrawInput(
    BuildContext context,
  ) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return WalletV2WithdrawInput();
      },
    );
  }

  static Future<void> presentNodeInfo(
    BuildContext context, {
    required PhoenixDNodeInfo nodeInfo,
  }) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return PhoenixDNodeInfoView(
          nodeInfo: nodeInfo,
        );
      },
    );
  }

  static Future<String?> scanQrCode(BuildContext context) async {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return QrCodeScanner();
      },
    );
  }
}
