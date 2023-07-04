part of 'report_cubit.dart';

/// {@template report_state}
///  The state of [ReportCubit].
/// {@endtemplate}
class ReportState extends Equatable {
  /// The list of report options that the user can select from.
  final List<ReportOption> reportOptions;

  /// {@macro report_state}
  const ReportState({
    this.reportOptions = const [],
  });

  @override
  List<Object> get props => [reportOptions];

  /// {@macro report_state}
  ReportState copyWith({
    List<ReportOption>? reportOptions,
  }) {
    return ReportState(
      reportOptions: reportOptions ?? this.reportOptions,
    );
  }

  factory ReportState.initial({
    required List<ReportOption> reportOptions,
  }) {
    return ReportInitial(reportOptions: reportOptions);
  }
}

/// {@macro report_state}
class ReportInitial extends ReportState {
  ReportInitial({
    required super.reportOptions,
  });
}
