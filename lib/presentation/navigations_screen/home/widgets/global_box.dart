import 'package:ditto/buisness_logic/feed_box/feed_box_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../services/utils/app_utils.dart';

class FeedBox extends StatelessWidget {
  const FeedBox({
    super.key,
    required this.onTap,
    required this.title,
    this.imageIcon,
    this.description,
  });

  final VoidCallback onTap;
  final String title;
  final String? imageIcon;
  final String? description;
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
                  vertical: 10,
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
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
                              if (description != null)
                                Text(
                                  description!,
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
                        ),
                        const SizedBox(width: 15),
                        if (imageIcon != null)
                          Image.asset(
                            imageIcon!,
                            width: 100,
                            height: 100,
                          )
                      ],
                    ),
                    Align(
                      alignment:
                          AppUtils.instance.centerHorizontalAlignment(context),
                      child: Animate(
                        delay: 800.ms,
                        effects: const [
                          FadeEffect(),
                        ],
                        child: AppBrandButton(
                          isSmall: true,
                          onTap: onTap,
                          text: "explore".tr(),
                        ),
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
