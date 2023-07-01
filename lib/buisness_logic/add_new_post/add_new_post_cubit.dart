import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ditto/model/feed_category.dart';
import 'package:ditto/model/post_asset_section_item.dart';
import 'package:ditto/presentation/new_post/widgets/image.dart';
import 'package:ditto/presentation/new_post/widgets/youtube.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';

part 'add_new_post_state.dart';

/// {@template add_new_post}
/// The cubit responsible on adding/sending new note/post from the current user
/// {@end_template}
class AddNewPostCubit extends Cubit<AddNewPostState> {
  /// Hsandles the note text controller
  TextEditingController? textController;

  /// Handles the youtube video URL text controller.
  TextEditingController? youtubeUrlController;

  /// A List of available categories to be selected from the user
  List<FeedCategory> categories;

  /// The options to select assets from in the note, such images, video urls..
  List<PostAssetSectionItem> get postAssetsSectionsWidgets => [
        PostAssetSectionItem(
          widget: const PostImage(),
          icon: FlutterRemix.image_add_line,
          onPressed: addImage,
        ),
        PostAssetSectionItem.withoutTapHandler(
          widget: const PostYoutube(),
          icon: FlutterRemix.youtube_line,
        ),
      ];

  /// {@macro add_new_post}
  AddNewPostCubit({
    required this.categories,
    String? initialNoteContent,
  }) : super(AddNewPostInitial(categories: categories)) {
    _init(initialNoteContent);
  }

  @override
  Future<void> close() {
    textController?.dispose();
    youtubeUrlController?.dispose();

    return super.close();
  }

  /// Creates a new note with the available/selected resources.
  /// if the [controller] is [null], nothing will happen.
  /// if a youtube video is set, it will be added to the note.
  /// if any assets are selected, they will be added as well
  /// if any assets are selected, they need to be uploaded in order to get URLs first, then use it.
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

      if (_noteYoutubeVideExists()) {
        resultNote += state.acceptedYoutubeUrl!;
      }

      NostrService.instance.send.sendTextNoteFromCurrentUser(
        text: resultNote,
        tags: state.categories.whereSelected.toNostrTagsList(),
      );

      emit(state.copyWith(success: "yourNoteWasSent".tr()));
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  /// Opens the native image picker from the device to be selected, then represent them in the UI.
  /// if something gets wrong during this operation, it will be handled
  Future<void> addImage() async {
    try {
      final imagePicker = ImagePicker();
      final images = await imagePicker.pickMultiImage();
      emit(state.copyWith(pickedImages: images.toListOfFiles()));
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(
        state.copyWith(
          isLoading: false,
          pickedImages: state.pickedImages,
          currentPostAssetsSectionIndex: state.currentPostAssetsSectionIndex,
        ),
      );
    }
  }

  /// Selects the target [FeedCategory] at the [selectedIndex], then toggles its [FeedCategory.isSelected] to the given [value]
  void onSelected(int selectedIndex, bool value) {
    final newList = <FeedCategory>[];

    for (int index = 0; index < state.categories.length; index++) {
      final isTheTargetItem = selectedIndex == index;
      final currentItem = state.categories[index];

      if (isTheTargetItem) {
        newList.add(currentItem.toggleSelected(value));
      } else {
        newList.add(currentItem);
      }
    }

    final pickedImages = state.pickedImages;
    emit(state.copyWith(categories: newList, pickedImages: pickedImages));
  }

  /// Removes the selected image (from the current state) at the given [imageIndex] by the [addImage] method, and reflects changes in the UI.

  void removePickedImage(int imageIndex) {
    final pickedImages = state.pickedImages;
    if (pickedImages == null) {
      return;
    }

    final newList = <File>[];
    for (int index = 0; index < pickedImages.length; index++) {
      final isTargetItem = imageIndex == index;
      final current = pickedImages[index];

      if (!isTargetItem) {
        newList.add(current);
      }
    }

    emit(state.copyWith(pickedImages: newList));
  }

  /// Weither some images are picked from the user.
  bool _noteImagesExists() {
    return state.pickedImages?.isNotEmpty ?? false;
  }

  /// Weither a selected youtube video is valid & accepted.
  bool _noteYoutubeVideExists() {
    return state.acceptedYoutubeUrl != null;
  }

  /// Uploads the picked images from the user using the [FileUpload] service, combining each one's url to one string that is returned.
  /// if no images are selected, an empty string is returned.
  ///
  Future<String> _uploadImagesAndGetNewNoteResult() async {
    final fileUploadService = FileUpload();
    String result = "";

    final pickedImages = state.pickedImages;
    if (pickedImages == null) {
      assert(result.isEmpty);
      return result;
    }

    for (int index = 0; index < pickedImages.length; index++) {
      final current = pickedImages[index];
      final currentUploadedImageLink = await fileUploadService(current);
      result += "\n";
      result += "$currentUploadedImageLink";
    }

    return result;
  }

  /// Sets the given [youtubeUrl] to the current state.
  void onYoutubeUrlChanged(String youtubeUrl) {
    emit(state.copyWith(youtubeUrl: youtubeUrl));
  }

  /// Shows the widget of the [PostAssetSectionItem] as the selected one.
  void showWidgetAt(int index) {
    emit(state.copyWith(currentPostAssetsSectionIndex: index));
  }

  /// A wrapper to show the bottom sheet of validating the accepted youtube video
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
          onRemove: onRemoveYoutubeVideo,
        );
      }
    } catch (e) {
      emit(state.copyWith(error: "invalidUrl".tr()));
    } finally {
      emit(state.copyWith());
    }
  }

  /// Accepts & validate the selected youtube video
  void onAcceptYoutubeVideo() {
    emit(state.copyWith(acceptedYoutubeUrl: state.youtubeUrl));
  }

  /// Removes the selected youtube video
  void onRemoveYoutubeVideo() {
    emit(state.copyWith(acceptedYoutubeUrl: ""));
  }

  void _init(String? initialNoteContent) {
    textController = TextEditingController()..text = initialNoteContent ?? "";
    youtubeUrlController = TextEditingController();
  }
}
