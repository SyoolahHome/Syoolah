import 'package:ditto/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/relay_configuration.dart';
import '../../presentation/general/widget/text_button.dart';
import '../../presentation/general/widget/title.dart';
import '../../presentation/profile_avatar_sheet/profile_avatar_sheet.dart';

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
        final textOpacity = 0.5;

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          content: AvatarSheetWidget(
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

  static showRemoveRelayDialog(
    BuildContext context, {
    required void Function() onRemove,
    required RelayConfiguration relayConfig,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        final textOpacity = 0.5;

        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: HeadTitle(title: "removeRelay".tr(args: [relayConfig.url])),
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
                onRemove();
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
        final textOpacity = 0.6;

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
}
