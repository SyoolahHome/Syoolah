import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../general/widget/title.dart';

class AboutKeshiContent extends StatelessWidget {
  const AboutKeshiContent({super.key});

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    // final showOnlyAppDescription =
    //     args?["showOnlyAppDescription"] as bool? ?? false;

    const height = 10.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Animate(
          effects: <Effect>[
            FadeEffect(),
            SlideEffect(
              begin: Offset(0, 0.5),
            ),
          ],
          delay: 400.ms,
          child: HeadTitle(
            title: "keshiAppAboutTitle".tr(),
            isForSection: true,
            minimizeFontSizeBy: 8,
          ),
        ),
        SizedBox(height: height),
        ..."keshiAppAboutContent".tr().split("\n").indexedMap(
              (index, item) => Animate(
                  delay: (600 + index * 100).ms,
                  effects: <Effect>[
                    FadeEffect(),
                    SlideEffect(
                      begin: Offset(0, 0.5),
                    ),
                  ],
                  child: Text(
                    item + "\n",
                  )),
            ),
        SizedBox(height: height * 2),
        // if (!showOnlyAppDescription) ...[
        //   Animate(
        //     effects: <Effect>[
        //       FadeEffect(),
        //       SlideEffect(
        //         begin: Offset(0, 0.5),
        //       ),
        //     ],
        //     delay: 1000.ms,
        //     child: HeadTitle(
        //       title: "keshiNameTitle".tr(),
        //       isForSection: true,
        //       minimizeFontSizeBy: 8,
        //     ),
        //   ),
        //   SizedBox(height: height),
        //   ..."keshiNameAboutContent".tr().split("\n").indexedMap(
        //         (index, item) => Animate(
        //             delay: (1400 + index * 100).ms,
        //             effects: <Effect>[
        //               FadeEffect(),
        //               SlideEffect(
        //                 begin: Offset(0, 0.5),
        //               ),
        //             ],
        //             child: Text(
        //               item + "\n",
        //             )),
        //       )
        // ],
      ],
    );
  }
}
