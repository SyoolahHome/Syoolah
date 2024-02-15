import 'package:flutter_tts/flutter_tts.dart';

class TTS {
  static late final FlutterTts? flutterTts;

  static Future<void> init() async {
    flutterTts = FlutterTts();
  }

  static Future<void> speak({
    required String text,
    String? language,
  }) async {
    final langToUse = language ?? "en-US";

    if (flutterTts == null) {
      await init();
    }

    final voices = await flutterTts!.getVoices;

    if (await flutterTts!.isLanguageAvailable(langToUse)) {
      await flutterTts!.setLanguage(langToUse);
    }

    await flutterTts!.speak(text);
    await flutterTts!.awaitSpeakCompletion(true);
  }

  static Future<void> stop() async {
    await flutterTts!.stop();
  }
}
