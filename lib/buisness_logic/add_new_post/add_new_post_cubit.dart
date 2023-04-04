import 'package:bloc/bloc.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'add_new_post_state.dart';

class AddNewPostCubit extends Cubit<AddNewPostState> {
  TextEditingController? textController;

  AddNewPostCubit() : super(AddNewPostInitial()) {
    textController = TextEditingController();
  }

  void createNote() {
    NostrService.instance.sendTextNoteFromCurrentUser(
      text: textController!.text,
      tags: [
        ["t", "anas"],
        ["t", "gwhyyy"],
      ],
    );
  }

  @override
  Future<void> close() {
    textController!.dispose();
    return super.close();
  }
}
