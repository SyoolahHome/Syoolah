import 'package:ditto/constants/strings.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import '../model/feed_category.dart';

abstract class AppConfigs {
  static final List<FeedCategory> categories = [
    const FeedCategory(
      path: Paths.quranFeed,
      icon: FlutterIslamicIcons.quran,
      isSelected: false,
      name: AppStrings.quran,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.duaFeed,
      icon: FlutterIslamicIcons.prayer,
      isSelected: false,
      name: AppStrings.dua,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.shariaFeed,
      icon: FlutterIslamicIcons.kowtow,
      isSelected: false,
      name: AppStrings.sharia,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.hadithFeed,
      icon: FlutterIslamicIcons.sajadah,
      isSelected: false,
      name: AppStrings.hadith,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.fiqhFeed,
      icon: FlutterIslamicIcons.family,
      isSelected: false,
      name: AppStrings.fiqh,
      description: "This feed contains Quran",
    ),
    const FeedCategory(
      path: Paths.sirahFeed,
      icon: FlutterIslamicIcons.solidMuslim,
      isSelected: false,
      name: AppStrings.sirah,
      description: "This feed contains Quran",
    ),
  ];
}
