import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/app/app_cubit.dart';
import '../../../services/utils/routing.dart';

class RelayConfigMore extends StatelessWidget {
  const RelayConfigMore({
    super.key,
    required this.relayConfig,
  });

  final relayConfig;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Nostr.instance.relaysService
          .relayInformationsDocumentNip11(relayUrl: relayConfig.url),
      builder: (context, snapshot) {
        void onRelayBoxTap(BuildContext context) {
          if (!snapshot.hasData) {
            return;
          }

          return context.read<AppCubit>().showRelayOptionsSheet(
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
            child: const Icon(FlutterRemix.information_line),
          ),
        );
      },
    );
  }
}
