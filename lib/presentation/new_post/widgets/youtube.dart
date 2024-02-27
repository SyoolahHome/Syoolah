import 'package:ditto/buisness_logic/add_new_post/add_new_post_cubit.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../constants/abstractions/abstractions.dart';

class PostYoutube extends NewPostAssetWidget {
  const PostYoutube({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddNewPostCubit>();

    return MarginedBody(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("youtubeVideo".tr()),
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

              if (acceptedYoutubeUrl != null && acceptedYoutubeUrl.isNotEmpty) {
                return ListTile(
                  onTap: () {
                    cubit.showYoutubeVideoBottomSheet(context);
                  },
                  title: Text('selectedYoutube'.tr()),
                  subtitle: Text(
                    acceptedYoutubeUrl,
                  ),
                  trailing: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        YoutubePlayer.getThumbnail(
                          videoId:
                              YoutubePlayer.convertUrlToId(acceptedYoutubeUrl)!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
              return CustomTextField(
                bgColor: Theme.of(context).colorScheme.onPrimary,
                hint: "youtubeUrlHint".tr(),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                controller: cubit.youtubeUrlController,
                suffix: Padding(
                  padding: EdgeInsets.only(
                    right: MarginedBody.defaultMargin.right,
                  ),
                  child: AlIttihadButton(
                    isSmall: true,
                    onTap: () {
                      cubit.showYoutubeVideoBottomSheet(context);
                    },
                    text: "validate".tr(),
                    icon: FlutterRemix.check_line,
                    iconSize: 19,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
