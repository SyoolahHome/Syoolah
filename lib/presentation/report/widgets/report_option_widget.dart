import 'package:ditto/model/report_option.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_remix/flutter_remix.dart';

class ReportOptionWidget extends StatelessWidget {
  const ReportOptionWidget({
    super.key,
    required this.reportOption,
  });

  final ReportOption reportOption;

  @override
  Widget build(BuildContext context) {
    final green = Colors.green;

    return AnimatedContainer(
      duration: Animate.defaultDuration,
      height: 50,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 7.5),
      width: double.infinity,
      decoration: BoxDecoration(
          color: (reportOption.isSelected
                  ? green
                  : Theme.of(context).colorScheme.background)
              .withOpacity(.15),
          borderRadius: BorderRadius.circular(7.5),
          border: Border.all(
            color: reportOption.isSelected
                ? green
                : Theme.of(context).colorScheme.background,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(reportOption.reportType.name.capitalized),
          AnimatedScale(
            scale: reportOption.isSelected ? 1 : 0,
            duration: Duration(milliseconds: 100),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: green.withOpacity(.3),
              ),
              child: Icon(
                FlutterRemix.check_line,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
