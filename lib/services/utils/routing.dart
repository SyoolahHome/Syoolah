import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/presentation/feeds/quran_feed.dart';
import 'package:ditto/services/utils/paths.dart';

import '../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../presentation/bottom_bar_screen/bottom_bar_screen.dart';
import '../../presentation/edit_profile/edit_Profile.dart';
import '../../presentation/feeds/dua_feed.dart';
import '../../presentation/feeds/fiqh_feed.dart';
import '../../presentation/feeds/following_feed.dart';
import '../../presentation/feeds/global_feed.dart';
import '../../presentation/feeds/hadith_feed.dart';
import '../../presentation/feeds/sharia_feed.dart';
import '../../presentation/feeds/sirah_feed.dart';
import '../../presentation/home/home.dart';

abstract class Routing {
  static final routes = {
    Paths.bottomBar: (context) => BottomBar(cubit: homePageAfterLoginCubit),
    Paths.main: (context) => const MyHomePage(),
    Paths.editProfile: (context) => EditProfile(),
    Paths.quranFeed: (context) => const QuranFeed(),
    Paths.duaFeed: (context) => const DuaFeed(),
    Paths.shariaFeed: (context) => const ShariaFeed(),
    Paths.hadithFeed: (context) => const HadithFeed(),
    Paths.fiqhFeed: (context) => const FiqhFeed(),
    Paths.sirahFeed: (context) => const SirahFeed(),
    Paths.globalFeed: (context) => const GlobalFeed(),
    Paths.followingFeed: (context) => const FollowingsFeed(),
  };

  static final homePageAfterLoginCubit = HomePageAfterLoginCubit();

  static final authCubit = AuthCubit();

  static FeedCubit feedCubit({
    required Stream<NostrEvent> feedPostsStream,
  }) {
    return FeedCubit(
      feedPostsStream: feedPostsStream,
    );
  }
}
