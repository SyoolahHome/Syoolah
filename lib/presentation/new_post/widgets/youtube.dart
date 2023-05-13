import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../general/text_field.dart';

class PostYoutube extends StatelessWidget {
  const PostYoutube({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("selectedYoutube".tr()),
        const SizedBox(height: 15),
        BlocConsumer<AddNewPostCubit, AddNewPostState>(
          listener: (context, state) {
            if (state.error != null) {
              SnackBars.text(
                context,
                state.error!,
                isError: true,
              );
            }
          },
          builder: (context, state) {
            final acceptedYoutubeUrl = state.acceptedYoutubeUrl;

            if (acceptedYoutubeUrl != null) {
              return ListTile(
                title: Text(acceptedYoutubeUrl),
              );
            }
            return CustomTextField(
              bgColor: Theme.of(context).colorScheme.onPrimary,
              hint: "youtubeUrlHint".tr(),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              controller: cubit.youtubeUrlController,
              suffix: Container(
                color: Theme.of(context).colorScheme.onPrimary,
                child: IconButton(
                  onPressed: () {
                    cubit.showYoutubeVideoBottomSheet(context);
                  },
                  icon: const Icon(FlutterRemix.arrow_right_line, size: 18),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
