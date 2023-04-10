import 'package:ditto/presentation/feeds/feed_page.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:flutter/material.dart';

import '../../constants/strings.dart';

class FiqhFeed extends StatelessWidget {
  const FiqhFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return GeneralFeed(
      feedName: AppStrings.fiqh,
      feedPostsStream: NostrService.instance.fiqhFeedStream(),
    );
  }
}
