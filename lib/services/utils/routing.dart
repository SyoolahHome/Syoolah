import 'package:bloc/src/bloc_observer.dart';
import 'package:ditto/presentation/chat/chat.dart';
import 'package:ditto/presentation/feeds/quran_feed.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/app/app_cubit.dart';
import '../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../buisness_logic/on_boarding/on_boarding_cubit.dart';
import '../../presentation/about/about.dart';
import '../../presentation/about_munawarah/about_munawarah.dart';
import '../../presentation/auth_choose/auth_choose.dart';
import '../../presentation/bottom_bar_screen/bottom_bar_screen.dart';
import '../../presentation/current_user_keys/current_user_keys.dart';
import '../../presentation/edit_profile/edit_Profile.dart';
import '../../presentation/feeds/dua_feed.dart';
import '../../presentation/feeds/fiqh_feed.dart';
import '../../presentation/feeds/following_feed.dart';
import '../../presentation/feeds/global_feed.dart';
import '../../presentation/feeds/hadith_feed.dart';
import '../../presentation/feeds/sharia_feed.dart';
import '../../presentation/feeds/sirah_feed.dart';
import '../../presentation/followers/followers.dart';
import '../../presentation/followings/followings.dart';
import '../../presentation/nostr_service_loading/nostr_service_loading.dart';
import '../../presentation/privacy/privacy.dart';
import '../../presentation/settings/settings.dart';
import '../../presentation/sign_up/sign_up.dart';
import '../../presentation/note_comments_section/note_comments_section.dart';
import '../../presentation/onboarding/onboarding.dart';
import '../../presentation/onboarding_relays/onboarding_relays.dart';
import '../../presentation/onboarding_search/onboarding_search.dart';
import '../../presentation/relays_config/relays_config.dart';
import '../../presentation/scan/scan.dart';
import '../../presentation/succes_acc_made/succes_acc_made.dart';

abstract class Routing {
  static final routes = {
    Paths.bottomBar: (context) => BottomBar(cubit: homePageAfterLoginCubit),
    Paths.onBoarding: (context) => const OnBoarding(),
    Paths.SignUp: (context) => const SignUp(),
    Paths.editProfile: (context) => EditProfile(),
    Paths.quranFeed: (context) => QuranFeed(),
    Paths.duaFeed: (context) => DuaFeed(),
    Paths.shariaFeed: (context) => ShariaFeed(),
    Paths.hadithFeed: (context) => HadithFeed(),
    Paths.fiqhFeed: (context) => FiqhFeed(),
    Paths.sirahFeed: (context) => SirahFeed(),
    Paths.globalFeed: (context) => GlobalFeed(),
    Paths.followingFeed: (context) => FollowingsFeed(),
    // Paths.commentsSection: (context) => NoteCommentsSection(),
    Paths.relaysConfig: (context) => const RelaysConfig(),
    Paths.aboutMunawarah: (context) => const AboutMunawarah(),
    Paths.onBoardingSearch: (context) => const OnBoardingSearch(),
    Paths.authChoose: (context) => const AuthChoose(),
    Paths.existentSignUp: (context) => const ExistentSignUp(),
    Paths.onBoardingRelays: (context) => const OnBoardingRelays(),
    Paths.followings: (context) => Followings(),
    Paths.followers: (context) => Followers(),
    Paths.nostrServiceLoading: (context) => const NostrServiceLoading(),
    Paths.settings: (context) => Settings(),
    Paths.myKeys: (context) => const CurrentUserKeys(),
    Paths.chat: (context) => const Chat(),
    Paths.aboutApp: (context) => const About(),
    Paths.successAccountMade: (context) => const SuccessAccountMade(),
    Paths.privacyPolicy: (context) => const PrivacyPolicy(),
  };

  static final homePageAfterLoginCubit = HomePageAfterLoginCubit();
  static final authCubit = AuthCubit();
  static final appCubit = AppCubit();
  static final onBoardingCubit = OnBoardingCubit();

  static BlocObserver blocObserver = MyBlocObserver();
}

class MyBlocObserver extends BlocObserver {
  @override
  void onClose(BlocBase bloc) {
    print("Bloc closed: ${bloc.runtimeType}");
    return super.onClose(bloc);
  }
}
