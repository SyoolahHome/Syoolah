import 'package:ditto/presentation/navigations_screen/profile/widgets/profile_widget_builder.dart';
import 'package:flutter/material.dart';
import '../../general/drawer_items.dart';
import '../../general/profile_tabs.dart';
import '../../general/widget/custom_drawer.dart';
import 'widgets/cover.dart';
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
          const ProfileCover(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              transform: Matrix4.translationValues(0.0, -56.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const ProfileAndEdit(),
                  const SizedBox(height: 20),
                  const ProfileName(),
                  const SizedBox(height: 10),
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
          ),
          ProfileWidgetBuilder(
            profileSegmentationValue: _profileSegmentationValue,
          ),
        ],
      ),
    );
  }
}
