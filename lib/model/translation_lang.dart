import 'package:equatable/equatable.dart';

class TranslationLang extends Equatable {
  final String name;
  final String nativeName;
  final String code;

  const TranslationLang({
    required this.name,
    required this.nativeName,
    required this.code,
  });

  static TranslationLang get defaultLang => TranslationLang(
        code: "ar",
        name: "Arabic",
        nativeName: "العربية",
      );

  @override
  List<Object?> get props => [
        name,
        nativeName,
        code,
      ];
}
