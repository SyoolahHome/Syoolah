import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants/app_colors.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalFeedCubit, GlobalFeedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "dateRange".tr(),
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
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
                          color: DefaultTextStyle.of(context)
                              .style
                              .color
                              ?.withOpacity(0.7),
                        ),
                  ),
                  Text(
                    state.dateRange != null
                        ? "To: ${state.dateRange!.end.formatted}"
                        : "To: -",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: DefaultTextStyle.of(context)
                              .style
                              .color
                              ?.withOpacity(0.7),
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
                  context.read<GlobalFeedCubit>().pickDateRange(context);
                },
                child: Text(
                  "pick".tr(),
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
