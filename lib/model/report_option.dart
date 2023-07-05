// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../constants/app_enums.dart';

/// {@template report_option}
/// A model class that holds a Nostr notes report  types.
/// {@endtemplate}

@immutable
class ReportOption extends Equatable {
  /// The type of the report.
  final ReportType reportType;

  /// Weither this report option is selected by the user or not.
  final bool isSelected;

  /// {@macro report_option}
  ReportOption({
    this.isSelected = false,
    required this.reportType,
  });

  @override
  List<Object?> get props => [reportType, isSelected];

  /// {@macro report_option}
  ReportOption copyWithIsSelected({
    bool? isSelected,
  }) {
    return copyWith(isSelected: isSelected);
  }

  /// {@macro report_option}
  ReportOption copyWith({
    ReportType? reportType,
    bool? isSelected,
  }) {
    return ReportOption(
      reportType: reportType ?? this.reportType,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
