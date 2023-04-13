import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedCubit, GlobalFeedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(AppStrings.dateRange),
            const SizedBox(height: 5),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.dateRange != null
                        ? "From: ${state.dateRange!.start.formatted}"
                        : "From: -",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.black.withOpacity(0.7),
                        ),
                  ),
                  Text(
                    state.dateRange != null
                        ? "To: ${state.dateRange!.end.formatted}"
                        : "To: -",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.black.withOpacity(0.7),
                        ),
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              trailing: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.teal),
                ),
                onPressed: () {
                  context.read<FeedCubit>().pickDateRange(context);
                },
                child: const Text(
                  AppStrings.pick,
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
