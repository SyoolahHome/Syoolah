import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/image_full_view..dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("photos".tr()),
        const SizedBox(height: 15),
        BlocBuilder<AddNewPostCubit, AddNewPostState>(
          builder: (context, state) {
            return state.pickedImages == null ||
                    (state.pickedImages?.isEmpty ?? false)
                ? Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(.3),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              state.pickedImages?.length ?? 0, (index) {
                            final current = state.pickedImages![index];

                            return GestureDetector(
                              onLongPress: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ImageFullView(
                                      imageFile: current,
                                      heroTag: current.path,
                                    ),
                                  ),
                                );
                              },
                              child: AnimatedSwitcher(
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
                                          Radius.circular(10),
                                        ),
                                        child: Image.file(
                                          current,
                                          height: 75,
                                          width: 75,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      IconButton(
                                        iconSize: 15,
                                        // padding: EdgeInsets.zero,

                                        style: IconButton.styleFrom(
                                          backgroundColor:
                                              AppColors.black.withOpacity(0.05),
                                        ),
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
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ],
    );
  }
}
