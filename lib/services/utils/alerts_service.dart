import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/presentation/general/widget/text_button.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/profile_avatar_sheet/profile_avatar_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AlertsService {
  static Future<void> showAvatarMenu(
    BuildContext context, {
    required Future<void> Function() onPickFromGallery,
    required Future<void> Function() onTakePhoto,
    required Future<void> Function() onRemove,
    required Future<bool> Function() onAvatarPickedOrTaken,
    required Future<void> Function() onEnd,
    required BlocBase cubit,
    required void Function() onFullView,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        const textOpacity = 0.5;

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          content: ImageUpdateSheetWidget.avatar(
            onPickFromGallery: onPickFromGallery,
            onTakePhoto: onTakePhoto,
            onRemove: onRemove,
            onEnd: onEnd,
            onAvatarPickedOrTaken: onAvatarPickedOrTaken,
            cubitContext: context,
            cubit: cubit,
            onFullView: onFullView,
          ),
          contentPadding: const EdgeInsets.only(top: 16),
          actions: <Widget>[
            CustomTextButton(
              text: "close".tr(),
              onTap: () => Navigator.of(context).pop(),
              textColor:
                  Theme.of(context).colorScheme.error.withOpacity(textOpacity),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
          actionsAlignment: MainAxisAlignment.end,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  static Future showRemoveRelayDialog(
    BuildContext context, {
    required void Function(RelayConfiguration relay) onRemoveTap,
    required RelayConfiguration relay,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        const textOpacity = 0.5;

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: HeadTitle(title: "removeRelay".tr(args: [relay.url])),
          contentPadding: const EdgeInsets.only(top: 16),
          actions: <Widget>[
            CustomTextButton(
              text: "cancel".tr(),
              onTap: () {
                Navigator.of(context).pop();
              },
              textColor: AppColors.black.withOpacity(textOpacity),
            ),
            CustomTextButton(
              text: "remove".tr(),
              onTap: () {
                onRemoveTap(relay);
                Navigator.of(context).pop();
              },
              textColor: DefaultTextStyle.of(context)
                  .style
                  .color
                  ?.withOpacity(textOpacity),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
          actionsAlignment: MainAxisAlignment.end,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  static void confirmDialog({
    required BuildContext context,
    String? title,
    String? content,
    String? confirmText,
    String? cancelTextt,
    Future<void> Function()? onConfirm,
    void Function()? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        const textOpacity = 0.6;

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: title != null ? HeadTitle(title: title) : null,
          content: content != null ? Text(content) : null,
          contentPadding: const EdgeInsets.only(top: 16),
          actions: <Widget>[
            CustomTextButton(
              text: cancelTextt ?? "cancel".tr(),
              onTap: () {
                onCancel?.call();
                Navigator.of(context).pop();
              },
              textColor: DefaultTextStyle.of(context)
                  .style
                  .color
                  ?.withOpacity(textOpacity),
            ),
            CustomTextButton(
              text: confirmText ?? "ok".tr(),
              onTap: () {
                onConfirm?.call().then((_) {
                  Navigator.of(context).pop();
                });
              },
              textColor: DefaultTextStyle.of(context).style.color,
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
          actionsAlignment: MainAxisAlignment.end,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  static Future<void> showBannerMenu(
    BuildContext context, {
    required Future<void> Function() onPickFromGallery,
    required Future<void> Function() onTakePhoto,
    required Future<bool> Function() onBannerPickedOrTaken,
    required Future<void> Function() onRemove,
    required Future<void> Function() onEnd,
    required void Function() onFullView,
    required BlocBase cubit,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        const textOpacity = 0.5;

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          content: ImageUpdateSheetWidget.banner(
            onPickFromGallery: onPickFromGallery,
            onTakePhoto: onTakePhoto,
            onRemove: onRemove,
            onEnd: onEnd,
            onBannerPickedOrTaken: onBannerPickedOrTaken,
            cubitContext: context,
            cubit: cubit,
            onFullView: onFullView,
          ),
          contentPadding: const EdgeInsets.only(top: 16),
          actions: <Widget>[
            CustomTextButton(
              text: "close".tr(),
              onTap: () => Navigator.of(context).pop(),
              textColor:
                  Theme.of(context).colorScheme.error.withOpacity(textOpacity),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
          actionsAlignment: MainAxisAlignment.end,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  static void showTransactionSuccessModal({
    required BuildContext context,
    required String sweepTxid,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                """
    Your transaction was a success! Here is your txid: <a href="https://mempool.space/tx/${sweepTxid}" target="_blank">https://mempool.space/tx/${sweepTxid}</a>
    """,
              )
            ],
          ),
          contentPadding: const EdgeInsets.only(top: 16),
          actions: <Widget>[
            CustomTextButton(
              text: "close".tr(),
              onTap: () => Navigator.of(context).pop(),
              textColor: Theme.of(context).colorScheme.error,
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
          actionsAlignment: MainAxisAlignment.end,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  static void showAlmostDoneModal({
    required BuildContext context,
    required String txid,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                """
You're almost done! Just X out of this popup when the following transaction has 1 confirmation: <a href="https://mempool.space/tx/${txid}" target="_blank">https://mempool.space/tx/${txid}</a>`,
    """,
              )
            ],
          ),
          contentPadding: const EdgeInsets.only(top: 16),
          actions: <Widget>[
            CustomTextButton(
              text: "close".tr(),
              onTap: () => Navigator.of(context).pop(),
              textColor: Theme.of(context).colorScheme.error,
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
          actionsAlignment: MainAxisAlignment.end,
          insetPadding: EdgeInsets.zero,
        );
      },
    );
  }

  static Future<bool> showUserCreatedSuccessfullyModal({
    required BuildContext context,
  }) {
    throw UnimplementedError();
  }
}
