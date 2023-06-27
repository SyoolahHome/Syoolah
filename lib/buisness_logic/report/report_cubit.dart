import 'package:bloc/bloc.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:equatable/equatable.dart';

import '../../model/report_option.dart';
import '../../services/nostr/nostr_service.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final Note note;

  ReportCubit({
    required this.note,
    required List<ReportOption> reportOptions,
  }) : super(ReportInitial(reportOptions: reportOptions));

  void toggleReportTypeAt(int indexOfType) {
    final newStateList = state.reportOptions.indexedMap((index, item) {
      if (indexOfType == index) {
        final isSelected = item.isSelected;
        return item.copyWithIsSelected(isSelected: !isSelected);
      } else {
        return item.copyWithIsSelected(isSelected: false);
      }
    });

    emit(state.copyWith(reportOptions: newStateList));
  }

  void submitReport({
    required void Function() onSuccess,
  }) {
    final selectedReportOption =
        state.reportOptions.firstWhere((option) => option.isSelected);

    NostrService.instance.send.sendReportEvent(
      note: note,
      selectedReportType: selectedReportOption.reportType.name,
    );

    onSuccess.call();
  }
}
