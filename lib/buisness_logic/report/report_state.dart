part of 'report_cubit.dart';

class ReportState extends Equatable {
  final List<ReportOption> reportOptions;

  const ReportState({
    this.reportOptions = const [],
  });

  @override
  List<Object> get props => [reportOptions];

  ReportState copyWith({
    List<ReportOption>? reportOptions,
  }) {
    return ReportState(
      reportOptions: reportOptions ?? this.reportOptions,
    );
  }
}

class ReportInitial extends ReportState {
  ReportInitial({
    required super.reportOptions,
  });
}
