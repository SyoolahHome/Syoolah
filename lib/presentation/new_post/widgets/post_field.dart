import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import '../../general/text_field.dart';

class PostField extends StatelessWidget {
  const PostField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return CustomTextField(
      label: "yourPost".tr(),
      controller: cubit.textController!,
    );
  }
}
