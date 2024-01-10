import 'package:ditto/buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/abstractions/abstractions.dart';
import '../../services/utils/routing.dart';

class Umah extends BottomBarScreen {
  Umah({super.key});

  GlobalCubit? globalCubit;
  @override
  Widget build(BuildContext context) {
    globalCubit = ModalRoute.of(context)?.settings.arguments is GlobalCubit
        ? ModalRoute.of(context)?.settings.arguments as GlobalCubit
        : null;

    globalCubit ??= context.read<GlobalCubit>();

    final followingsPubKeysList =
        globalCubit!.state.currentUserFollowing?.tagsPublicKeys;

    return MultiBlocProvider(
      providers: [
        BlocProvider<GlobalCubit>.value(value: globalCubit!),
        BlocProvider<BottomBarCubit>.value(value: Routing.bottomBarCubit),
      ],
      child: GeneralFeed(
        feedName: "global".tr(),
        endFeedTitleWithAdditionalText: false,
        feedPostsStream: NostrService.instance.subs.globalFeed(
          followings: followingsPubKeysList,
        ),
      ),
    );
  }
}
