import 'package:ditto/services/database/local/local_database.dart';

abstract class Paths {
  static String get initialRoute {
    final isAlreadyUserExists = LocalDatabase.instance.isAlreadyUserExists();

    if (isAlreadyUserExists) {
      return Paths.nostrServiceLoading;
    } else {
      return Paths.onBoarding;
    }
  }

  static const String lndLoading = '/lndLoading';
  static const String authChoose = '/auth_choose';
  static const String existentSignUp = '/existentSignUp';
  static const String onBoarding = '/onBoarding';
  static const String onBoardingSearch = '/onBoardingSearch';
  static const String nostrServiceLoading = '/nostrServiceLoading';
  static const String bottomBar = '/bottomBar';
  static const String SignUp = '/SignUp';
  static const String globalFeed = '/globalFeed';
  static const String editProfile = '/editProfile';
  static const String followingFeed = '/followingFeed';
  static const String commentsSection = '/commentsSection';
  static const String relaysConfig = '/relaysConfig';
  static const String aboutUmrahty = '/aboutUmrahty';
  static const String onBoardingRelays = '/onBoardingRelays';
  static const String foreignProfile = '/foreignProfile';
  static const String followings = '/followings';
  static const String followers = '/followers';
  static const String settings = '/settings';
  static const String myKeys = '/myKeys';
  static const String chat = '/chat';
  static const String successAccountMade = '/successAccountMade';
  static const String privacyPolicy = '/privacyPolicy';
  static const String nip05Verification = '/nip05Verification';
  static const String tangemAuth = "/tangemAuth";
  static const String lndInfoFrom = "/lndInfoFrom";
  static const String lndCreationSuccess = "/lndCreationSuccess";
  static const String zaplockerDashboard = "/zaplockerDashboard";
}
