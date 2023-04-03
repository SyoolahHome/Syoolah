import 'dart:math';

import 'package:convert/convert.dart';

abstract class NostrClientUtils {
  static String random64HexChars() {
    final random = Random.secure();
    final randomBytes = List<int>.generate(32, (i) => random.nextInt(256));
    return hex.encode(randomBytes);
  }
}
