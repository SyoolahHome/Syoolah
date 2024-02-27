import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import 'package:ditto/buisness_logic/on_boarding/on_boarding_cubit.dart';
import 'package:ditto/presentation/about_app/about_app.dart';
import 'package:ditto/presentation/auth_choose/auth_choose.dart';
import 'package:ditto/presentation/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:ditto/presentation/chat/chat.dart';
import 'package:ditto/presentation/current_user_keys/current_user_keys.dart';
import 'package:ditto/presentation/edit_profile/edit_Profile.dart';
import 'package:ditto/presentation/feeds/following_feed.dart';
import 'package:ditto/presentation/feeds/global_feed.dart';
import 'package:ditto/presentation/followers/followers.dart';
import 'package:ditto/presentation/followings/followings.dart';
import 'package:ditto/presentation/nostr_service_loading/nostr_service_loading.dart';
import 'package:ditto/presentation/onboarding/onboarding.dart';
import 'package:ditto/presentation/onboarding_relays/onboarding_relays.dart';
import 'package:ditto/presentation/onboarding_search/onboarding_search.dart';
import 'package:ditto/presentation/privacy/privacy.dart';
import 'package:ditto/presentation/relays_config/relays_config.dart';
import 'package:ditto/presentation/scan/scan.dart';
import 'package:ditto/presentation/settings/settings.dart';
import 'package:ditto/presentation/sign_up/sign_up.dart';
import 'package:ditto/presentation/succes_acc_made/succes_acc_made.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import '../../presentation/lnd/loading/lnd_loading.dart';
import '../../presentation/lnd_creation_success/lnd_creation_success.dart';
import '../../presentation/lnd_info_from/lnd_info_from.dart';
import '../../presentation/nip05/nip05.dart';
import '../../presentation/note_comments_section/note_comments_section.dart';
import '../../presentation/zaplocker_dashboard/zaplocker_dashboard.dart';

abstract class Routing {
  static final routes = {
    Paths.bottomBar: (context) => BottomBar(cubit: homePageAfterLoginCubit),
    Paths.onBoarding: (context) => const OnBoarding(),
    Paths.SignUp: (context) => const SignUp(),
    Paths.editProfile: (context) => EditProfile(),
    Paths.globalFeed: (context) => Umah(),
    Paths.followingFeed: (context) => FollowingsFeed(),
    Paths.commentsSection: (context) => NoteCommentsSection(),
    Paths.relaysConfig: (context) => const RelaysConfig(),
    Paths.aboutKeshi: (context) => const AboutKeshi(),
    Paths.onBoardingSearch: (context) => const OnBoardingSearch(),
    Paths.authChoose: (context) => const AuthChoose(),
    Paths.existentSignUp: (context) => const ExistentSignUp(),
    Paths.onBoardingRelays: (context) => const OnBoardingRelays(),
    Paths.followings: (context) => Followings(),
    Paths.followers: (context) => Followers(),
    Paths.nostrServiceLoading: (context) => const NostrServiceLoading(),
    Paths.settings: (context) => const Settings(),
    Paths.myKeys: (context) => const CurrentUserKeys(),
    Paths.chat: (context) => const Chat(),
    Paths.successAccountMade: (context) => const SuccessAccountMade(),
    Paths.privacyPolicy: (context) => PrivacyPolicy(
          shouldShowAcceptSwitchTile: false,
          onAccept: (v) {},
        ),
    Paths.nip05Verification: (context) => const Nip05Verification(),
    Paths.lndInfoFrom: (context) => LndInfoFrom(),
    Paths.lndCreationSuccess: (context) => LndCreationSuccess(),
    Paths.lndLoading: (context) => LndLoading(),
    Paths.zaplockerDashboard: (context) => const ZaplockerDashboard(),
  };

  static final homePageAfterLoginCubit = HomePageAfterLoginCubit();
  static final authCubit = AuthCubit();
  static final appCubit = AppCubit();
  static final onBoardingCubit = OnBoardingCubit();
  static final bottomBarCubit = BottomBarCubit();

  static BlocObserver blocObserver = MyBlocObserver();
}

class MyBlocObserver extends BlocObserver {
  @override
  void onClose(BlocBase bloc) {
    print("Bloc closed: ${bloc.runtimeType}");
    return super.onClose(bloc);
  }
}
