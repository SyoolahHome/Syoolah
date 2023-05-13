import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../general/widget/bottom_sheet_title_with_button.dart';
import 'action_button.dart';
import 'date_range_picker.dart';
import 'search_field.dart';
import 'search_options_builder.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchSections extends StatelessWidget {
  const SearchSections({
    super.key,
    required this.cubit,
  });

  final GlobalFeedCubit cubit;
  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<GlobalFeedCubit>.value(
      value: cubit,
      child: Container(
        color: Colors.white,
        child: MarginedBody(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: height * 2),
              BottomSheetTitleWithIconButton(title: "customizeSearch".tr()),
              SizedBox(height: height),
              SearchField(),
              SizedBox(height: height * 2),
              SearchOptionsBuilder(),
              SizedBox(height: height * 2),
              DateRangePicker(),
              SizedBox(height: height * 4),
              ActionButtons(),
              SizedBox(height: height * 2),
            ],
          ),
        ),
      ),
    );
  }
}
