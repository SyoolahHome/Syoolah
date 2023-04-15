import 'package:ditto/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/strings.dart';
import '../../presentation/general/widget/text_button.dart';
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
}
