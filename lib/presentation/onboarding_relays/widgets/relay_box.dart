import 'dart:io';

import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';
import '../../../model/relat_configuration.dart';
import '../../../services/utils/routing.dart';
import '../../general/widget/margined_body.dart';

class RelayBox extends StatelessWidget {
  const RelayBox({
    super.key,
    required this.relay,
    required this.relayInformations,
    required this.index,
    required this.lastIndex,
  });

  final RelayConfiguration relay;
  final RelayInformations? relayInformations;
  final int index;
  final int lastIndex;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: index % 2 == 0
          ? AppColors.lighGrey.withOpacity(.45)
          : Colors.transparent,
      child: ListTile(
        onTap: () {
          Routing.appCubit.showRelayOptionsSheet(
            context,
            relay: relay,
            relayInformations: relayInformations,
          );
        },
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
                  text: (relayInformations == null
                      ? ''
                      : ' - ${relayInformations!.name}'),
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
            relayInformations?.description ?? '',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.black.withOpacity(1),
                  fontWeight: FontWeight.w300,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Flexible(
          child: Row(
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
                    width: 7.5,
                    height: 7.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: connectingColor,
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  Routing.appCubit.showRelayOptionsSheet(
                    context,
                    relay: relay,
                    relayInformations: relayInformations,
                  );
                },
                child: Animate(
                  effects: const <Effect>[
                    FadeEffect(),
                  ],
                  delay: Duration(milliseconds: lastIndex * 200),
                  child: const Icon(
                    FlutterRemix.more_2_line,
                    color: AppColors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
