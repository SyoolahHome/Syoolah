import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostField extends StatelessWidget {
  const PostField({
    super.key,
    required this.expectMultiLine,
  });

  final bool expectMultiLine;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return CustomTextField(
      controller: cubit.textController!,
      isMultiline: expectMultiLine,
    );
  }
}
