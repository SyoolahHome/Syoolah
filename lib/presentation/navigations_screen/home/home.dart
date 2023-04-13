import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/constants/configs.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';
import '../../../services/utils/paths.dart';
import '../../general/drawer_items.dart';
import '../../general/widget/title.dart';
import 'widgets/app_bar.dart';
import '../../general/widget/custom_drawer.dart';
import 'widgets/following.dart';
import 'widgets/global_box.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: MarginedBody(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 20),
                const HeadTitle(title: AppStrings.globalFeeds),
                const SizedBox(height: 10),
                FeedBox(
                  icon: FlutterRemix.global_line,
                  title: AppStrings.globalFeed,
                  description: AppStrings.globalFeedDescription,
                  onTap: () {
                    Navigator.pushNamed(context, Paths.globalFeed);
                  },
                ),
                FeedBox(
                  icon: FlutterRemix.user_add_line,
                  title: AppStrings.followingsFeed,
                  description: AppStrings.followingsFeedDescription,
                  onTap: () {
                    Navigator.pushNamed(context, Paths.followingFeed);
                  },
                ),
                const SizedBox(height: 20),
                const HeadTitle(title: AppStrings.categorizedFeeds),
                const SizedBox(height: 10),
                ...List.generate(AppConfigs.categories.length, (index) {
                  final current = AppConfigs.categories[index];
                  return FeedBox(
                    icon: current.icon,
                    description: current.description,
                    title: current.name,
                    onTap: () {
                      Navigator.pushNamed(context, current.path);
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
