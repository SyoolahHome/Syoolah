import 'package:equatable/equatable.dart';

class ReportOption extends Equatable {
  ReportOption({
    this.isSelected = false,
    required this.reportType,
  });

  final ReportType reportType;
  final bool isSelected;

  @override
  List<Object?> get props => [reportType, isSelected];

  ReportOption copyWithIsSelected({
    bool? isSelected,
  }) {
    return ReportOption(
      isSelected: isSelected ?? this.isSelected,
      reportType: reportType,
    );
  }
}

// source: https://github.com/nostr-protocol/nips/blob/master/56.md
enum ReportType {
  nudity,
  profanity,
  illegal,
  spam,
  impersonation,
}
