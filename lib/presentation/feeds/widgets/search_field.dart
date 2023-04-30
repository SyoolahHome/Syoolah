import 'package:ditto/buisness_logic/global_feed/global_feed_cubit.dart';
import 'package:ditto/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/app_colors.dart';
import '../../general/text_field.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GlobalFeedCubit>();

    return CustomTextField(
      label: AppStrings.search,
      controller: cubit.searchController!,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      suffix: Container(
        // margin: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            FlutterRemix.search_2_line,
            color: AppColors.grey,
            size: 15,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
