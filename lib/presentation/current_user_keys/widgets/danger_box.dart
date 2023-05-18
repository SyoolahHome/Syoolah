import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

class DangerBox extends StatelessWidget {
  DangerBox({super.key});

  bool _isHidden = false;
  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return StatefulBuilder(
      builder: (context, setState) {
        void hideBox() {
          setState(() {
            _isHidden = true;
          });
        }

        return Animate(
          target: _isHidden ? 0.0 : 1.0,
          effects: const <Effect>[
            FadeEffect(),
            SlideEffect(
              begin: Offset(0, -0.5),
            ),
          ],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (context) {
                  Widget widget = Column(
                    children: [
                      const SizedBox(height: height * 2),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .errorContainer
                              .withOpacity(.45),
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "warning".tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                GestureDetector(
                                  onTap: hideBox,
                                  child: const Icon(FlutterRemix.close_line),
                                )
                              ],
                            ),
                            const SizedBox(height: height / 2),
                            Text("dangerDoNotSharePrivateKeys".tr()),
                          ],
                        ),
                      ),
                    ],
                  );
                  if (_isHidden) {
                    return FutureBuilder<bool>(
                      future:
                          Future.delayed(Animate.defaultDuration, () => true),
                      initialData: false,
                      builder: (context, snapshot) {
                        if (snapshot.data!) {
                          return const SizedBox.shrink();
                        } else {
                          return widget;
                        }
                      },
                    );
                  }
                  return widget;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
