import 'dart:convert';

import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/about.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/app_bar.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/name.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/profile_and_dart.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/tab_view.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/tabs.dart';
import 'package:ditto/presentation/sign_up/widgets/or_divider.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/abstractions/abstractions.dart';
import '../../../constants/app_enums.dart';
import '../../private_succes/widgets/key_section.dart';
import 'widgets/banner.dart';

class Profile extends BottomBarScreen {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        currentUserMetadataStream:
            NostrService.instance.subs.currentUserMetaDataStream(),
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProfileCubit>();

          return DefaultTabController(
            length: cubit.state.profileTabsItems.length,
            child: Builder(
              builder: (context) {
                return BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    final event = state.currentUserMetadata;
                    UserMetaData metadata;

                    metadata = UserMetaData.fromJson(
                      jsonDecode(event?.content ?? "{}")
                          as Map<String, dynamic>,
                    );

                    return Scaffold(
                      backgroundColor: Colors.transparent,
                      body: NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return <Widget>[
                            SliverToBoxAdapter(
                              child: Builder(
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Stack(
                                        fit: StackFit.loose,
                                        children: <Widget>[
                                          ProfileBanner(
                                            metadata: metadata,
                                            child: MarginedBody(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  CustomAppBar(
                                                    userMetadata: metadata,
                                                  ),
                                                  const SizedBox(
                                                    height: height * 2,
                                                  ),
                                                  ProfileHeader(
                                                    metadata: metadata,
                                                  ),
                                                  const SizedBox(
                                                    height: height * 3,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      MarginedBody(
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: height * 2,
                                            ),
                                            ProfileName(
                                              metadata: metadata,
                                              pubKey: event?.pubkey ?? "",
                                            ),
                                            const SizedBox(height: height),
                                            ProfileAbout(metadata: metadata),
                                            const SizedBox(height: height * 2),
                                            KeySection(
                                              type: KeySectionType.publicKey,
                                              showEyeIconButton: false,
                                            ),
                                            // PublicKeySection(),
                                            const SizedBox(height: height * 2),
                                            Animate(
                                              effects: const <Effect>[
                                                FadeEffect(),
                                              ],
                                              delay: 1000.ms,
                                              child: const OrDivider(),
                                            ),
                                            const SizedBox(height: height * 2),
                                            const ProfileTabs(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ];
                        },
                        body: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const ProfileTabView(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
