// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_KEY')
  static const apiKey = _Env.apiKey;

  @EnviedField(varName: 'APP_VERSION')
  static const appVersion = _Env.appVersion;

  static const elevenLabsApiKey = _Env.elevenLabsApiKey;
}
