import 'dart:convert';

import 'package:ditto/presentation/navigations_screen/profile/widgets/profile_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../buisness_logic/profile/profile_cubit.dart';
import '../../../model/user_meta_data.dart';
import '../../../services/nostr/nostr.dart';
import '../../../services/utils/paths.dart';
import '../../general/drawer_items.dart';
import '../../general/profile_tabs.dart';
import '../../general/widget/custom_drawer.dart';
import 'widgets/cover.dart';
import 'widgets/current_user_py_key.dart';
import 'widgets/name.dart';
import 'widgets/profile_and_dart.dart';
import 'widgets/profile_informations.dart';
import 'widgets/sliding_tabs.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        currentUserPostsStream:
            NostrService.instance.currentUserTextNotesStream(),
        currentUserMetadataStream:
            NostrService.instance.currentUserMetaDataStream(),
      ),
      child: DefaultTabController(
        length: GeneralProfileTabs.profileTabsItems.length,
        child: Builder(builder: (context) {
          return Scaffold(
            drawer: CustomDrawer(
              items: GeneralDrawerItems.drawerListTileItems(context),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      final event = state.currentUserMetadata;
                      UserMetaData metadata;
                      if (event == null) {
                        metadata = UserMetaData.placeholder();
                      } else {
                        metadata = UserMetaData.fromJson(
                          jsonDecode(event.content) as Map<String, dynamic>,
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ProfileCover(
                                coverUrl: metadata.banner!,
                              ),
                              ProfileAndEdit(
                                profileUrl: metadata.picture!,
                                onEditTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Paths.editProfile,
                                    arguments: metadata,
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              ProfileName(
                                name: metadata.name,
                                username: metadata.username,
                              ),
                              CurrentUserPubKey(pubKey: event?.pubkey ?? ""),
                              const ProfileInformations(),
                              const SizedBox(height: 20),
                              TabBar(
                                tabs: GeneralProfileTabs.profileTabsItems.map(
                                  (e) {
                                    return Tab(
                                      text: e.label,
                                    );
                                  },
                                ).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 500,
                    child: Flexible(
                      child: TabBarView(
                        children: GeneralProfileTabs.profileTabsItems.map((e) {
                          return e.widget;
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
