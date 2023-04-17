import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/app/app_cubit.dart';
import '../../../../services/utils/paths.dart';

class RelaysWidget extends StatelessWidget {
  const RelaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "relaysConfigWidget",
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != Paths.relaysConfig) {
                Navigator.of(context).pushNamed(Paths.relaysConfig);
              }
            },
            child: Row(
              children: <Widget>[
                Text(
                  "${state.relaysConfigurations.map((e) => e.isActive).length}",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(width: 5),
                Icon(
                  FlutterRemix.cloud_line,
                  size: 20,
                  color: Theme.of(context).primaryColor,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
