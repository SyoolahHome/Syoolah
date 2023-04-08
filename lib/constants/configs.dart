import '../model/feed_category.dart';

abstract class AppConfigs {
  static final List<FeedCategory> categories = [
    ...List.generate(
      8,
      (i) => FeedCategory(name: "Test $i"),
    )
  ];
}
