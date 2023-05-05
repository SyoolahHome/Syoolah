import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/add_new_post/add_new_post_cubit.dart';
import '../../../constants/app_colors.dart';
import '../../../services/utils/snackbars.dart';

class PostButton extends StatelessWidget {
  const PostButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return Row(
      children: [
        IconButton(
          onPressed: () {
            cubit.addImage();
          },
          icon: Icon(
            FlutterRemix.image_add_line,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        IconButton(
          onPressed: () {
            // cubit.setYoutubeVideo();
          },
          icon: Icon(
            FlutterRemix.youtube_line,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        Spacer(),
        BlocConsumer<AddNewPostCubit, AddNewPostState>(
          listener: (_, state) {
            if (state.success != null) {
              Navigator.maybePop(context);
              SnackBars.text(context, state.success!);
            }
            if (state.error != null) {
              SnackBars.text(context, state.error!);
            }
          },
          builder: (_, state) {
            return SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  cubit.createNote();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.teal),
                ),
                child: state.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 1.2,
                        ),
                      )
                    : Text(
                        "createNewPost".tr(),
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: AppColors.white,
                            ),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
