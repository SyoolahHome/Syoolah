import 'dart:convert';

import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/loading_widget.dart';
import 'package:ditto/presentation/general/pattern_widget.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_avatat_and_name.dart';
import 'package:ditto/presentation/onboarding_search/widgets/search_field.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
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
    final privateKey = LocalDatabase.instance.getPrivateKey();

    const height = 10.0;
    String? appCurrentUserPublicKey;

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

          return BlocListener<OnBoardingCubit, OnBoardingState>(
            listener: (context, state) {
              if (state.error != null) {
                SnackBars.text(widgetContext, state.error!);
              }
            },
            child: SizedBox(
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
                    child: BlocSelector<OnBoardingCubit, OnBoardingState, bool>(
                      selector: (state) => state.shouldShowSearchButton,
                      builder: (context, shouldShowSearchButton) {
                        return AnimatedScale(
                          duration: 200.ms,
                          scale: shouldShowSearchButton ? 1.0 : 0.95,
                          child: const Icon(FlutterRemix.search_line),
                        );
                      },
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
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: height * 2),
                        BlocBuilder<OnBoardingCubit, OnBoardingState>(
                          builder: (context, state) {
                            final sq = state.searchQuery;

                            if (sq.isEmpty) {
                              return SizedBox.shrink();
                            }

                            final userEvents = state.searchedUserEvents[sq];

                            if (userEvents != null) {
                              final decodedUsers = userEvents.map((e) {
                                final asMap = jsonDecode(e.content!)
                                    as Map<String, dynamic>;
                                return UserMetaData.fromJson(
                                  jsonData: asMap,
                                  sourceNostrEvent: e,
                                );
                              }).toList();

                              return ListView.builder(
                                itemCount: decodedUsers.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final current = decodedUsers[index];

                                  return Column(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {},
                                        child: NoteAvatarAndName(
                                          appCurrentUserPublicKey:
                                              appCurrentUserPublicKey ?? "",
                                          userPubKey:
                                              current.userMetadataEvent!.pubkey,
                                          avatarUrl: current.picture!,
                                          memeberShipStartedAt: current
                                              .userMetadataEvent!.createdAt,
                                          nameToShow: current.nameToShow(),
                                        ),
                                      ),
                                      SizedBox(height: height * 2),
                                      IconButton(
                                        icon: Icon(FlutterRemix.more_line),
                                        onPressed: () {
                                          BottomSheetService
                                              .showOnBoardingSearchUserMetadataPropertiesSheet(
                                            context,
                                            properties:
                                                current.toJson().entries,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else if (state.searchingForUser) {
                              return Center(child: LoadingWidget());
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
