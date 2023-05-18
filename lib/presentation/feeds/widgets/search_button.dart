import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../general/widget/button.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MunawarahButton(
      onTap: () {
        Navigator.of(context).pop();
        context.read<GlobalFeedCubit>().executeSearch();
      },
      iconSize: 20,
      icon: FlutterRemix.search_2_line,
      text: "search".tr(),
    );
  }
}
