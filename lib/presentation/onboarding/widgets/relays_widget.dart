import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/presentation/onboarding/widgets/action_button_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class RelaysWidget extends StatelessWidget {
  const RelaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Tooltip(
      message: "relays".tr(),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          cubit.showRelaysSheet(context);
        },
        splashFactory: NoSplash.splashFactory,
        child: ActionButtonContainer(
          child: BlocBuilder<AppCubit, AppState>(
            builder: (context, state) {
              final activeRelays =
                  state.relaysConfigurations.map((e) => e.isActive);

              return GestureDetector(
                onTap: () {
                  cubit.showRelaysSheet(context);
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      FlutterRemix.cloud_line,
                      size: 17.5,
                      color: Theme.of(context).colorScheme.onSecondary,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
