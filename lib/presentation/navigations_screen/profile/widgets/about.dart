import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileAbout extends StatelessWidget {
  const ProfileAbout({
    super.key,
    required this.metadata,
  });

  final UserMetaData metadata;
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [FadeEffect()],
      delay: 800.ms,
      child: Text(
        metadata.about!.capitalized,
        style: TextStyle(
          color: DefaultTextStyle.of(context).style.color?.withOpacity(.85),
        ),
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
