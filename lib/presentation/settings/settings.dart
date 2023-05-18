import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/settings_cubit.dart';
import 'widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final height = 10.0;

    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<SettingsCubit>();
          final settingsItems = AppConfigs.settings(context);

          return Scaffold(
            appBar: CustomAppBar(),
            body: MarginedBody(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: height),
                    Text(
                      "settings".tr(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: height * 3),
                    ...List.generate(
                      settingsItems.length,
                      (index) {
                        final current = settingsItems[index];
                        final isLogout = current.name == "logout".tr();

                        return ListTile(
                          splashColor: Colors.transparent,
                          leading: Icon(
                            current.icon,
                            color: isLogout
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).iconTheme.color,
                          ),
                          title: Text(
                            current.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: isLogout
                                      ? Theme.of(context).colorScheme.error
                                      : Theme.of(context).iconTheme.color,
                                ),
                          ),
                          trailing: current.trailing,
                          onTap: () => current.onTap(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
