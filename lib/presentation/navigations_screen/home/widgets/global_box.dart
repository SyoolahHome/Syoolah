import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/feed_box/feed_box_cubit.dart';
import '../../../../constants/app_colors.dart';

class FeedBox extends StatelessWidget {
  const FeedBox({
    super.key,
    required this.onTap,
    required this.title,
    required this.description,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedBoxCubit>(
      create: (state) => FeedBoxCubit(),
      child: BlocBuilder<FeedBoxCubit, FeedBoxState>(
        builder: (context, state) {
          final cubit = context.read<FeedBoxCubit>();
          return GestureDetector(
            // onTap: onTap,
            onPanCancel: cubit.unHighlightBox,
            onPanDown: (details) {
              cubit.highlightBox();
            },
            onPanEnd: (details) {
              cubit.unHighlightBox();
            },
            onPanStart: (details) {
              cubit.highlightBox();
            },
            child: SizedBox(
              width: double.infinity,
              // height: 85,
              child: AnimatedContainer(
                padding: EdgeInsets.symmetric(
                  horizontal: state.isHighlighted ? 15 : 10,
                  vertical: 15,
                ),
                margin: const EdgeInsets.only(bottom: 15),
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: state.isHighlighted
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.onTertiaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: DefaultTextStyle.of(context)
                                        .style
                                        .color
                                        ?.withOpacity(0.95),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              description,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    color: DefaultTextStyle.of(context)
                                        .style
                                        .color
                                        ?.withOpacity(0.85),
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                        const Spacer(),
                        Icon(icon, color: AppColors.teal),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: MunawarahButton(
                        isSmall: true,
                        onTap: onTap,
                        text: "browse".tr(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
