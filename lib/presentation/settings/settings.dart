import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/settings_cubit.dart';
import '../../buisness_logic/profile/profile_cubit.dart';
import '../../constants/app_colors.dart';
import 'widgets/app_bar.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: height * 2),
                  Text(
                    AppStrings.settings,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  SizedBox(height: height * 2),
                  ...List.generate(
                    settingsItems.length,
                    (index) {
                      final current = settingsItems[index];
                      final isLogout = current.name == AppStrings.logout;

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
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
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
          );
        },
      ),
    );
  }
}
