import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewPostCubit, AddNewPostState>(
      builder: (context, state) {
        return state.pickedImage == null
            ? const SizedBox.shrink()
            : Image.file(state.pickedImage!);
      },
    );
  }
}
