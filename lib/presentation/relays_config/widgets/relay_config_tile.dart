import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
            Spacer(),
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

                return GestureDetector(
                  onTap: () => onRelayBoxTap(context),
                  child: Icon(
                    FlutterRemix.information_line,
                    color: snapshot.hasData
                        ? null
                        : Theme.of(context).iconTheme.color!.withOpacity(.25),
                  ),
                );
              },
            ),
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
