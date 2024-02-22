import 'dart:convert';
import 'dart:io';

import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../env/env.dart';
import '../../model/tts_voice.dart';

class TTS {
  static late final AudioPlayer? player;

  static Future<void> init() async {
    player = AudioPlayer();
  }

  static Future<void> speak({
    required String text,
    required BuildContext context,
  }) async {
    final voiceId = await BottomSheetService.getVoiceId(context);

    if (voiceId == null) {
      return;
    }

    final file = await _generateAISpeechFile(
      text,
      voiceId: voiceId,
    );

    await player!.setFilePath(file.path);

    await player!.play();
  }

  static Future<void> stop() async {
    await player!.stop();
  }

  static Future<File> _generateAISpeechFile(
    String text, {
    required String voiceId,
  }) async {
    try {
      final headers = {
        "xi-api-key": Env.elevenLabsApiKey,
        "Content-Type": "application/json",
      };

      final body = {
        "text": text,
        "model_id": "eleven_multilingual_v2",
      };

      final uri = Uri.parse(
        'https://api.elevenlabs.io/v1/text-to-speech/$voiceId',
      );

      final res = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final temp = await getTemporaryDirectory();

        final file = File('${temp.path}/tts.mp3');

        await file.writeAsBytes(res.bodyBytes);

        return file;
      } else {
        throw Exception('Failed to generate AI speech file');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<List<TtsVoice>> voices() async {
    try {
      final res = await http.get(
        Uri.parse('https://api.elevenlabs.io/v1/voices'),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final data = jsonDecode(res.body) as Map<String, dynamic>;
        final voices = data['voices'] as List<dynamic>;

        return voices.map((e) => TtsVoice.fromMap(e)).toList();
      } else {
        throw Exception('Failed to fetch voices');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
