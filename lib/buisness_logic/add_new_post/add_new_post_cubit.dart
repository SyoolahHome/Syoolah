import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ditto/constants/strings.dart';
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
    // 
  }

  void createNote() async {
    try {
      emit(state.copyWith(
        isLoading: true,
        pickedImages: state.pickedImages,
      ));
      String resultNote = textController!.text;

      if (state.pickedImages != null && state.pickedImages!.isNotEmpty) {
        for (int index = 0; index < state.pickedImages!.length; index++) {
          final currentUploadedImageLink = await FileUpload()(
            state.pickedImages![index],
          );
          resultNote += "\n$currentUploadedImageLink";
        }
      }
      NostrService.instance.sendTextNoteFromCurrentUser(
        text: resultNote,
        tags: [
          ["t", "anas"],
          ["t", "gwhyyy"],
        ],
      );
      emit(state.copyWith(success: AppStrings.postCreatedSuccessfully));
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(
        error: null,
        success: null,
        isLoading: false,
      ));
    }
  }

  void addImage() async {
    try {
      final imagePicker = ImagePicker();
      final images = await imagePicker.pickMultiImage(
          // source: ImageSource.gallery
          );
      emit(
        state.copyWith(
          pickedImages: images.map((xf) => File(xf.path)).toList(),
        ),
      );
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
    emit(state.copyWith(
      categories: newList,
      pickedImages: state.pickedImages,
    ));
  }

  void removePickedImage(int imageIndex) {
    final newList = <File>[];
    assert(state.pickedImages != null);
    for (int index = 0; index < state.pickedImages!.length; index++) {
      final current = state.pickedImages![index];
      if (imageIndex != index) {
        newList.add(current);
      }
    }

    emit(state.copyWith(pickedImages: newList));
  }
}
