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
import 'package:flutter_animate/flutter_animate.dart';
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

    final mq = MediaQuery.of(context);

    return BlocProvider<AddNewPostCubit>(
      create: (context) => AddNewPostCubit(
        categories: <FeedCategory>[...AppConfigs.categories],
        initialNoteContent: initialNoteContent,
      ),
      child: Builder(builder: (context) {
        return BlocSelector<AddNewPostCubit, AddNewPostState, bool>(
          selector: (state) => state.collapseToFullScreen,
          builder: (context, collapseToFullScreen) {
            final bottomSheetHeight = collapseToFullScreen
                ? MediaQuery.of(context).size.height - 20
                : 700.0;

            return AnimatedContainer(
              duration: Animate.defaultDuration,
              height: bottomSheetHeight,
              width: MediaQuery.of(context).size.width,
              child: Builder(
                builder: (_) {
                  return SingleChildScrollView(
                    child: PatternScaffold(
                      body: SizedBox(
                        // height: bottomSheetHeight,
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
                                  Divider(
                                      color: AppColors.grey, thickness: 0.2),
                                  SizedBox(height: height),
                                  PostField(expectMultiLine: expectMultiLine),
                                  SizedBox(height: height * 2),
                                  CategoriesSelect(),
                                  SizedBox(height: height * 2),
                                ],
                              ),
                            ),
                            PostAssetsSection(),
                            SizedBox(height: 20),
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
            );
          },
        );
      }),
    );
  }
}
