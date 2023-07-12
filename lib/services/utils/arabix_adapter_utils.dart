import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_remix/flutter_remix.dart';

mixin ArabicAdapterUtils {
  bool isArabic(BuildContext context) {
    return context.locale.languageCode.toLowerCase() == "ar";
  }

  IconData directionalityIcon(
    BuildContext context, {
    required IconData onArabicIcon,
    required IconData onNonArabicIcon,
  }) {
    if (onArabicIcon == onNonArabicIcon) {
      throw Exception("You could just put your icon directly");
    }

    return isArabic(context) ? onArabicIcon : onNonArabicIcon;
  }
}
