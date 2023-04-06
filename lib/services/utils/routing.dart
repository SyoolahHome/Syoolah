import 'package:ditto/services/utils/paths.dart';

import '../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../presentation/bottom_bar_screen/bottom_bar_screen.dart';
import '../../presentation/edit_profile/edit_Profile.dart';
import '../../presentation/global_feed/global_feed.dart';
import '../../presentation/home/home.dart';
import '../../presentation/loading_user_resources/loading_user_resources.dart';
import '../../presentation/private_succes/private_success.dart';
import '../nostr/nostr.dart';

abstract class Routing {
  static final routes = {
    Paths.bottomBar: (context) => BottomBar(
          cubit: homePageAfterLoginCubit,
        ),
    Paths.main: (context) => const MyHomePage(),
    Paths.editProfile: (context) => EditProfile(),
    Paths.globalFeed: (context) => const GlobalFeed(),
  };

  static final homePageAfterLoginCubit = HomePageAfterLoginCubit(
    feedPostsStream: NostrService.instance.textNotesFeed(),
  );

  static final authCubit = AuthCubit();
}
