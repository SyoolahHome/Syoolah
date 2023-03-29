import 'package:ditto/services/utils/paths.dart';

import '../../presentation/bottom_bar_screen/bottom_bar_screen.dart';
import '../../presentation/private_succes/private_success.dart';

abstract class Routing {
  static final routes = {
    Paths.privateGeneratedSuccessfully: (context) =>
        const PrivateGeneratedSuccessfully(),
    Paths.bottomBar: (context) => const BottomBar(),
  };
}
