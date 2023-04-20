import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/strings.dart';
import '../general/widget/margined_body.dart';
import '../general/widget/title.dart';
import 'widgets/app_bar.dart';
import 'widgets/relay_config_tile.dart';

class RelaysConfig extends StatelessWidget {
  const RelaysConfig({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MarginedBody(
                child: Column(
                  children: const <Widget>[
                    SizedBox(height: height * 2),
                    HeadTitle(title: AppStrings.manageRelays),
                    SizedBox(height: height * 2),
                  ],
                ),
              ),
              ...List.generate(
                state.relaysConfigurations.length,
                (index) {
                  final current = state.relaysConfigurations[index];

                  return RelayConfigTile(
                    index: index,
                    relayConfig: current,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
