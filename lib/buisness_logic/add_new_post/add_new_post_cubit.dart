import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ditto/constants/app_strings.dart';
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

  Future<void> createNote() async {
    final controller = textController;
    if (controller == null) {
      return;
    }

    try {
      emit(state.copyWith(isLoading: true, pickedImages: state.pickedImages));
      String resultNote = controller.text;
      if (_noteImagesExists()) {
        resultNote += await _uploadImagesAndGetNewNoteResult();
      }

      NostrService.instance.sendTextNoteFromCurrentUser(
        text: resultNote,
        tags: state.categories
            .where((e) => e.isSelected)
            .map((e) => ["t", e.name])
            .toList(),
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

  Future<void> addImage() async {
    try {
      final imagePicker = ImagePicker();
      final images = await imagePicker.pickMultiImage();
      emit(
        state.copyWith(
          pickedImages: images.map((xf) => File(xf.path)).toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(
        error: null,
        success: null,
        isLoading: false,
        pickedImages: state.pickedImages,
      ));
    }
  }

  @override
  Future<void> close() {
    textController?.dispose();

    return super.close();
  }

  void onSelected(int selectedIndex, bool value) {
    final newList = <FeedCategory>[];

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
    final pickedImages = state.pickedImages;
    if (pickedImages == null) {
      return;
    }

    final newList = <File>[];
    assert(state.pickedImages != null);
    for (int index = 0; index < pickedImages.length; index++) {
      final current = pickedImages[index];
      if (imageIndex != index) {
        newList.add(current);
      }
    }

    emit(state.copyWith(pickedImages: newList));
  }

  bool _noteImagesExists() {
    return state.pickedImages?.isNotEmpty ?? false;
  }

  Future<String> _uploadImagesAndGetNewNoteResult() async {
    String result = "";
    final pickedImages = state.pickedImages;
    if (pickedImages == null) {
      return result;
    }

    for (int index = 0; index < pickedImages.length; index++) {
      final current = pickedImages[index];
      final currentUploadedImageLink = await FileUpload()(current);
      result += "\n$currentUploadedImageLink";
    }

    return result;
  }
}
