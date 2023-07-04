import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

class InfoBox extends StatelessWidget {
  InfoBox({
    super.key,
    required this.titleText,
    required this.bgColor,
    required this.showPopIcon,
    this.messageText,
  });

  final String? messageText;
  final String titleText;
  final Color bgColor;
  final bool showPopIcon;

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
                    children: <Widget>[
                      const SizedBox(height: height * 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        decoration: BoxDecoration(
                          color: bgColor,
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
                                  titleText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                if (showPopIcon)
                                  IconButton(
                                    onPressed: hideBox,
                                    icon: const Icon(FlutterRemix.close_line),
                                  ),
                              ],
                            ),
                            if (messageText != null) ...[
                              // const SizedBox(height: height / 2),
                              Text(messageText!)
                            ],
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
