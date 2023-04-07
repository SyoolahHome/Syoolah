import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nostr/nostr.dart';
import 'package:nostr_client/nostr/nostr.dart';
import '../../general/drawer_items.dart';
import 'widgets/app_bar.dart';
import '../../general/widget/custom_drawer.dart';
import 'widgets/following.dart';
import 'widgets/global_box.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(
        items: GeneralDrawerItems.drawerListTileItems(context),
      ),
      body: MarginedBody(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              GlobalBox(),
              SizedBox(height: 5),
              FollowingBox(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final user =
                      "6c211d132bfb928a1a116a09d5e9c02d80d6e53c8c4d57888f04e81eb0897d68";
                  NostrService.instance.followUserWithPubKey(user);
                },
                child: Text('Test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
