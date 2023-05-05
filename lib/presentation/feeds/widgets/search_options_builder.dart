import 'package:easy_localization/easy_localization.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../../constants/app_colors.dart';

class SearchOptionsBuilder extends StatelessWidget {
  const SearchOptionsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GlobalFeedCubit>();

    return BlocBuilder<GlobalFeedCubit, GlobalFeedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("searchOptions".tr()),
            const SizedBox(height: 5),
            ...List.generate(
              state.searchOptions.length,
              (index) {
                final current = state.searchOptions[index];
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  shape: const OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  trailing: Transform.scale(
                    scale: 0.75,
                    child: Switch(
                      activeColor: AppColors.teal,
                      activeTrackColor: AppColors.teal.withOpacity(0.15),
                      inactiveTrackColor: AppColors.lighGrey,
                      inactiveThumbColor: AppColors.white,
                      value: current.isSelected,
                      onChanged: (value) {
                        cubit.selectedSearchOption(index, value);
                      },
                    ),
                  ),
                  title: Text(
                    current.name.capitalized,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.black.withOpacity(0.7),
                        ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
