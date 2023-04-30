// ignore_for_file: avoid-ignoring-return-values, prefer-match-file-name
import 'package:dart_openai/openai.dart';

class OpenAIService {
  static final OpenAIService _instance = OpenAIService._();
  static OpenAIService get instance => _instance;

  OpenAIService._() {
    OpenAI.apiKey = "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";
  }
  void test() {
    final stream = OpenAI.instance.chat.createStream(
      model: "gpt-3.5-turbo",
      messages: <OpenAIChatCompletionChoiceMessageModel>[
        OpenAIChatCompletionChoiceMessageModel(
          role: OpenAIChatMessageRole.system,
          content:
              "You are a experienced web doveloper who knows everything about react.js",
        ),
      ],
    );

    stream.listen((event) {
      print(event.choices.first.delta.content);
    });
  }
}
