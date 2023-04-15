import 'package:ditto/constants/strings.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:flutter/material.dart';

import '../../model/profile_option.dart';
import 'widgets/profile_title.dart';

class ProfileOptionsWidget extends StatelessWidget {
  const ProfileOptionsWidget({
    super.key,
    required this.options,
  });

  final List<ProfileOption> options;

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: height * 2),
          const MarginedBody(
            child: ProfileOptionsTitle(),
          ),
          const SizedBox(height: height * 2),
          ...List.generate(
            options.length,
            (index) {
              final current = options[index];
              return ListTile(
                dense: false,
                visualDensity: VisualDensity.compact,
                contentPadding: MarginedBody.defaultMargin,
                leading: Icon(
                  current.icon,
                  size: 17.5,
                ),
                title: Text(
                  current.title,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  current.onPressed();
                },
              );
            },
          ),
          const SizedBox(height: height * 2),
        ],
      ),
    );
  }
}
