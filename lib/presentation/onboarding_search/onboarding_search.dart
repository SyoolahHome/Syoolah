import 'dart:convert';

import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/profile_options/widgets/profile_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../model/user_meta_data.dart';
import '../../services/utils/paths.dart';
import '../../services/utils/routing.dart';
import '../general/widget/note_card/wudgets/note_avatat_and_name.dart';
import '../home/widgets/or_divider.dart';
import '../onboarding/widgets/search_icon.dart';
import 'widgets/app_bar.dart';
import 'widgets/search_field.dart';

class OnBoardingSearch extends StatelessWidget {
  const OnBoardingSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<OnBoardingCubit>.value(
      value: Routing.onBoardingCubit,
      child: Builder(
        builder: (context) {
          final cubit = context.read<OnBoardingCubit>();

          return BlocBuilder<OnBoardingCubit, OnBoardingState>(
            builder: (context, state) {
              return SizedBox(
                height: 575,
                child: Scaffold(
                  floatingActionButton: state.shouldShowSearchButton
                      ? FloatingActionButton(
                          onPressed: () {
                            cubit.executeSearch();
                          },
                          child: const Icon(FlutterRemix.search_line),
                        )
                      : null,
                  body: MarginedBody(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: height * 2),
                        BottomSheetTitleWithIconButton(
                          title: AppStrings.searchUser,
                          onPop: () {
                            cubit.resetSearch();
                          },
                        ),
                        const SizedBox(height: height * 2),
                        Animate(
                          delay: const Duration(milliseconds: 200),
                          effects: const <Effect>[
                            FadeEffect(),
                            SlideEffect(
                              begin: Offset(0, 0.5),
                            )
                          ],
                          child: Text(
                            AppStrings.identifierOrPuKey,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(color: Theme.of(context).hintColor),
                          ),
                        ),
                        const SizedBox(height: height),
                        const SearchField(),
                        const SizedBox(height: height * 2),
                        Animate(
                          delay: const Duration(milliseconds: 600),
                          effects: const <Effect>[
                            FadeEffect(),
                            SlideEffect(
                              begin: Offset(0, 0.5),
                            )
                          ],
                          child: const Center(
                            child: OrDivider(
                              onlyDivider: false,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: height * 2),
                        if (state.searchedUser != null)
                          Builder(builder: (context) {
                            final searchedUserMetadata = UserMetaData.fromJson(
                                jsonDecode(state.searchedUser!.content));

                            return GestureDetector(
                              onTap: () {},
                              child: NoteAvatarAndName(
                                avatarUrl: searchedUserMetadata.picture!,
                                memeberShipStartedAt:
                                    state.searchedUser!.createdAt,
                                nameToShow: searchedUserMetadata.nameToShow(),
                              ),
                            );
                          }),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
