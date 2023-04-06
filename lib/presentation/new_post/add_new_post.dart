import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'widgets/button.dart';
import 'widgets/post_field.dart';
import 'widgets/title.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return BlocProvider<AddNewPostCubit>(
      create: (context) => AddNewPostCubit(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: MarginedBody(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  SizedBox(height: height * 2),
                  AddNewPostTitle(),
                  PostField(),
                  PostButton(),
                  SizedBox(height: height * 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
