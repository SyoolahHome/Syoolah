import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BackUpMnemonicButton extends StatelessWidget {
  const BackUpMnemonicButton({
    super.key,
    required this.mnemonic,
    required this.onBackedUpSuccess,
  });

  final String mnemonic;
  final VoidCallback onBackedUpSuccess;
  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: 600.ms,
      effects: const <Effect>[
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: RoundaboutButton(
          onTap: () async {
            final backupUp = await BottomSheetService.mnemonicBackup(
              context: context,
              mnemonic: mnemonic,
            );

            if (backupUp != null && backupUp) {
              onBackedUpSuccess.call();
            }
          },
          text: "Back up My Seed Phrase".tr(),
        ),
      ),
    );
    ;
  }
}
