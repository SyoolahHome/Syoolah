import 'package:ditto/services/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CopyButtonOverlay extends StatelessWidget {
  const CopyButtonOverlay({
    super.key,
    required this.child,
    this.show = true,
    required this.onTap,
    this.onClearTap,
    this.onSoundTap,
    this.onShareAsNoteTap,
    this.onGoChat,
    this.audioOn = false,
    this.disableCopyAndSound = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onClearTap;
  final VoidCallback? onSoundTap;
  final VoidCallback? onShareAsNoteTap;
  final VoidCallback? onGoChat;
  final bool show;
  final bool audioOn;
  final bool disableCopyAndSound;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        Positioned(
          left: AppUtils.instance.isArabic(context) ? 5 : null,
          right: AppUtils.instance.isArabic(context) ? null : 5,
          bottom: 5,
          child: Animate(
            target: show ? 1 : 0,
            effects: [
              FadeEffect(
                duration: Duration(milliseconds: 300),
              ),
              SlideEffect(
                duration: Duration(milliseconds: 300),
              ),
            ],
            child: Row(
              children: [
                if (onGoChat != null)
                  IconButton(
                    highlightColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.2),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(
                        disableCopyAndSound ? .4 : 1,
                      ),
                    ),
                    onPressed: () {
                      if (disableCopyAndSound) {
                        return;
                      }

                      onGoChat?.call();
                    },
                    icon: SvgPicture.asset(
                      "assets/images/alIttihadGPT.svg",
                      width: 20,
                      height: 20,
                    ),
                  ),
                if (onSoundTap != null)
                  IconButton(
                    highlightColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.2),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(
                        audioOn || disableCopyAndSound ? .4 : 1,
                      ),
                    ),
                    onPressed: () {
                      if (audioOn || disableCopyAndSound) {
                        return;
                      }

                      onSoundTap?.call();
                    },
                    icon: Icon(
                      Icons.multitrack_audio_rounded,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                if (onShareAsNoteTap != null)
                  IconButton(
                    highlightColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.2),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: onShareAsNoteTap,
                    icon: Icon(
                      FlutterRemix.quill_pen_fill,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                IconButton(
                  highlightColor: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(.2),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(
                      disableCopyAndSound ? .4 : 1,
                    ),
                  ),
                  onPressed: onTap,
                  icon: Icon(
                    Icons.copy,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                if (onClearTap != null)
                  IconButton(
                    highlightColor: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.2),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(
                        disableCopyAndSound ? .4 : 1,
                      ),
                    ),
                    onPressed: onClearTap,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
