import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../model/relay_configuration.dart';
import '../../../services/utils/routing.dart';
import '../../general/widget/margined_body.dart';

class RelayConfigTile extends StatelessWidget {
  const RelayConfigTile({
    super.key,
    required this.relayConfig,
    required this.index,
  });

  final RelayConfiguration relayConfig;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Routing.appCubit.showRemoveRelayDialog(
          context: context,
          relayConfig: relayConfig,
        );
      },
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.lighGrey),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: MarginedBody.defaultMargin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(relayConfig.url),
            Transform.scale(
              scale: 0.65,
              child: Switch(
                onChanged: (value) {
                  Routing.appCubit.changeRelayState(
                    index: index,
                    isActive: value,
                  );
                },
                value: relayConfig.isActive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
