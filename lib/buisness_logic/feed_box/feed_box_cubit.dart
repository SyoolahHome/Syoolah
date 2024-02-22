import 'dart:ffi';

import 'package:dart_nostr/nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../services/tts/tts.dart';
import '../translation/translation_cubit.dart';

part 'feed_box_state.dart';

/// {@template feed_box_cubit}
/// The responsible cubit about the feed box that is shown at the home page.
/// {@endtemplate}
class FeedBoxCubit extends Cubit<FeedBoxState> {
  FeedBoxCubit() : super(FeedBoxState.initial());

  /// highlights a feed box when it is pressed by a user
  void highlightBox() {
    emit(const FeedBoxState(isHighlighted: true));
  }

  /// unhighlight a feed box when it is not pressed by a user.
  void unHighlightBox() {
    emit(const FeedBoxState());
  }

  /// Triggers tha bottom sheet that contains options related to feed box.
  void showOptions(
    BuildContext context, {
    required Note note,
    required VoidCallback onCommentsSectionTapped,
  }) {
    final cubit = context.read<GlobalCubit>();
    final userPrivateKey = LocalDatabase.instance.getPrivateKey();

    if (userPrivateKey == null) {
      return;
    }

    final publicKey = Nostr.instance.keysService.derivePublicKey(
      privateKey: userPrivateKey,
    );

    final isFollowed = cubit.isNoteOwnerFollowed(note.event.pubkey);

    BottomSheetService.showNoteCardSheet(
      context,
      // TODO: move those options toa separated class, file.
      options: <BottomSheetOption>[
        if (note.event.pubkey != publicKey)
          BottomSheetOption(
            title: isFollowed ? "unfollow".tr() : "follow".tr(),
            icon: isFollowed
                ? FlutterRemix.user_unfollow_line
                : FlutterRemix.user_follow_line,
            onPressed: () {
              cubit.handleFollowButtonTap(note.event.pubkey);
            },
          ),
        BottomSheetOption(
          title: "openComments".tr(),
          icon: FlutterRemix.chat_1_line,
          onPressed: onCommentsSectionTapped,
        ),
        if (note.imageLinks.isNotEmpty)
          BottomSheetOption(
            title: "copyImagesLinks".tr(),
            icon: FlutterRemix.file_copy_line,
            onPressed: () {
              AppUtils.instance.copy(
                note.imageLinks.join("\n"),
                onSuccess: () {
                  final shownSnackbarController =
                      SnackBars.text(context, "copySuccess".tr());
                },
                onError: () {
                  final shownSnackbarController =
                      SnackBars.text(context, "copyError".tr());
                },
              );
            },
          ),
        if (note.youtubeVideoLinks.isNotEmpty)
          BottomSheetOption(
            title: "copyYoutubeUrl".tr(),
            icon: FlutterRemix.file_copy_line,
            onPressed: () {
              AppUtils.instance.copy(
                note.youtubeVideoLinks.first,
                onSuccess: () {
                  final shownSnackbarController =
                      SnackBars.text(context, "copySuccess".tr());
                },
                onError: () {
                  final shownSnackbarController =
                      SnackBars.text(context, "copyError".tr());
                },
              );
            },
          ),
        BottomSheetOption(
          title: "copyEventId".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.instance.copy(
              note.event.id,
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copySuccess".tr());
              },
              onError: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copyError".tr());
              },
            );
          },
        ),
        BottomSheetOption(
          title: "copyEvent".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.instance.copy(
              note.event.serialized(),
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copySuccess".tr());
              },
              onError: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copyError".tr());
              },
            );
          },
        ),
        BottomSheetOption(
          title: "copyContent".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.instance.copy(
              note.noteOnly,
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copySuccess".tr());
              },
              onError: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copyError".tr());
              },
            );
          },
        ),
        BottomSheetOption(
          title: "report".tr(),
          icon: FlutterRemix.alarm_warning_line,
          onPressed: () {
            BottomSheetService.showReportSheet(context, note);
          },
        ),
        // BottomSheetOption(
        //   title: "resendToRelays".tr(),
        //   icon: FlutterRemix.send_plane_2_line,
        //   onPressed: () {
        //     NostrService.instance.reSendNote(note.event);
        //   },
        // ),
      ],
    );
  }
}
