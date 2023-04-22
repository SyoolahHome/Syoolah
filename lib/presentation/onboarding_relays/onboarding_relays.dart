import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';

import 'widgets/relay_box.dart';

class OnBoardingRelays extends StatelessWidget {
  const OnBoardingRelays({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return SizedBox(
      height: 575,
      child: MarginedBody(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: height * 2),
              const BottomSheetTitleWithIconButton(
                  title: AppStrings.availableRelays),
              const SizedBox(height: height * 2),
              ...List.generate(
                Routing.appCubit.state.relaysConfigurations.length,
                (index) {
                  final relay =
                      Routing.appCubit.state.relaysConfigurations[index];
                  return FutureBuilder(
                    future: Nostr.instance.relaysService
                        .relayInformationsDocumentNip11(relayUrl: relay.url),
                    builder: (context, snapshot) {
                      return RelayBox(
                        relay: relay,
                        relayInformations: snapshot.data,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
