import 'package:ditto/presentation/general/info_box.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

class DangerBox extends InfoBox {
  DangerBox({
    super.key,
    required super.bgColor,
    required super.messageText,
    required super.titleText,
    super.showPopIcon = true,
  });
}
