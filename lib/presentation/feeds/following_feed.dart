import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowingsFeed extends StatelessWidget {
  FollowingsFeed({super.key});

  GlobalCubit? globalCubit;
  @override
  Widget build(BuildContext context) {
    globalCubit = ModalRoute.of(context)!.settings.arguments as GlobalCubit;

    return BlocProvider<GlobalCubit>.value(
      value: globalCubit!,
      child: GeneralFeed(
        feedName: "following".tr(),
        feedPostsStream: NostrService.instance.subs.followingsFeed(
          followings: globalCubit!.state.currentUserFollowing?.tags
                  .map((e) => e[1])
                  .toList() ??
              [],
        ),
      ),
    );
  }
}
