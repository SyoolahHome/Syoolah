import '../database/local/local_database.dart';

abstract class Paths {
  static get initialRoute {
    final isAlreadyUserExists = LocalDatabase.instance.isAlreadyUserExists();

    if (isAlreadyUserExists) {
      return Paths.nostrServiceLoading;
    } else {
      return Paths.onBoarding;
    }
  }

  static const String authChoose = '/auth_choose';
  static const String existentSignUp = '/existentSignUp';
  static const String onBoarding = '/onBoarding';
  static const String onBoardingSearch = '/onBoardingSearch';
  static const String nostrServiceLoading = '/nostrServiceLoading';
  static const String bottomBar = '/bottomBar';
  static const String SignUp = '/SignUp';
  static const String globalFeed = '/globalFeed';
  static const String editProfile = '/editProfile';
  static const String quranFeed = '/quranFeed';
  static const String duaFeed = '/duaFeed';
  static const String shariaFeed = '/shariaFeed';
  static const String hadithFeed = '/hadithFeed';
  static const String fiqhFeed = '/fiqhFeed';
  static const String sirahFeed = '/sirahFeed';
  static const String followingFeed = '/followingFeed';
  static const String commentsSection = '/commentsSection';
  static const String relaysConfig = '/relaysConfig';
  static const String aboutMunawarah = '/aboutMunawarah';
  static const String onBoardingRelays = '/onBoardingRelays';
  static const String foreignProfile = '/foreignProfile';
  static const String followings = '/followings';
  static const String followers = '/followers';
  static const String settings = '/settings';
  static const String myKeys = '/myKeys';
  static const String chat = '/chat';
  static const String aboutApp = '/aboutApp';
  static const String successAccountMade = '/successAccountMade';
  static const String privacyPolicy = '/privacyPolicy';
}
