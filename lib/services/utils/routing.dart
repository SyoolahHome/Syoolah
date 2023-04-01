import 'package:ditto/services/utils/paths.dart';

import '../../presentation/bottom_bar_screen/bottom_bar_screen.dart';
import '../../presentation/edit_profile/edit_Profile.dart';
import '../../presentation/home/home.dart';
import '../../presentation/loading_user_resources/loading_user_resources.dart';
import '../../presentation/private_succes/private_success.dart';

abstract class Routing {
  static final routes = {
    Paths.bottomBar: (context) => const BottomBar(),
    Paths.main: (context) => const MyHomePage(),
    Paths.editProfile: (context) => EditProfile()
  };
}
