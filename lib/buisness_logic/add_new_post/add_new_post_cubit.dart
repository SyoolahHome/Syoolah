import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/feed_category.dart';

part 'add_new_post_state.dart';

class AddNewPostCubit extends Cubit<AddNewPostState> {
  TextEditingController? textController;
  List<FeedCategory> categories;
  AddNewPostCubit({
    required this.categories,
  }) : super(AddNewPostInitial(categories: categories)) {
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

  void onSelected(int selectedIndex, bool value) {
    List<FeedCategory> newList = [];
    for (int index = 0; index < state.categories.length; index++) {
      if (selectedIndex != index) {
        newList.add(state.categories[index]);
      } else {
        final selectedItem = state.categories[index];
        newList.add(selectedItem.copyWith(isSelected: value));
      }
    }
    emit(state.copyWith(categories: newList));
  }
}
