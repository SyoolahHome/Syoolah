import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/presentation/feeds/widgets/action_button.dart';
import 'package:ditto/presentation/feeds/widgets/date_range_picker.dart';
import 'package:ditto/presentation/feeds/widgets/search_field.dart';
import 'package:ditto/presentation/feeds/widgets/search_options_builder.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        color: Theme.of(context).scaffoldBackgroundColor,
        child: MarginedBody(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: height * 2),
              BottomSheetTitleWithIconButton(title: "CustomizedSearch".tr()),
              const SizedBox(height: height),
              const SearchField(),
              const SizedBox(height: height * 2),
              const SearchOptionsBuilder(),
              const SizedBox(height: height * 2),
              const DateRangePicker(),
              const SizedBox(height: height * 4),
              const ActionButtons(),
              const SizedBox(height: height * 2),
            ],
          ),
        ),
      ),
    );
  }
}
