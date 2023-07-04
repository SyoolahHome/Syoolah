import 'package:bloc/bloc.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:equatable/equatable.dart';

import '../../model/report_option.dart';
import '../../services/nostr/nostr_service.dart';

part 'report_state.dart';

/// {@template report_cubit}
/// The responsible cubit about reporting an existent Notst note event.
/// {@endtemplate}
class ReportCubit extends Cubit<ReportState> {
  /// The target note of this cubit.
  final Note note;

  /// {@macro report_cubit}
  ReportCubit({
    required this.note,
    required List<ReportOption> reportOptions,
  }) : super(ReportState.initial(reportOptions: reportOptions));

  /// Mark an item of [state.reportOptions as selected in order to be reflected in the UI.
  /// if a selected item is pressed, the selection will be canceled on it as well.
  /// if all item are unselected, the submit button will be disabled ([submitReport] will be ignored).
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

  /// Submits the Nostr report event to relays.
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
