import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/global/global_cubit.dart';
import '../../constants/app_strings.dart';

class QuranFeed extends StatelessWidget {
  QuranFeed({super.key});
  GlobalCubit? globalCubit;

  @override
  Widget build(BuildContext context) {
    globalCubit = ModalRoute.of(context)!.settings.arguments as GlobalCubit;

    return BlocProvider<GlobalCubit>.value(
      value: globalCubit!,
      child: GeneralFeed(
        feedName: AppStrings.quran,
        feedPostsStream: NostrService.instance.quranFeedStream(),
      ),
    );
  }
}
