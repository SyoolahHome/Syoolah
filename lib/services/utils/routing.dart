import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/presentation/feeds/quran_feed.dart';
import 'package:ditto/services/utils/paths.dart';

import '../../buisness_logic/app/app_cubit.dart';
import '../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../buisness_logic/on_boarding/on_boarding_cubit.dart';
import '../../presentation/about_munawarah/about_munawarah.dart';
import '../../presentation/auth_choose/auth_choose.dart';
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
import '../../presentation/navigations_screen/profile/profile.dart';
import '../../presentation/note_comments_section/note_comments_section.dart';
import '../../presentation/onboarding/onboarding.dart';
import '../../presentation/onboarding_relays/onboarding_relays.dart';
import '../../presentation/onboarding_search/onboarding_search.dart';
import '../../presentation/relays_config/relays_config.dart';
import '../../presentation/scan/scan.dart';

abstract class Routing {
  static final routes = {
    Paths.bottomBar: (context) => BottomBar(cubit: homePageAfterLoginCubit),
    Paths.onBoarding: (context) => const OnBoarding(),
    Paths.keyAuth: (context) => const KeyAuth(),
    Paths.editProfile: (context) => EditProfile(),
    Paths.quranFeed: (context) => QuranFeed(),
    Paths.duaFeed: (context) => DuaFeed(),
    Paths.shariaFeed: (context) => ShariaFeed(),
    Paths.hadithFeed: (context) => HadithFeed(),
    Paths.fiqhFeed: (context) => FiqhFeed(),
    Paths.sirahFeed: (context) => SirahFeed(),
    Paths.globalFeed: (context) => GlobalFeed(),
    Paths.followingFeed: (context) => FollowingsFeed(),
    Paths.commentsSection: (context) => NoteCommentsSection(),
    Paths.relaysConfig: (context) => const RelaysConfig(),
    Paths.aboutMunawarah: (context) => const AboutMunawarah(),
    Paths.onBoardingSearch: (context) => const OnBoardingSearch(),
    Paths.authChoose: (context) => const AuthChoose(),
    Paths.existentKeyAuth: (context) => const ExistentKeyAuth(),
    Paths.onBoardingRelays: (context) => const OnBoardingRelays(),
  };

  static final homePageAfterLoginCubit = HomePageAfterLoginCubit();
  static final authCubit = AuthCubit();
  static final appCubit = AppCubit();
  static final onBoardingCubit = OnBoardingCubit();

  static FeedCubit feedCubit({
    required Stream<NostrEvent> feedPostsStream,
  }) {
    return FeedCubit(
      feedPostsStream: feedPostsStream,
    );
  }
}
