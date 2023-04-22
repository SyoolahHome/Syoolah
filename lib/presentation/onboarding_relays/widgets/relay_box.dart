import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/colors.dart';
import '../../../model/relat_configuration.dart';
import '../../../services/utils/routing.dart';

class RelayBox extends StatelessWidget {
  const RelayBox({
    super.key,
    required this.relay,
    required this.relayInformations,
  });

  final RelayConfiguration relay;
  final RelayInformations? relayInformations;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Routing.appCubit.showRelayOptionsSheet(
          context,
          relay: relay,
          relayInformations: relayInformations,
        );
      },
      contentPadding: const EdgeInsets.only(bottom: 5.0),
      title: RichText(
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
      trailing: GestureDetector(
        onTap: () {
          Routing.appCubit.showRelayOptionsSheet(
            context,
            relay: relay,
            relayInformations: relayInformations,
          );
        },
        child: const Icon(FlutterRemix.more_2_line),
      ),
    );
  }
}
