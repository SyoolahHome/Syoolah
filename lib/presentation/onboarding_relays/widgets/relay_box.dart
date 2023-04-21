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
      contentPadding: const EdgeInsets.only(bottom: 15.0),
      title: Text(
        relay.url +
            (relayInformations == null ? '' : ' - ${relayInformations!.name}'),
        style: Theme.of(context).textTheme.titleSmall,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        relayInformations?.description ?? '',
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.black.withOpacity(1),
              fontWeight: FontWeight.w300,
            ),
      ),
      trailing: IconButton(
        onPressed: () {
          Routing.appCubit.showRelayOptionsSheet(
            context,
            relay: relay,
            relayInformations: relayInformations,
          );
        },
        icon: const Icon(FlutterRemix.more_2_line),
      ),
    );
  }
}
