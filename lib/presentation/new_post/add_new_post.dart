import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/add_new_post/add_new_post_cubit.dart';

class AddNewPost extends StatelessWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddNewPostCubit>(
      create: (context) => AddNewPostCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AddNewPostCubit>();
          return Scaffold(
            body: SizedBox(
              height: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Add new post'),
                  TextField(
                    controller: cubit.textController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cubit.createNote();
                    },
                    child: const Text('add'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
