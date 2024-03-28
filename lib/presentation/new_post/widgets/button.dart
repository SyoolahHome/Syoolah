import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return Row(
      children: <Widget>[
        ...List.generate(
          cubit.postAssetsSectionsWidgets.length,
          (index) {
            final current = cubit.postAssetsSectionsWidgets[index];

            return BlocBuilder<AddNewPostCubit, AddNewPostState>(
              builder: (context, state) {
                final isSelected = index == state.currentPostAssetsSectionIndex;

                return IconButton(
                  onPressed: () {
                    cubit.showWidgetAt(index);
                    if (isSelected) {
                      current.onPressed();
                    }
                  },
                  icon: Container(
                    color: isSelected
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : null,
                    child: Icon(
                      current.icon,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                );
              },
            );
          },
        ),
        const Spacer(),
        BlocConsumer<AddNewPostCubit, AddNewPostState>(
          listener: (_, state) {
            if (state.success != null) {
              Navigator.maybePop(context);
              SnackBars.text(context, state.success!);
            }
            if (state.error != null) {
              SnackBars.text(context, state.error!);
            }
          },
          builder: (_, state) {
            return SizedBox(
              height: 40,
              child: AppBrandButton(
                isSmall: true,
                onTap: () {
                  cubit.createNote();
                },
                customWidget: state.isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Theme.of(context).colorScheme.onBackground,
                          strokeWidth: 1.2,
                        ),
                      )
                    : Text(
                        "send".tr(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
