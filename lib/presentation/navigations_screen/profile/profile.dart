import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../buisness_logic/profile/profile_cubit.dart';
import '../../../model/user_meta_data.dart';
import '../../../services/nostr/nostr.dart';
import '../../general/widget/custom_drawer.dart';
import '../../home/widgets/or_divider.dart';
import 'widgets/about.dart';

import 'widgets/app_bar.dart';
import 'widgets/name.dart';
import 'widgets/profile_and_dart.dart';
import 'widgets/tab_view.dart';
import 'widgets/tabs.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        currentUserPostsStream:
            NostrService.instance.currentUserTextNotesStream(),
        currentUserMetadataStream:
            NostrService.instance.currentUserMetaDataStream(),
        currentUserLikedPosts: NostrService.instance.currentUserLikes(),
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProfileCubit>();

          return DefaultTabController(
            length: cubit.state.profileTabsItems.length,
            child: Builder(
              builder: (context) {
                return Scaffold(
                  appBar: const CustomAppBar(),
                  drawer: const CustomDrawer(),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            final event = state.currentUserMetadata;
                            UserMetaData metadata;

                            metadata = UserMetaData.fromJson(
                              jsonDecode(event?.content ?? "{}")
                                  as Map<String, dynamic>,
                            );

                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // ProfileCover(metadata: metadata),
                                  ProfileHeader(
                                    metadata: metadata,
                                    followersCount: state.followersCount,
                                    followingCount: state.followingCount,
                                  ),
                                  const SizedBox(height: height * 3),
                                  ProfileName(metadata: metadata),
                                  const SizedBox(height: height),
                                  ProfileAbout(metadata: metadata),
                                  const SizedBox(height: height * 2),
                                  const OrDivider(color: Colors.black),
                                  const SizedBox(height: height * 2),
                                  const ProfileTabs(),
                                ],
                              ),
                            );
                          },
                        ),
                        const ProfileTabView(),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
