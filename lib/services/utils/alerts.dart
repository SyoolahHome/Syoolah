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
        return AlertDialog(
          actions: <Widget>[
            CustomTextButton(
              text: AppStrings.close,
              textColor: AppColors.black.withOpacity(0.5),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
          contentPadding: const EdgeInsets.only(top: 16),
          insetPadding: EdgeInsets.zero,
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          actionsAlignment: MainAxisAlignment.end,
          content: AvatarSheetWidget(
            cubitContext: context,
            onPickFromGallery: onPickFromGallery,
            onTakePhoto: onTakePhoto,
            onRemove: onRemove,
            onAvatarPickedOrTaken: onAvatarPickedOrTaken,
            onEnd: onEnd,
            cubit: cubit,
            onFullView: onFullView,
          ),
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
        return AlertDialog(
          title: HeadTitle(
            title: AppStrings.removeRelay(relayConfig.url),
          ),
          actions: <Widget>[
            CustomTextButton(
              text: AppStrings.cancel,
              textColor: AppColors.black.withOpacity(0.5),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            CustomTextButton(
              text: AppStrings.remove,
              textColor: Colors.red,
              onTap: () {
                onRemove();
                Navigator.of(context).pop();
              },
            ),
          ],
          contentPadding: const EdgeInsets.only(top: 16),
          insetPadding: EdgeInsets.zero,
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          actionsAlignment: MainAxisAlignment.end,
        );
      },
    );
  }
}
