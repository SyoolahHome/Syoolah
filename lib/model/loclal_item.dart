// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// {@template local_item}
/// A model class representing a lang locale of M.
/// {@endtemplate}
@immutable
class LocaleItem extends Equatable {
  /// The text of the buttpn to shown when moving to this local item in M.
  final String applyText;

  /// The locale object that will be passed through the app code to activate it for the user.
  final Locale locale;

  /// The name of the locale to be shown
  final String titleName;

  /// {@macro local_item}
  const LocaleItem({
    required this.applyText,
    required this.locale,
    required this.titleName,
  });

  @override
  List<Object?> get props => [
        applyText,
        locale,
        titleName,
      ];

  /// {@macro local_item}
  LocaleItem copyWith({
    String? applyText,
    Locale? locale,
    String? titleName,
  }) {
    return LocaleItem(
      applyText: applyText ?? this.applyText,
      locale: locale ?? this.locale,
      titleName: titleName ?? this.titleName,
    );
  }
}
