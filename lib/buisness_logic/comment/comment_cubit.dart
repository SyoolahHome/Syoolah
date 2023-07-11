import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';

part 'comment_state.dart';

class CommentWidgetCubit extends Cubit<CommentState> {
  final NostrEvent commentEvent;
  StreamSubscription? commentEventOwnerMetadataSub;

  CommentWidgetCubit({
    required this.commentEvent,
  }) : super(CommentInitial()) {
    _init();
  }

  @override
  Future<void> close() {
    commentEventOwnerMetadataSub?.cancel();

    return super.close();
  }

  void _init() {
    commentEventOwnerMetadataSub = NostrService.instance.subs
        .userMetaDataStream(commentEvent.pubkey)
        .stream
        .listen((event) {
      final decoded = jsonDecode(event.content) as Map<String, dynamic>;
      final metadata = UserMetaData.fromJson(decoded);

      emit(state.copyWith(
        commentOwnerMetadata: metadata,
      ));
    });
  }
}
