import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'widgets/relay_box.dart';

class OnBoardingRelays extends StatelessWidget {
  const OnBoardingRelays({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return SizedBox(
      height: 575,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: height * 2),
              const MarginedBody(
                child: BottomSheetTitleWithIconButton(
                  title: AppStrings.connectedRelays,
                ),
              ),
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
                      return Animate(
                        delay: Duration(milliseconds: 200 + (index * 200)),
                        effects: const <Effect>[
                          FadeEffect(),
                          SlideEffect(begin: Offset(0, 0.45)),
                        ],
                        child: RelayBox(
                          lastIndex: Routing
                              .appCubit.state.relaysConfigurations.length,
                          index: index,
                          relay: relay,
                          relayInformations: snapshot.data,
                        ),
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
