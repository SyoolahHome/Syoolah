import 'dart:convert';

import 'package:ditto/presentation/navigations_screen/profile/widgets/profile_widget_builder.dart';
import 'package:flutter/material.dart';
import '../../../model/user_meta_data.dart';
import '../../../services/nostr/model/event.dart';
import '../../../services/nostr/nostr.dart';
import '../../../services/utils/paths.dart';
import '../../edit_profile/edit_Profile.dart';
import '../../general/drawer_items.dart';
import '../../general/profile_tabs.dart';
import '../../general/widget/custom_drawer.dart';
import 'widgets/cover.dart';
import 'widgets/current_user_py_key.dart';
import 'widgets/name.dart';
import 'widgets/profile_and_dart.dart';
import 'widgets/profile_informations.dart';
import 'widgets/sliding_tabs.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  int _profileSegmentationValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        items: GeneralDrawerItems.drawerListTileItems(context),
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<NostrEvent>(
              stream: NostrService.instance.currentUserMetaDataStream(),
              builder: (context, snapshot) {
                final event = snapshot.data;
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
                          coverUrl: metadata.banner,
                        ),
                        ProfileAndEdit(
                          profileUrl: metadata.picture,
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
                        SlidingTabs(
                          profileTabs: GeneralProfileTabs.profileTabs,
                          profileSegmentationValue: _profileSegmentationValue,
                          onValueChanged: (changeTab) {
                            setState(() {
                              _profileSegmentationValue = changeTab!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ProfileWidgetBuilder(
            profileSegmentationValue: _profileSegmentationValue,
          ),
        ],
      ),
    );
  }
}
