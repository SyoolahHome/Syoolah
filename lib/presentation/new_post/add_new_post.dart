import 'package:ditto/constants/configs.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import '../../constants/colors.dart';
import 'widgets/button.dart';
import 'widgets/categories_select.dart';
import 'widgets/image.dart';
import 'widgets/post_field.dart';
import 'widgets/title.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return SizedBox(
      height: 575,
      width: MediaQuery.of(context).size.width,
      child: BlocProvider<AddNewPostCubit>(
        create: (context) => AddNewPostCubit(
          categories: [...AppConfigs.categories],
        ),
        child: Builder(
          builder: (_) {
            return Scaffold(
              body: MarginedBody(
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: 575,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        SizedBox(height: height * 2),
                        AddNewPostTitle(),
                        Divider(color: AppColors.grey, thickness: 0.2),
                        SizedBox(height: height),
                        PostField(),
                        SizedBox(height: height * 2),
                        CategoriesSelect(),
                        SizedBox(height: height * 2),
                        PostImage(),
                        Spacer(),
                        PostButton(),
                        SizedBox(height: height * 2),
                      ],
                    ),
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
