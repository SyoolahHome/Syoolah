import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchOptionsBuilder extends StatelessWidget {
  const SearchOptionsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GlobalFeedCubit>();

    return BlocBuilder<GlobalFeedCubit, GlobalFeedState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "options".tr(),
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 5),
            ...List.generate(
              state.searchOptions.length,
              (index) {
                final current = state.searchOptions[index];
                return ListTile(
                  key: ValueKey(current.name),
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  shape: const OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  trailing: Transform.scale(
                    scale: 0.7,
                    child: Switch(
                      activeColor: Colors.green,
                      activeTrackColor: Colors.green.withOpacity(0.15),
                      inactiveTrackColor: Colors.red.withOpacity(0.15),
                      inactiveThumbColor: Colors.red,
                      value: current.isSelected,
                      onChanged: (value) {
                        cubit.selectedSearchOption(index, value);
                      },
                    ),
                  ),
                  title: Text(
                    current.name.capitalized,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: DefaultTextStyle.of(context)
                              .style
                              .color
                              ?.withOpacity(0.75),
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
