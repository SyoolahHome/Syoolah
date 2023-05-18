import 'dart:io';

import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

class RelayBox extends StatelessWidget {
  const RelayBox({
    super.key,
    required this.relay,
    required this.snapshot,
    required this.index,
    required this.lastIndex,
  });

  final RelayConfiguration relay;
  final AsyncSnapshot? snapshot;
  final int index;
  final int lastIndex;

  void onRelayBoxTap(BuildContext context) {
    if (!snapshot!.hasData) {
      return;
    }

    return Routing.appCubit.showRelayOptionsSheet(
      context,
      relay: relay,
      relayInformations: snapshot!.data as RelayInformations,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: index % 2 == 0
          ? AppColors.lighGrey.withOpacity(.1)
          : Colors.transparent,
      child: ListTile(
        onTap: () => onRelayBoxTap(context),
        splashColor: Colors.transparent,
        contentPadding:
            const EdgeInsets.only(bottom: 5.0) + MarginedBody.defaultMargin,
        title: Animate(
          effects: const <Effect>[
            FadeEffect(),
          ],
          child: RichText(
            text: TextSpan(
              text: relay.url,
              style: Theme.of(context).textTheme.titleSmall,
              children: [
                TextSpan(
                  text: snapshot?.hasData ?? false
                      ? ' - ${snapshot!.data!.name}'
                      : "relayNameError".tr(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        visualDensity: VisualDensity.compact,
        subtitle: Container(
          margin: const EdgeInsets.only(top: 7.5),
          child: Text(
            snapshot?.hasData ?? false
                ? snapshot!.data!.description as String
                : "relayDescriptionError".tr(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color:
                      Theme.of(context).colorScheme.background.withOpacity(.3),
                  fontWeight: FontWeight.w300,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: WebSocket.connect(relay.url),
              builder: (context, snapshot) {
                final isLoading =
                    snapshot.connectionState == ConnectionState.waiting;
                Color connectingColor;
                if (snapshot.hasError) {
                  connectingColor = Colors.red;
                } else if (snapshot.hasData) {
                  connectingColor = Colors.green;
                } else {
                  connectingColor = AppColors.grey;
                }
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: connectingColor,
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            IgnorePointer(
              ignoring: snapshot!.hasData,
              child: Opacity(
                opacity: (snapshot?.hasData ?? false) ? 1 : 0.25,
                child: GestureDetector(
                  onTap: () => onRelayBoxTap(context),
                  child: Animate(
                    effects: const <Effect>[
                      FadeEffect(),
                    ],
                    delay: Duration(milliseconds: lastIndex * 200),
                    child: Icon(
                      FlutterRemix.more_2_line,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
