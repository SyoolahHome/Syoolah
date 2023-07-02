import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/abstractions/abstractions.dart';

class Umah extends BottomBarScreen {
  Umah({super.key});

  GlobalCubit? globalCubit;
  @override
  Widget build(BuildContext context) {
    globalCubit = ModalRoute.of(context)?.settings.arguments is GlobalCubit
        ? ModalRoute.of(context)?.settings.arguments as GlobalCubit
        : null;

    globalCubit ??= context.read<GlobalCubit>();

    return BlocProvider<GlobalCubit>.value(
      value: globalCubit!,
      child: GeneralFeed(
        feedName: "umah".tr(),
        endFeedTitleWithAdditionalText: false,
        feedPostsStream: NostrService.instance.subs.globalFeed(),
      ),
    );
  }
}
