import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

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
