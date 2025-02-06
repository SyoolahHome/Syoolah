import 'package:ditto/constants/app_enums.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';

class UserEnumSelection extends StatelessWidget {
  const UserEnumSelection({
    super.key,
    required this.title,
    required this.enumValues,
  });

  final String title;
  final List<EnumWithTitleGetter> enumValues;

  @override
  Widget build(BuildContext context) {
    final heightSpace = 10.0;

    return MarginedBody(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: heightSpace * 2),
          BottomSheetTitleWithIconButton(title: title),
          SizedBox(height: heightSpace * 2),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: enumValues.map((type) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 125,
                        child: Material(
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(.4),
                          child: InkWell(
                            onTap: () => Navigator.pop(context, type),
                            child: Center(
                              child: Text(
                                type.title,
                                style: Theme.of(context).textTheme.titleLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: heightSpace * 2),
        ],
      ),
    );
  }
}
