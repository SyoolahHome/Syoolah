import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

part 'comment_state.dart';

/// {@template comment_cubit}
/// A responsible cubit for managing the state of a comment widget.
/// {@endtemplate}
class CommentWidgetCubit extends Cubit<CommentState> {
  /// A Caching system for the user metadata, so we don't have to fetch it every time.
  static final _cache = <String, UserMetaData>{};

  /// The event of the comment.
  final NostrEvent commentEvent;

  /// TODO: move the stream to be set from the outside.
  StreamSubscription? commentEventOwnerMetadataSub;

  /// {@macro comment_cubit}
  CommentWidgetCubit({
    required this.commentEvent,
  }) : super(CommentInitial()) {
    if (_cache.containsKey(commentEvent.pubkey)) {
      emit(state.copyWith(commentOwnerMetadata: _cache[commentEvent.pubkey]));
    } else {
      _init();
    }
  }

  @override
  Future<void> close() {
    commentEventOwnerMetadataSub?.cancel();

    return super.close();
  }

  void _init() {
    commentEventOwnerMetadataSub = NostrService.instance.subs
        .userMetaData(userPubKey: commentEvent.pubkey)
        .stream
        .listen((event) {
      final decoded = jsonDecode(event.content) as Map<String, dynamic>;
      final metadata = UserMetaData.fromJson(
        jsonData: decoded,
        sourceNostrEvent: event,
      );

      emit(state.copyWith(
        commentOwnerMetadata: metadata,
      ));

      _cache[commentEvent.pubkey] = metadata;
    });
  }

  Future<void> showCommentOptions(BuildContext context) {
    final commentOwnerMetadata = state.commentOwnerMetadata;

    return BottomSheetService.showCommentOptions(
      context,
      options: <BottomSheetOption>[
        BottomSheetOption(
          title: "copyCommentText".tr(),
          icon: FlutterRemix.file_copy_fill,
          onPressed: () {
            AppUtils.instance.copy(commentEvent.content);
          },
        ),
        BottomSheetOption(
          title: "copyCommentEventId".tr(),
          icon: FlutterRemix.file_copy_fill,
          onPressed: () {
            AppUtils.instance.copy(commentEvent.id);
          },
        ),
      ],
    );
  }
}
