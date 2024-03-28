import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

class AppBrandButton extends StatelessWidget {
  const AppBrandButton({
    super.key,
    required this.onTap,
    this.text,
    this.padding,
    this.isSmall = false,
    this.isRounded = true,
    this.icon,
    this.isOnlyBorder = false,
    this.customWidget,
    this.iconSize,
    this.mainColor,
    this.additonalFontSize = 0,
  });

  final VoidCallback? onTap;
  final String? text;
  final bool isSmall;
  final bool isRounded;
  final bool isOnlyBorder;
  final IconData? icon;
  final Widget? customWidget;
  final double? iconSize;
  final Color? mainColor;
  final double additonalFontSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      layoutBuilder: (currentChild, previousChildren) => currentChild!,
      duration: 200.ms,
      child: SizedBox(
        key: ValueKey<String>(text.toString()),
        height: isSmall ? 30 : null,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: isOnlyBorder
                ? Colors.transparent
                : mainColor ?? Theme.of(context).colorScheme.background,
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: .5,
                color: isOnlyBorder
                    ? mainColor ?? Theme.of(context).colorScheme.background
                    : Colors.transparent,
              ),
              borderRadius: isSmall
                  ? BorderRadius.circular(100)
                  : BorderRadius.circular(10),
            ),
            disabledBackgroundColor:
                Theme.of(context).colorScheme.background.withOpacity(.7),
          ),

          // ElevatedButton.styleFrom(
          //   backgroundColor: false
          //       ? Colors.transparent
          //       : mainColor ?? Theme.of(context).colorScheme.background,
          // ).copyWith(
          //   // backgroundColor: MaterialStateProperty.all<Color>(
          //   //   ),
          //   overlayColor:
          //       Theme.of(context).elevatedButtonTheme.style!.overlayColor!,
          //   elevation: MaterialStateProperty.resolveWith<double>((states) {
          //     if (states.contains(MaterialState.pressed)) {
          //       return Theme.of(context)
          //           .elevatedButtonTheme
          //           .style!
          //           .elevation!
          //           .resolve(states)!;
          //     } else {
          //       return isOnlyBorder
          //           ? 0
          //           : isSmall
          //               ? 1
          //               : 4;
          //     }
          //   }
          //       // isOnlyBorder ? 0 : 1,
          //       ),
          //   side: MaterialStateProperty.all<BorderSide>(
          //     isOnlyBorder
          //         ? BorderSide(
          //             color:
          //                 mainColor ?? Theme.of(context).colorScheme.background,
          //           )
          //         : BorderSide.none,
          //   ),
          //   shape: MaterialStateProperty.all<OutlinedBorder>(
          //     RoundedRectangleBorder(
          //       borderRadius: isSmall
          //           ? BorderRadius.circular(100)
          //           : BorderRadius.circular(10),
          //     ),
          //   ),
          //   padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          //     EdgeInsets.symmetric(horizontal: isSmall ? 15 : 0),
          //   ),
          //   foregroundColor: MaterialStateProperty.all(
          //     Theme.of(context).colorScheme.surface,
          //   ),
          // ),
          //
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (customWidget != null) customWidget!,
                if (text != null)
                  Text(
                    text!,
                    style: TextStyle(
                      color: isOnlyBorder
                          ? mainColor ??
                              Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.onBackground,
                      fontSize: (isSmall ? 11 : 17) + additonalFontSize,
                      fontWeight: FontWeight.w400,
                      fontFamily:
                          Theme.of(context).textTheme.bodyText1!.fontFamily,
                    ),
                  ),
                if (text != null && icon != null) const SizedBox(width: 7.5),
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: iconSize != null
                        ? iconSize!
                        : isSmall
                            ? 12.5
                            : 15,
                    color: isOnlyBorder
                        ? mainColor ?? Theme.of(context).colorScheme.background
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  factory AppBrandButton.bottomSheetApply({
    required String buttonText,
    required Locale locale,
    required bool isCurrentApplied,
    required void Function() onTap,
  }) {
    return AppBrandButton(
      onTap: () {
        if (isCurrentApplied) {
          return;
        }

        onTap();
      },
      isOnlyBorder: isCurrentApplied,
      text: isCurrentApplied ? null : buttonText,
      icon: isCurrentApplied ? FlutterRemix.check_line : null,
      isSmall: true,
    );
  }

  static Widget bottomSheetSwitch({
    required Locale locale,
    required bool isCurrentApplied,
    required void Function() onTap,
  }) {
    return Transform.scale(
      scale: 0.65,
      child: Switch(
        onChanged: (value) {
          if (isCurrentApplied) {
            return;
          }

          onTap();
        },
        value: isCurrentApplied,
      ),
    );
  }
}
