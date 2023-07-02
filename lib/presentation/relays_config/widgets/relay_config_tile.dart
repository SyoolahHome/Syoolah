import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
          context,
          relay: relayConfig,
        );
      },
      splashFactory: NoSplash.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.lighGrey),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: MarginedBody.defaultMargin,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(relayConfig.url),
            const Spacer(),
            FutureBuilder(
              future: Nostr.instance.relaysService
                  .relayInformationsDocumentNip11(relayUrl: relayConfig.url),
              builder: (context, snapshot) {
                void onRelayBoxTap(BuildContext context) {
                  if (!snapshot.hasData) {
                    return;
                  }

                  return Routing.appCubit.showRelayOptionsSheet(
                    context,
                    relay: relayConfig,
                    relayInformations: snapshot.data,
                  );
                }

                return Animate(
                  effects: const <Effect>[FadeEffect()],
                  target: snapshot.hasData ? 1 : 0,
                  child: GestureDetector(
                    onTap: () => onRelayBoxTap(context),
                    child: const Icon(
                      FlutterRemix.information_line,
                    ),
                  ),
                );
              },
            ),
            Transform.scale(
              scale: 0.65,
              child: Switch(
                onChanged: (value) {
                  Routing.appCubit.selectRelay(
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
