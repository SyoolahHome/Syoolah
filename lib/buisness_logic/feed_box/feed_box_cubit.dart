import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:ditto/services/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/strings.dart';
import '../../model/bottom_sheet_option.dart';

part 'feed_box_state.dart';

class FeedBoxCubit extends Cubit<FeedBoxState> {
  FeedBoxCubit() : super(FeedBoxInitial());

  void highlightBox() {
    emit(const FeedBoxState(isHighlighted: true));
  }

  void unHighlightBox() {
    emit(const FeedBoxState(isHighlighted: false));
  }

  void showOptions(
    BuildContext context, {
    required Note note,
    required VoidCallback onCommentsSectionTapped,
  }) {
    final cubit = context.read<GlobalCubit>();

    final isFollowed = cubit.isNoteOwnerFollowed(note.event.pubkey);
    BottomSheetService.showNoteCardSheet(context, options: [
      BottomSheetOption(
        title: isFollowed ? AppStrings.unfollow : AppStrings.follow,
        icon: isFollowed
            ? FlutterRemix.user_unfollow_line
            : FlutterRemix.user_follow_line,
        onPressed: () {
          cubit.handleFollowButtonTap(note.event.pubkey);
        },
      ),
      BottomSheetOption(
        title: AppStrings.openCommentsSections,
        icon: FlutterRemix.chat_1_line,
        onPressed: onCommentsSectionTapped,
      ),
      BottomSheetOption(
        title: AppStrings.copyNoteEventId,
        icon: FlutterRemix.file_copy_line,
        onPressed: () {
          AppUtils.copy(
            note.event.id,
            onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            },
            onError: () {
              SnackBars.text(context, AppStrings.copyError);
            },
          );
        },
      ),
      BottomSheetOption(
        title: AppStrings.copyNoteEvent,
        icon: FlutterRemix.file_copy_line,
        onPressed: () {
          AppUtils.copy(
            note.event.serialized(),
            onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            },
            onError: () {
              SnackBars.text(context, AppStrings.copyError);
            },
          );
        },
      ),
      BottomSheetOption(
        title: AppStrings.copyNoteContent,
        icon: FlutterRemix.file_copy_line,
        onPressed: () {
          AppUtils.copy(
            note.noteOnly,
            onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            },
            onError: () {
              SnackBars.text(context, AppStrings.copyError);
            },
          );
        },
      ),
      BottomSheetOption(
        title: AppStrings.resendToRelays,
        icon: FlutterRemix.send_plane_2_line,
        onPressed: () {
          NostrService.instance.reSendNote(note.event);
        },
      ),
    ]);
  }
}
