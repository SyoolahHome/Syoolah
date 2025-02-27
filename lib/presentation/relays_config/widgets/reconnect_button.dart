import 'package:ditto/services/utils/routing.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ReconnectButton extends StatelessWidget {
  const ReconnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Animate(
      delay: 1500.ms,
      effects: const [FadeEffect()],
      child: SizedBox(
        height: 32.5,
        child: ElevatedButton.icon(
          onPressed: () {
            Routing.appCubit.reconnectToRelays();
            SnackBars.text(context, "reconnecting".tr());
          },
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
            size: 12.5,
          ),
          label: Text(
            "reconnect".tr(),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
