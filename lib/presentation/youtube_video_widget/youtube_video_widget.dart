import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../buisness_logic/cubit/youtube_video_widget_cubit.dart';
import '../general/widget/bottom_sheet_title_with_button.dart';

class YoutubeVideoWidget extends StatelessWidget {
  const YoutubeVideoWidget({
    super.key,
    required this.url,
    required this.onAccept,
  });
  final VoidCallback onAccept;
  final String url;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<YoutubeVideoWidgetCubit>(
      create: (context) => YoutubeVideoWidgetCubit(url),
      child: Builder(
        builder: (context) {
          final cubit = context.read<YoutubeVideoWidgetCubit>();

          return MarginedBody(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20.0),
                  BottomSheetTitleWithIconButton(
                    title: 'youtubeVideo'.tr(),
                  ),
                  SizedBox(height: 20.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: YoutubePlayer(
                      controller: cubit.controller!,
                      aspectRatio: 16 / 9,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MunawarahButton(
                      onTap: () {
                        onAccept();
                        Navigator.of(context).pop();
                      },
                      isSmall: true,
                      isOnlyBorder: true,
                      icon: FlutterRemix.checkbox_circle_fill,
                      iconSize: 17.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
