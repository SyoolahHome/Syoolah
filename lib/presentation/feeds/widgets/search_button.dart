import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../buisness_logic/global_feed/global_feed_cubit.dart';
import '../../../constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.teal),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        context.read<GlobalFeedCubit>().executeSearch();
      },
      icon: const Icon(
        FlutterRemix.search_2_line,
        color: AppColors.white,
        size: 17,
      ),
      label: Text(
        "search".tr(),
        style: TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }
}
