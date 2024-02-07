import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/presentation/general/widget/custom_drawer.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/navigations_screen/home/widgets/app_bar.dart';
import 'package:ditto/presentation/navigations_screen/home/widgets/global_box.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/abstractions/abstractions.dart';
import '../../feeds/red_bull_feed.dart';

class Home extends BottomBarScreen {
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
              children: AnimateList(
                delay: 200.ms,
                interval: 100.ms,
                effects: <Effect>[
                  const FadeEffect(),
                  const SlideEffect(begin: Offset(0, 0.5)),
                ],
                children: <Widget>[
                  const SizedBox(height: 20),
                  HeadTitle(title: "globalFeeds".tr()),
                  const SizedBox(height: 10),
                  FeedBox(
                    title: "global".tr(),
                    description: "globalSubtitle".tr(),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Paths.globalFeed,
                        arguments: context.read<GlobalCubit>(),
                      );
                    },
                  ),
                  FeedBox(
                    title: "following".tr(),
                    description: "followingsFeedSubtitle".tr(),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Paths.followingFeed,
                        arguments: context.read<GlobalCubit>(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  HeadTitle(title: "topics".tr()),
                  const SizedBox(height: 10),
                  ...List.generate(AppConfigs.categories.length, (index) {
                    final current = AppConfigs.categories[index];

                    return FeedBox(
                      title: current.name,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return ReusableFeed(
                                feedCategory: current,
                                globalCubit: context.read<GlobalCubit>(),
                              );
                            },
                          ),
                        );

                        // Navigator.pushNamed(
                        //   context,
                        //   current.path,
                        //   arguments: context.read<GlobalCubit>(),
                        // );
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
