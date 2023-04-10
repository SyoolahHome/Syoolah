import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class FollowingsFeed extends StatelessWidget {
  const FollowingsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralFeed(
      feedName: AppStrings.followings,
      feedPostsStream: NostrService.instance.followingsFeed(
        followings: [],
      ),
    );
  }
}
