import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return BlocBuilder<AddNewPostCubit, AddNewPostState>(
      builder: (context, state) {
        return state.pickedImages == null ||
                (state.pickedImages?.isEmpty ?? false)
            ? const SizedBox.shrink()
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(AppStrings.selectedImage),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(state.pickedImages?.length ?? 0,
                          (index) {
                        final current = state.pickedImages![index];

                        return AnimatedSwitcher(
                          transitionBuilder: (child, animation) =>
                              ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            key: ValueKey(current.path),
                            margin: const EdgeInsets.only(right: 5),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Image.file(
                                    current,
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                IconButton(
                                  iconSize: 15,
                                  // padding: EdgeInsets.zero,

                                  style: IconButton.styleFrom(
                                      backgroundColor:
                                          AppColors.black.withOpacity(0.05)),
                                  color: Colors.red,
                                  onPressed: () {
                                    cubit.removePickedImage(index);
                                  },
                                  icon: const Icon(
                                    FlutterRemix.delete_bin_2_line,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
