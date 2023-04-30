import 'package:flutter/material.dart';

import '../../../constants/app_strings.dart';
import '../../../services/utils/routing.dart';
import '../../../services/utils/snackbars.dart';

class ReconnectButton extends StatelessWidget {
  const ReconnectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.5,
      child: ElevatedButton.icon(
        onPressed: () {
          Routing.appCubit.reconnectToRelays();
          SnackBars.text(context, AppStrings.reconnecting);
        },
        icon: const Icon(
          Icons.refresh,
          color: Colors.white,
          size: 12.5,
        ),
        label: Text(
          AppStrings.reconnect,
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
