import 'dart:convert';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../buisness_logic/profile/profile_cubit.dart';
import '../../../model/user_meta_data.dart';
import '../../../services/nostr/nostr.dart';
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
                return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return <Widget>[
                      const SliverToBoxAdapter(child: CustomAppBar()),
                      SliverToBoxAdapter(
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            final event = state.currentUserMetadata;
                            UserMetaData metadata;

                            metadata = UserMetaData.fromJson(
                              jsonDecode(event?.content ?? "{}")
                                  as Map<String, dynamic>,
                            );

                            return MarginedBody(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: height * 2),
                                  // ProfileCover(metadata: metadata),
                                  ProfileHeader(
                                    metadata: metadata,
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
                      ),
                    ];
                  },
                  body: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: const ProfileTabView(),
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
