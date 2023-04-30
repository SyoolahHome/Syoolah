import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../model/bottom_sheet_option.dart';
import 'widgets/profile_title.dart';

class BottomSheetOptionsWidget extends StatelessWidget {
  const BottomSheetOptionsWidget({
    super.key,
    required this.options,
    this.title,
  });

  final List<BottomSheetOption> options;
  final String? title;
  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return Container(
      color: Theme.of(context).bottomSheetTheme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: height * 2),
            MarginedBody(child: BottomSheetOptionsTitle(title: title)),
            const SizedBox(height: height * 2),
            ...List.generate(
              options.length,
              (index) {
                final current = options[index];
                return Animate(
                  delay: Duration(milliseconds: 200 + (index * 200)),
                  effects: const <Effect>[
                    FadeEffect(),
                    SlideEffect(begin: Offset(0, 0.45)),
                  ],
                  child: ListTile(
                    trailing: current.trailing,
                    dense: false,
                    visualDensity: VisualDensity.compact,
                    contentPadding: MarginedBody.defaultMargin,
                    leading: Icon(
                      current.icon,
                      size: 17.5,
                      color: Theme.of(context).colorScheme.background,
                    ),
                    title: Builder(builder: (context) {
                      final title = current.title;
                      if (title.split(':').length >= 2) {
                        return Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "${title.split(':')[0]} : ",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              TextSpan(
                                text: title.split(':')[1],
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text(
                          title,
                          style: Theme.of(context).textTheme.labelMedium,
                        );
                      }
                    }),
                    onTap: () {
                      Navigator.of(context).pop();
                      final onPressed = current.onPressed;
                      if (onPressed != null) onPressed;
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: height * 2),
          ],
        ),
      ),
    );
  }
}
