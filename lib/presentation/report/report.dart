import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../buisness_logic/report/report_cubit.dart';
import '../general/pattern_widget.dart';
import '../general/widget/bottom_sheet_title_with_button.dart';
import '../general/widget/margined_body.dart';
import 'widgets/report_option_widget.dart';

class ReportSheetWidget extends StatelessWidget {
  const ReportSheetWidget({
    super.key,
    required this.note,
    required this.noteCardContext,
  });

  final Note note;
  final BuildContext noteCardContext;

  @override
  Widget build(BuildContext context) {
    final height = 10.0;

    return BlocProvider<ReportCubit>(
      create: (context) => ReportCubit(
        reportOptions: AppConfigs.reportOptions,
        note: note,
      ),
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          final reportOptions = state.reportOptions;
          final cubit = context.read<ReportCubit>();
          final atLeastOneSelected =
              reportOptions.any((option) => option.isSelected);

          return PatternScaffold(
            body: Container(
              padding: EdgeInsets.all(MarginedBody.defaultMargin.left),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  BottomSheetTitleWithIconButton(title: "report".tr()),
                  HeadTitle(title: "selectReport"),
                  SizedBox(height: height * 2),
                  ...List.generate(
                    reportOptions.length,
                    (index) => GestureDetector(
                      onTap: () {
                        cubit.toggleReportTypeAt(index);
                      },
                      child: ReportOptionWidget(
                        reportOption: reportOptions[index],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 2),
                  SizedBox(
                    width: double.infinity,
                    child: UmrahtyButton(
                      onTap: atLeastOneSelected
                          ? () {
                              cubit.submitReport(
                                onSuccess: () {
                                  SnackBars.text(
                                      noteCardContext, "reportedText".tr());
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          : null,
                      text: "submit".tr(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
