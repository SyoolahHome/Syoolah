import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/image_full_view..dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/abstractions/abstractions.dart';
import '../../general/widget/margined_body.dart';

class PostImage extends NewPostAssetWidget {
  const PostImage({
    super.key,
    required this.onActionPressed,
  });

  final VoidCallback onActionPressed;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return Container(
      // padding: EdgeInsets.only(left: MarginedBody.defaultMargin.left),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MarginedBody(
            child: Text("photos".tr()),
          ),
          const SizedBox(height: 15),
          BlocBuilder<AddNewPostCubit, AddNewPostState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: MarginedBody.defaultMargin,
                      child: Row(
                        children: List.generate(
                            (state.pickedImages?.length ?? 0) + 1, (index) {
                          if (index == 0) {
                            return GestureDetector(
                              onTap: onActionPressed,
                              child: Container(
                                height: 75,
                                width: 75,
                                margin: EdgeInsets.only(right: 15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(.3),
                                ),
                                child: Center(
                                  child: Icon(
                                    FlutterRemix.image_add_line,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background
                                        .withOpacity(.8),
                                  ),
                                ),
                              ),
                            );
                          }

                          final newIndex = index - 1;
                          final current = state.pickedImages![newIndex];

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
                                      child: FutureBuilder(
                                          future: current.readAsBytes(),
                                          builder: (context, state) {
                                            if (state.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            }

                                            if (state.connectionState ==
                                                ConnectionState.done) {
                                              return Image.memory(
                                                state.data!,
                                                height: 75,
                                                width: 75,
                                                fit: BoxFit.cover,
                                              );
                                            }

                                            return const SizedBox.shrink();
                                          }),
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
                                        cubit.removePickedImage(newIndex);
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
