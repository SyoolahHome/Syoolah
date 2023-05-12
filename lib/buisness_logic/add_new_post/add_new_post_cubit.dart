import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/feed_category.dart';
import '../../model/post_asset_section_item.dart';
import '../../presentation/new_post/widgets/image.dart';
import '../../presentation/new_post/widgets/youtube.dart';

part 'add_new_post_state.dart';

class AddNewPostCubit extends Cubit<AddNewPostState> {
  TextEditingController? textController;

  TextEditingController? youtubeUrlController;

  List<FeedCategory> categories;

  List<PostAssetSectionItem> get postAssetsSectionsWidgets => [
        PostAssetSectionItem(
          widget: PostImage(),
          icon: FlutterRemix.account_box_fill,
          onPressed: () {
            addImage();
          },
        ),
        PostAssetSectionItem(
          onPressed: () {},
          icon: FlutterRemix.youtube_line,
          widget: PostYoutube(),
        ),
      ];

  AddNewPostCubit({
    required this.categories,
  }) : super(AddNewPostInitial(categories: categories)) {
    textController = TextEditingController();
    youtubeUrlController = TextEditingController();
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
      emit(state.copyWith(success: "postCreatedSuccessfully".tr()));
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));
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
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(
        state.copyWith(
          error: null,
          success: null,
          isLoading: false,
          pickedImages: state.pickedImages,
          currentPostAssetsSectionIndex: state.currentPostAssetsSectionIndex,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    textController?.dispose();
    youtubeUrlController?.dispose();

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

  void onYoutubeUrlChanged(String value) {
    emit(state.copyWith(youtubeUrl: value));
  }

  void showWidgetAt(int index) {
    emit(state.copyWith(currentPostAssetsSectionIndex: index));
  }

  void showYoutubeVideoBottomSheet(BuildContext context) {
    final text = youtubeUrlController?.text;
    if (text == null || text.isEmpty) {
      return;
    }

    try {
      final isValidUrl = Uri.parse(text).isAbsolute;

      if (isValidUrl) {
        onYoutubeUrlChanged(text);
        BottomSheetService.showYoututbeVideoBottomSheet(
          context,
          url: text,
          onAccept: onAcceptYoutubeVideo,
        );
      }
    } catch (e) {
      emit(state.copyWith(error: "invalidUrl".tr()));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  void onAcceptYoutubeVideo() {
    emit(state.copyWith(acceptedYoutubeUrl: state.youtubeUrl));
  }
}
