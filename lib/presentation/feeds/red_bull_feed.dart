import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/model/feed_category.dart';
import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/nostr/nostr_service.dart';

class ReusableFeed extends StatelessWidget {
  ReusableFeed({
    super.key,
    required this.feedCategory,
    required this.globalCubit,
  });

  final FeedCategory feedCategory;

  final GlobalCubit globalCubit;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalCubit>.value(
      value: globalCubit,
      child: GeneralFeed(
        feedName: feedCategory.name,
        feedPostsStream:
            NostrService.instance.subs.topic(topic: feedCategory.enumValue),
        // feedCategory.feedPostsStream,
      ),
    );
  }
}
