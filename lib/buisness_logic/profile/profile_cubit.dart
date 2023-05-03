import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/bottom_sheet_option.dart';
import '../../model/tab_item.dart';
import '../../presentation/general/profile_tabs.dart';
import '../../services/nostr/nostr_service.dart';
import '../../services/utils/alerts_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  Stream<NostrEvent> currentUserPostsStream;
  Stream<NostrEvent> currentUserMetadataStream;
  Stream<NostrEvent> currentUserLikedPosts;

  StreamSubscription<NostrEvent>? _currentUserPostsSubscription;
  StreamSubscription<NostrEvent>? _currentUserMetadataSubscription;
  StreamSubscription<NostrEvent>? _currentUserLikedPostsSubscription;

  ProfileCubit({
    required this.currentUserPostsStream,
    required this.currentUserMetadataStream,
    required this.currentUserLikedPosts,
  }) : super(const ProfileInitial(
          profileTabsItems: GeneralProfileTabs.profileTabsItems,
        )) {
    _handleStreams();
  }

  Future<void> pickAvatarFromGallery() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        emit(state.copyWith(pickedAvatarImage: File(pickedImage.path)));
      }
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
      if (pickedImage != null) {
        emit(state.copyWith(pickedAvatarImage: File(pickedImage.path)));
      }
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(
        error: null,
      ));
    }
  }

  void removeAvatar() {
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
    final pickedAvatarImage = state.pickedAvatarImage;
    if (pickedAvatarImage == null) {
      return false;
    }
    try {
      emit(state.copyWith(isLoading: true));
      final uploadedAvatarUrl = await FileUpload()(pickedAvatarImage);

      final currentUsermetadata = UserMetaData.fromJson(
        jsonDecode(state.currentUserMetadata?.content ?? "{}")
            as Map<String, dynamic>,
      );

      NostrService.instance.setCurrentUserMetaData(
        metadata: currentUsermetadata.copyWith(
          picture: uploadedAvatarUrl,
        ),
      );

      return true;
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));

      return false;
    } finally {
      emit(state.copyWith(error: null, isLoading: false));
    }
  }

  Future<void> pickBanner() async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        emit(state.copyWith(pickedBannerImage: File(pickedImage.path)));
      }
    } catch (e) {
      emit(state.copyWith(error: AppStrings.error));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  void scaleAvatarDown() {
    final scaleDownVal = state.profileAvatarScale - 0.05;
    emit(state.copyWith(profileAvatarScale: scaleDownVal));
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
      onRemove: () async => removeAvatar,
      onEnd: onEnd,
      cubit: cubit,
      onFullView: onFullView,
    );
  }

  Future<void> logout({
    required VoidCallback onSuccess,
  }) async {
    return LocalDatabase.instance.logoutUser(onSuccess: onSuccess);
  }

  void onMorePressed(
    BuildContext context, {
    required void Function() onEditProfile,
    required void Function() onLogout,
  }) {
    final metadata = UserMetaData.fromJson(jsonDecode(
      state.currentUserMetadata?.content ?? "{}",
    ) as Map<String, dynamic>);

    final currentUserMetadata = state.currentUserMetadata;

    final currentUserMetadataPubkey = currentUserMetadata?.pubkey;

    final currentUserMetadataContent = currentUserMetadata?.content;

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
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(
              currentUserMetadataPubkey ?? "",
              onSuccess: () {
                final shownSnackbarController = SnackBars.text(
                  context,
                  AppStrings.copySuccess,
                );
              },
            );
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyMetaDataEvent,
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(currentUserMetadataContent ?? "", onSuccess: () {
              final shownSnackbarController =
                  SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyProfileEvent,
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(
              currentUserMetadata?.serialized() ?? "",
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, AppStrings.copySuccess);
              },
            );
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyImageUrl,
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(metadata.picture ?? "", onSuccess: () {
              final shownSnackbarController =
                  SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
        BottomSheetOption(
          title: AppStrings.copyUsername,
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(metadata.username, onSuccess: () {
              final shownSnackbarController =
                  SnackBars.text(context, AppStrings.copySuccess);
            });
          },
        ),
        BottomSheetOption(
          title: AppStrings.logout,
          icon: FlutterRemix.logout_box_line,
          onPressed: onLogout,
        ),
      ],
    );
  }

  void _handleStreams() {
    _handleCurrentUserPosts();
    _handleCurrentUserMetadata();
    _handleCurrentUserLikedPosts();
  }

  void _handleCurrentUserMetadata() {
    _currentUserMetadataSubscription = currentUserMetadataStream.listen(
      (event) {
        emit(
          state.copyWith(
            currentUserMetadata: event,
          ),
        );
      },
    );
  }

  void _handleCurrentUserPosts() {
    _currentUserPostsSubscription = currentUserPostsStream.listen((event) {
      emit(
        state.copyWith(
          currentUserPosts: [...state.currentUserPosts, event],
        ),
      );
    });
  }

  void _handleCurrentUserLikedPosts() {
    _currentUserLikedPostsSubscription = currentUserLikedPosts.listen((event) {
      emit(
        state.copyWith(
          currentUserLikedPosts: [...state.currentUserLikedPosts, event],
        ),
      );
    });
  }

  Future<void> onFollowingsMorePressed(
    BuildContext context, {
    required List<String> followings,
    required VoidCallback onUnFollowAll,
  }) {
    return BottomSheetService.showProfileFollowings(
      context,
      options: <BottomSheetOption>[
        BottomSheetOption(
          icon: FlutterRemix.copyleft_line,
          title: AppStrings.copyFollowingsKeys,
          onPressed: () {
            AppUtils.copy(
              followings.join("\n"),
            );
          },
        ),
        BottomSheetOption(
          icon: FlutterRemix.copyleft_line,
          title: AppStrings.unFollowAll,
          onPressed: onUnFollowAll,
        ),
      ],
    );
  }

  Future<void> onFollowersMorePressed(
    BuildContext context, {
    required List<String> followings,
  }) {
    return BottomSheetService.showProfileFollowings(
      context,
      options: <BottomSheetOption>[
        BottomSheetOption(
          icon: FlutterRemix.copyleft_line,
          title: AppStrings.copyFollowingsKeys,
          onPressed: () {},
        ),
      ],
    );
  }
}
