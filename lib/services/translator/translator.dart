import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/translation_lang.dart';
import '../open_ai/openai.dart';

class Translator {
  static final langsCache = <String, TranslationLang>{};

  static Future<void> loadPossibleLanguages({
    void Function()? onError,
  }) async {
    try {
      final loadedAssetString =
          await rootBundle.loadString("assets/langs.json");
      final decoded = jsonDecode(loadedAssetString) as List;

      for (int index = 0; index < decoded.length; index++) {
        final curr = decoded[index];

        langsCache[curr["code"]] = TranslationLang(
          code: curr["code"],
          name: curr["name"],
          nativeName: curr["nativeName"],
        );
      }
    } catch (e) {
      debugPrint(e.toString());

      onError?.call();
    }
  }

  static Future<String> translate({
    required String text,
    required String targetLang,
  }) {
    return OpenAIService.instance.asyncResponse(
      input: text,
      instruction:
          "You're a translator, which takes a text and translates it to the ${targetLang} language, only provide the translated text.",
    );
  }
}
