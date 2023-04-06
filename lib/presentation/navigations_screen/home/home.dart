import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            children: const <Widget>[
              SizedBox(height: 20),
              GlobalBox(),
              SizedBox(height: 5),
              FollowingBox(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
