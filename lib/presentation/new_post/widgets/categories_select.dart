import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            Text("chooseTopics".tr()),
            Wrap(
              children: List.generate(state.categories.length, (index) {
                final current = state.categories[index];
                final isSelected = current.isSelected;
                return Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: FilterChip(
                    backgroundColor: isSelected
                        ? null
                        : Theme.of(context).colorScheme.onPrimary,
                    onSelected: (value) {
                      cubit.onSelected(index, value);
                    },
                    disabledColor: Theme.of(context).colorScheme.onPrimary,
                    selected: isSelected,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 5),

                    label: Text(
                      current.name,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            // color: isSelected
                            //     ? Theme.of(context).primaryColor
                            //     : Colors.black.withOpacity(.75),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? Theme.of(context).colorScheme.background
                          : Colors.transparent,
                      width: 0.75,
                    ),
                    labelStyle:
                        Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.background,
                              fontWeight: FontWeight.bold,
                            ),

                    // iconTheme: ,
                  ),
                );
              }),
            ),
          ],
        );
      },
    );
  }
}
