import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/feed_category.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/new_post/widgets/button.dart';
import 'package:ditto/presentation/new_post/widgets/categories_select.dart';
import 'package:ditto/presentation/new_post/widgets/posr_assets_section.dart';
import 'package:ditto/presentation/new_post/widgets/post_field.dart';
import 'package:ditto/presentation/new_post/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general/pattern_widget.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({
    super.key,
    required this.initialNoteContent,
    this.expectMultiLine = false,
  });

  final String? initialNoteContent;
  final bool expectMultiLine;

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return SizedBox(
      height: 575,
      width: MediaQuery.of(context).size.width,
      child: BlocProvider<AddNewPostCubit>(
        create: (context) => AddNewPostCubit(
          categories: <FeedCategory>[...AppConfigs.categories],
          initialNoteContent: initialNoteContent,
        ),
        child: Builder(
          builder: (_) {
            return PatternScaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  height: 575,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MarginedBody(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: height * 2),
                            AddNewPostTitle(),
                            Divider(color: AppColors.grey, thickness: 0.2),
                            SizedBox(height: height),
                            PostField(expectMultiLine: expectMultiLine),
                            SizedBox(height: height * 2),
                            CategoriesSelect(),
                            SizedBox(height: height * 2),
                          ],
                        ),
                      ),
                      PostAssetsSection(),
                      Spacer(),
                      MarginedBody(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            PostButton(),
                            SizedBox(height: height * 2),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
