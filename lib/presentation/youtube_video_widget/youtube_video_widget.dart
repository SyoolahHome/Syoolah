import 'package:ditto/buisness_logic/cubit/youtube_video_widget_cubit.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
                  const SizedBox(height: 20.0),
                  BottomSheetTitleWithIconButton(
                    title: 'youtubeVideo'.tr(),
                  ),
                  const SizedBox(height: 20.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: YoutubePlayer(
                      controller: cubit.controller!,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: MunawarahButton(
                      onTap: () {
                        onAccept();
                        Navigator.of(context).pop();
                      },
                      isSmall: true,
                      text: 'accept'.tr(),
                      mainColor: Colors.green,
                      icon: FlutterRemix.check_line,
                      iconSize: 19.5,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
