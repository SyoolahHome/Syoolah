import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/relays_config/widgets/relay_config_more.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/app/app_cubit.dart';
import 'relay_config_switch.dart';

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
        context
            .read<AppCubit>()
            .showRemoveRelayDialog(context, relay: relayConfig);
      },
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all(
        Theme.of(context).colorScheme.onSecondaryContainer,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: MarginedBody.defaultMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(relayConfig.url),
            const Spacer(),
            RelayConfigMore(relayConfig: relayConfig),
            RelayConfigSwitch(value: relayConfig.isActive, index: index),
          ],
        ),
      ),
    );
  }
}
