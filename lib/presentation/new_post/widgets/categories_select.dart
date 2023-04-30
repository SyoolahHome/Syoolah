import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_strings.dart';

class CategoriesSelect extends StatelessWidget {
  const CategoriesSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return BlocBuilder<AddNewPostCubit, AddNewPostState>(
        builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(AppStrings.chooseCategories),
          Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: List.generate(state.categories.length, (index) {
                final current = state.categories[index];
                final isSelected = current.isSelected;
                return Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: FilterChip(
                    backgroundColor: isSelected ? null : AppColors.lighGrey,
                    onSelected: (value) {
                      cubit.onSelected(index, value);
                    },
                    disabledColor: AppColors.lighGrey,
                    selected: isSelected,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5),

                    label: Text(
                      current.name,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSelected
                                ? AppColors.teal
                                : Colors.black.withOpacity(.75),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    side: BorderSide(
                      color: isSelected ? AppColors.teal : Colors.transparent,
                      width: 0.75,
                    ),
                    labelStyle:
                        Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.teal,
                              fontWeight: FontWeight.bold,
                            ),

                    // iconTheme: ,
                  ),
                );
              })),
        ],
      );
    });
  }
}
