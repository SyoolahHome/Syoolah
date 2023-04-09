import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

import '../../services/nostr/nostr.dart';

part 'note_comments_state.dart';

class NoteCommentsCubit extends Cubit<NoteCommentsState> {
  Stream<NostrEvent> noteCommentsStream;

  NoteCommentsCubit({
    required this.noteCommentsStream,
  }) : super(NoteCommentsInitial()) {
    _handleStreams();
  }

  void _handleStreams() {
    noteCommentsStream.listen((event) {
      emit(state.copyWith(noteComments: [...state.noteComments, event]));
    });
  }

  void noteComment({
    required String postEventId,
    required String text,
  }) {
    NostrService.instance.addCommentToPost(
      postEventId: postEventId,
      text: text,
    );
  }
}
