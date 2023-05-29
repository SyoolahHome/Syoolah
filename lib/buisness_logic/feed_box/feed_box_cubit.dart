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

part 'feed_box_state.dart';

class FeedBoxCubit extends Cubit<FeedBoxState> {
  FeedBoxCubit() : super(FeedBoxInitial());

  void highlightBox() {
    emit(const FeedBoxState(isHighlighted: true));
  }

  void unHighlightBox() {
    emit(const FeedBoxState());
  }

  void showOptions(
    BuildContext context, {
    required Note note,
    required VoidCallback onCommentsSectionTapped,
  }) {
    final cubit = context.read<GlobalCubit>();
    final publicKey = Nostr.instance.keysService
        .derivePublicKey(privateKey: LocalDatabase.instance.getPrivateKey()!);

    final isFollowed = cubit.isNoteOwnerFollowed(note.event.pubkey);
    BottomSheetService.showNoteCardSheet(
      context,
      options: [
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
              AppUtils.copy(
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
              AppUtils.copy(
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
            AppUtils.copy(
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
            AppUtils.copy(
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
            AppUtils.copy(
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
