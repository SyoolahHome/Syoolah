import 'package:ditto/presentation/new_post/widgets/youtube.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transitioned_indexed_stack/transitioned_indexed_stack.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'image.dart';

class PostAssetsSection extends StatelessWidget {
  const PostAssetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return BlocBuilder<AddNewPostCubit, AddNewPostState>(
      builder: (context, state) {
        return FadeIndexedStack(
          index: state.currentPostAssetsSectionIndex,
          children:
              cubit.postAssetsSectionsWidgets.map((e) => e.widget).toList(),
        );
      },
    );
  }
}
