import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocaleItem extends Equatable {
  final String applyText;
  final Locale locale;
  final String titleName;

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
}
