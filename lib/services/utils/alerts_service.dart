import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_strings.dart';
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
              text: AppStrings.close,
              onTap: () => Navigator.of(context).pop(),
              textColor: AppColors.black.withOpacity(textOpacity),
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
          title: HeadTitle(title: AppStrings.removeRelay(relayConfig.url)),
          contentPadding: const EdgeInsets.only(top: 16),
          actions: <Widget>[
            CustomTextButton(
              text: AppStrings.cancel,
              onTap: () {
                Navigator.of(context).pop();
              },
              textColor: AppColors.black.withOpacity(textOpacity),
            ),
            CustomTextButton(
              text: AppStrings.remove,
              onTap: () {
                onRemove();
                Navigator.of(context).pop();
              },
              textColor: Colors.red,
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
