import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: const TimePickerThemeData(
          dialTextColor: Colors.red,
          backgroundColor: Colors.red,
        ),
      ),
      child: BlocBuilder<GlobalFeedCubit, GlobalFeedState>(
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
                trailing: UmrahtyButton(
                  onTap: () {
                    context.read<GlobalFeedCubit>().pickDateRange(context);
                  },
                  isSmall: true,
                  text: "selectDate".tr(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
