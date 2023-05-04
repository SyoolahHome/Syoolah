import 'package:dart_openai/openai.dart';
import 'package:ditto/env/env.dart';

import '../../model/chat_message.dart';

class OpenAIService {
  static final OpenAIService _instance = OpenAIService._();
  static OpenAIService get instance => _instance;
  final modelId = "gpt-3.5-turbo";

  OpenAIService._() {
    OpenAI.apiKey = Env.apiKey;
  }

  Stream<String> messageResponseStream(List<ChatMessage> chatMessages) {
    final messages = chatMessages
        .map(
          (message) => message.toOpenAIChatMessage(),
        )
        .toList();

    return OpenAI.instance.chat
        .createStream(model: modelId, messages: messages)
        .where(_responseMessageIsValid)
        .map(_extractOnlyResposeMessage);
  }

  bool _responseMessageIsValid(OpenAIStreamChatCompletionModel event) {
    final content = event.choices.first.delta.content;
    final isNotNull = content != null;
    final isNotEmpty = (content ?? "").isNotEmpty;

    return isNotNull && isNotEmpty;
  }

  String _extractOnlyResposeMessage(OpenAIStreamChatCompletionModel event) {
    return event.choices.first.delta.content!;
  }
}
