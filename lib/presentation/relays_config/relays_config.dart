import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/relays_config/widgets/app_bar.dart';
import 'package:ditto/presentation/relays_config/widgets/relay_config_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RelaysConfig extends StatelessWidget {
  const RelaysConfig({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: AnimateList(
                interval: 100.ms,
                effects: <Effect>[
                  const FadeEffect(),
                  const SlideEffect(
                    begin: Offset(0, 0.5),
                  ),
                ],
                children: <Widget>[
                  MarginedBody(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: height * 2),
                        HeadTitle(title: "newManageRelays".tr()),
                        const SizedBox(height: height * 2),
                      ],
                    ),
                  ),
                  ...List.generate(
                    state.relaysConfigurations.length,
                    (index) {
                      final current = state.relaysConfigurations[index];
                      if (!current.url.contains("munawarah.me")) {
                        return SizedBox.shrink();
                      }

                      return RelayConfigTile(
                        index: index,
                        relayConfig: current,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
