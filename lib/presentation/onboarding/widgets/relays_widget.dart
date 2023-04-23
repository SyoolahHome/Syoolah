import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../../buisness_logic/app/app_cubit.dart';
import '../../../../services/utils/paths.dart';
import '../../../constants/strings.dart';

class RelaysWidget extends StatelessWidget {
  const RelaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnBoardingCubit>();

    return Tooltip(
      message: AppStrings.relays,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          cubit.showRelaysSheet(context);
        },
        splashFactory: NoSplash.splashFactory,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
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
                    // Text(
                    //   activeRelays.length.toString(),
                    //   style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    //         color: AppColors.black.withOpacity(0.75),
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    // ),
                    // const SizedBox(width: 5),
                    Icon(
                      FlutterRemix.cloud_line,
                      size: 17.5,
                      color: AppColors.black.withOpacity(0.75),
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
