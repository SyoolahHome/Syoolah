import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'add_new_post_state.dart';

class AddNewPostCubit extends Cubit<AddNewPostState> {
  TextEditingController? textController;

  AddNewPostCubit() : super(AddNewPostInitial()) {
    textController = TextEditingController();
  }

  void createNote() async {
    try {
      String uploadedImageUrl = "";
      if (state.pickedImage != null) {
        uploadedImageUrl = await FileUpload()(state.pickedImage!);
      }
      String text = "${textController!.text}\n$uploadedImageUrl";

      NostrService.instance.sendTextNoteFromCurrentUser(
        text: text,
        tags: [
          ["t", "anas"],
          ["t", "gwhyyy"],
        ],
      );
    } catch (e) {
      print(e);
    }
  }

  void addImage() async {
    try {
      final imagePicker = ImagePicker();
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      emit(state.copyWith(pickedImage: File(image!.path)));
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> close() {
    textController!.dispose();
    return super.close();
  }
}
