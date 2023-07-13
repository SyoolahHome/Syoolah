import 'package:ditto/presentation/bottom_bar_screen/widgets/bottom_bar.dart';
import 'package:ditto/presentation/general/pattern_widget.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class OnBoardingSearchUserMetadataPropertiesSheet extends StatelessWidget {
  const OnBoardingSearchUserMetadataPropertiesSheet({
    super.key,
    required this.properties,
  });

  final Iterable<MapEntry<String, dynamic>> properties;

  @override
  Widget build(BuildContext context) {
    final propertiesAsList = properties.toList();

    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        height: 600.0,
        child: PatternScaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.0),
                BottomSheetTitleWithIconButton.onlyCloseButton(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: propertiesAsList.indexedMap(
                    (index, entry) {
                      // TODO: show the actual image from it's link directly.
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        color: index % 2 == 0
                            ? AppColors.lighGrey.withOpacity(.1)
                            : Colors.transparent,
                        child: SizedBox(
                          width: double.infinity,
                          child: MarginedBody(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SelectableText(
                                  entry.key.capitalized,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                SizedBox(height: 3.0),
                                SelectableText(
                                    entry.value.toString().capitalized),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
