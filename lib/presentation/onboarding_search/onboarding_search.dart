import 'dart:convert';

import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/pattern_widget.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_avatat_and_name.dart';
import 'package:ditto/presentation/onboarding_search/widgets/search_field.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class OnBoardingSearch extends StatelessWidget {
  const OnBoardingSearch({
    super.key,
  });

  @override
  Widget build(BuildContext widgetContext) {
    const height = 10.0;
    String? appCurrentUserPublicKey;
    final privateKey = LocalDatabase.instance.getPrivateKey();

    if (privateKey != null) {
      Nostr.instance.keysService.derivePublicKey(
        privateKey: privateKey,
      );
    }

    return BlocProvider<OnBoardingCubit>.value(
      value: Routing.onBoardingCubit,
      child: Builder(
        builder: (context) {
          final cubit = context.read<OnBoardingCubit>();

          return BlocConsumer<OnBoardingCubit, OnBoardingState>(
            listener: (context, state) {
              if (state.error != null) {
                SnackBars.text(widgetContext, state.error!);
              }
            },
            builder: (context, state) {
              return SizedBox(
                height: 575,
                child: Scaffold(
                  floatingActionButton: Animate(
                    delay: const Duration(milliseconds: 1000),
                    effects: const <Effect>[
                      FadeEffect(),
                      RotateEffect(begin: 0.1),
                    ],
                    child: FloatingActionButton(
                      onPressed: () {
                        cubit.executeSearch();
                      },
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 200),
                        scale: state.shouldShowSearchButton ? 1.0 : 0.95,
                        child: const Icon(
                          FlutterRemix.search_line,
                        ),
                      ),
                    ),
                  ),
                  body: PatternWidget(
                    child: MarginedBody(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: height * 2),
                          BottomSheetTitleWithIconButton(
                            title: "searchUser".tr(),
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
                              "identifierOrPuKey".tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context).hintColor),
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
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: height * 2),
                          if (state.searchedUser != null)
                            Builder(
                              builder: (context) {
                                final searchedUserMetadata =
                                    UserMetaData.fromJson(
                                  jsonDecode(state.searchedUser!.content)
                                      as Map<String, dynamic>,
                                );

                                return GestureDetector(
                                  onTap: () {},
                                  child: NoteAvatarAndName(
                                    appCurrentUserPublicKey:
                                        appCurrentUserPublicKey ?? "",
                                    userPubKey: state.searchedUser!.pubkey,
                                    avatarUrl: searchedUserMetadata.picture!,
                                    memeberShipStartedAt:
                                        state.searchedUser!.createdAt,
                                    nameToShow:
                                        searchedUserMetadata.nameToShow(),
                                  ),
                                );
                              },
                            ),
                        ],
                      ),
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
