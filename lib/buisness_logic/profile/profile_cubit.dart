import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/strings.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:ditto/services/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/profile_option.dart';
import '../../model/tab_item.dart';
import '../../presentation/general/profile_tabs.dart';
import '../../services/nostr/nostr.dart';
import '../../services/utils/alerts.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  Stream<NostrEvent> currentUserPostsStream;
  Stream<NostrEvent> currentUserMetadataStream;
  Stream<NostrEvent> currentUserLikedPosts;

  ProfileCubit({
    required this.currentUserPostsStream,
    required this.currentUserMetadataStream,
    required this.currentUserLikedPosts,
  }) : super(const ProfileInitial(
          profileTabsItems: GeneralProfileTabs.profileTabsItems,
        )) {
    handleStreams();
  }

  void handleStreams() {
    _handleCurrentUserPosts();
    _handleCurrentUserMetadata();
    _handleCurrentUserLikedPosts();
  }

  void _handleCurrentUserMetadata() {
    currentUserMetadataStream.listen((event) {
      emit(
        state.copyWith(
          currentUserMetadata: event,
        ),
      );
    });
  }

  void _handleCurrentUserPosts() {
    currentUserPostsStream.listen((event) {
      emit(
        state.copyWith(
          currentUserPosts: [...state.currentUserPosts, event],
        ),
      );
    });
  }

  void _handleCurrentUserLikedPosts() {
    currentUserLikedPosts.listen((event) {
      emit(
        state.copyWith(
          currentUserLikedPosts: [...state.currentUserLikedPosts, event],
        ),
      );
    });
  }

  Future<void> pickAvatarFromGallery() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      emit(
        state.copyWith(pickedAvatarImage: File(pickedImage!.path)),
      );
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  Future<void> pickAvatarFromCamera() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      emit(
        state.copyWith(pickedAvatarImage: File(pickedImage!.path)),
      );
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(
        error: null,
      ));
    }
  }

  Future<void> removeAvatar() async {
    emit(state.copyWith(pickedAvatarImage: null));
    try {
      final currentUsermetadata = UserMetaData.fromJson(
        jsonDecode(state.currentUserMetadata?.content ?? "{}")
            as Map<String, dynamic>,
      );

      NostrService.instance.setCurrentUserMetaData(
        metadata: currentUsermetadata.copyWith(
          picture: "",
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  Future<bool> uploadPictureAndSet() async {
    try {
      if (state.pickedAvatarImage == null) {
        return false;
      }
      emit(state.copyWith(isLoading: true));
      final uploadedAvatarUrl = await FileUpload()(state.pickedAvatarImage!);

      final currentUsermetadata = UserMetaData.fromJson(
        jsonDecode(state.currentUserMetadata?.content ?? "{}")
            as Map<String, dynamic>,
      );

      NostrService.instance.setCurrentUserMetaData(
          metadata: currentUsermetadata.copyWith(
        picture: uploadedAvatarUrl,
      ));

      return true;
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
      return false;
    } finally {
      emit(state.copyWith(
        error: null,
        isLoading: false,
      ));
    }
  }

  Future<void> pickBanner() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      emit(state.copyWith(pickedBannerImage: File(pickedImage!.path)));
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  void scaleAvatarDown() {
    emit(state.copyWith(profileAvatarScale: 0.95));
  }

  void scaleAvatarToNormal() {
    emit(state.copyWith(profileAvatarScale: 1.0));
  }

  void showAvatarMenu(
    BuildContext context, {
    required Future<void> Function() onEnd,
    required void Function() onFullView,
    required BlocBase cubit,
  }) {
    AlertsService.showAvatarMenu(
      context,
      onPickFromGallery: pickAvatarFromGallery,
      onTakePhoto: pickAvatarFromCamera,
      onAvatarPickedOrTaken: uploadPictureAndSet,
      onRemove: removeAvatar,
      onEnd: onEnd,
      cubit: cubit,
      onFullView: onFullView,
    );
  }

  void onMorePressed(
    BuildContext context, {
    required void Function() onEditProfile,
  }) {
    final metadata = UserMetaData.fromJson(jsonDecode(
      state.currentUserMetadata?.content ?? "{}",
    ) as Map<String, dynamic>);

    BottomSheetService.showProfileBottomSheet(
      context,
      options: [
        BottomSheetOption(
          title: AppStrings.editProfile,
          icon: FlutterRemix.pencil_line,
          onPressed: onEditProfile,
        ),
        BottomSheetOption(
          title: AppStrings.copyPubKey,
          icon: FlutterRemix.file_code_line,
          onPressed: () {
            AppUtils.copy(state.currentUserMetadata!.pubkey, onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyMetaDataEvent,
          icon: FlutterRemix.file_code_line,
          onPressed: () {
            AppUtils.copy(state.currentUserMetadata!.content, onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyProfileEvent,
          icon: FlutterRemix.file_code_line,
          onPressed: () {
            AppUtils.copy(state.currentUserMetadata!.serialized(),
                onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyImageUrl,
          icon: FlutterRemix.file_code_line,
          onPressed: () {
            AppUtils.copy(metadata.picture!, onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyUsername,
          icon: FlutterRemix.file_code_line,
          onPressed: () {
            AppUtils.copy(metadata.username, onSuccess: () {
              SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
      ],
    );
  }
}
