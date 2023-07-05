import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/tab_item.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/profile_tabs.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/app_enums.dart';

part 'profile_state.dart';

/// {@template profile_cubit}
/// The responsible cubit for the user's profile.
/// {@endtemplate}
class ProfileCubit extends Cubit<ProfileState> {
  /// The Nostr stream for the current user meta data.
  NostrEventsStream currentUserMetadataStream;

  /// The stream subscription for [currentUserMetadataStream.stream].
  StreamSubscription<NostrEvent>? _currentUserMetadataSubscription;

  /// {@macro profile_cubit}
  ProfileCubit({
    required this.currentUserMetadataStream,
  }) : super(
          ProfileState.initial(
            profileTabsItems: GeneralProfileTabs.profileTabsItems,
          ),
        ) {
    _init();
  }

  @override
  Future<void> close() {
    currentUserMetadataStream.close();

    _currentUserMetadataSubscription?.cancel();

    return super.close();
  }

  /// {@macro pick_image}
  Future<void> pickImage(
    ImageSource source,
    ImagePickType imagePickType,
  ) async {
    try {
      final imagePicker = ImagePicker();
      final pickedImage = await imagePicker.pickImage(source: source);

      if (pickedImage != null) {
        switch (imagePickType) {
          case ImagePickType.avatar:
            emit(state.copyWith(pickedAvatarImage: File(pickedImage.path)));
            break;
          case ImagePickType.banner:
            emit(state.copyWith(pickedBannerImage: File(pickedImage.path)));
            break;

          default:
            throw Exception("[$imagePickType] not supported");
        }
      }
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(state.copyWith());
    }
  }

  /// {@macro pick_avatar_from_gallery}
  Future<void> pickAvatarFromGallery() {
    return pickImage(ImageSource.gallery, ImagePickType.avatar);
  }

  /// {@macro pick_avatar_from_camera}
  Future<void> pickAvatarFromCamera() {
    return pickImage(ImageSource.camera, ImagePickType.avatar);
  }

  Future<void> pickBannerFromGallery() {
    return pickImage(ImageSource.gallery, ImagePickType.banner);
  }

  Future<void> pickBannerFromCamera() {
    return pickImage(ImageSource.camera, ImagePickType.banner);
  }

  /// Removes the picked image ([state.pickedAvatarImage]).
  void removeAvatar() {
    emit(state.copyWith());
    try {
      final currentUsermetadata = UserMetaData.fromJson(
        jsonDecode(state.currentUserMetadata?.content ?? "{}")
            as Map<String, dynamic>,
      );

      NostrService.instance.send.setCurrentUserMetaData(
        metadata: currentUsermetadata.copyWith(
          picture: "",
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(state.copyWith());
    }
  }

  void removeBanner() {
    try {
      emit(state.copyWith());
      final currentUsermetadata = UserMetaData.fromJson(
        jsonDecode(state.currentUserMetadata?.content ?? "{}")
            as Map<String, dynamic>,
      );

      final newM = currentUsermetadata.copyWith(
        banner: "",
      );

      NostrService.instance.send.setCurrentUserMetaData(
        metadata: newM,
      );
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(state.copyWith());
    }
  }

  /// Uploads the picked image and apply it as well in the app UI.
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

      NostrService.instance.send.setCurrentUserMetaData(
        metadata: currentUsermetadata.copyWith(
          picture: uploadedAvatarUrl,
        ),
      );

      return true;
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));

      return false;
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<bool> uploadBannerAndSet() async {
    final pickedBannerImage = state.pickedBannerImage;

    if (pickedBannerImage == null) {
      return false;
    }
    try {
      emit(state.copyWith(isLoading: true));
      final uploadedBannerUrl = await FileUpload()(pickedBannerImage);

      final currentUsermetadata = UserMetaData.fromJson(
        jsonDecode(state.currentUserMetadata?.content ?? "{}")
            as Map<String, dynamic>,
      );

      NostrService.instance.send.setCurrentUserMetaData(
        metadata: currentUsermetadata.copyWith(
          banner: uploadedBannerUrl,
        ),
      );

      return true;
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));

      return false;
    } finally {
      emit(state.copyWith(isLoading: false));
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
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(state.copyWith());
    }
  }

  /// Scales down the avatar UI box.
  void scaleAvatarDown() {
    final scaleDownVal = state.profileAvatarScale - 0.05;
    emit(state.copyWith(profileAvatarScale: scaleDownVal));
  }

  /// Scales back to normal scale the avatar UI box.
  void scaleAvatarToNormal() {
    emit(state.copyWith(profileAvatarScale: 1.0));
  }

  /// Shows the avatar alert menu that contains the option for the current user.
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

  void showBannerMenu(
    BuildContext context, {
    required Future<void> Function() onEnd,
    required void Function() onFullView,
    required BlocBase cubit,
  }) {
    AlertsService.showBannerMenu(
      context,
      onPickFromGallery: pickBannerFromGallery,
      onTakePhoto: pickBannerFromCamera,
      onBannerPickedOrTaken: uploadBannerAndSet,
      onRemove: () async => removeBanner,
      onEnd: onEnd,
      onFullView: onFullView,
      cubit: cubit,
    );
  }

  /// Log outs the current user.
  Future<void> logout({
    required VoidCallback onSuccess,
  }) async {
    return LocalDatabase.instance.logoutUser(onSuccess: onSuccess);
  }

  /// Shows the bottom sheet that contains more options that relates to the current user and the profile.
  /// TODO: move these options to a separated class, file.
  void onMorePressed(
    BuildContext context, {
    required void Function() onEditProfile,
    required void Function() onLogout,
    required void Function() onMyKeysPressed,
  }) {
    final metadata = UserMetaData.fromJson(
      jsonDecode(
        state.currentUserMetadata?.content ?? "{}",
      ) as Map<String, dynamic>,
    );

    final currentUserMetadata = state.currentUserMetadata;

    final currentUserMetadataPubkey = currentUserMetadata?.pubkey;

    final currentUserMetadataContent = currentUserMetadata?.content;

    BottomSheetService.showProfileBottomSheet(
      context,
      options: [
        BottomSheetOption(
          title: "editProfile".tr(),
          icon: FlutterRemix.pencil_line,
          onPressed: onEditProfile,
        ),
        BottomSheetOption(
          title: "keys".tr(),
          icon: FlutterRemix.key_line,
          onPressed: onMyKeysPressed,
        ),
        BottomSheetOption(
          title: "copyPubKey".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(
              currentUserMetadataPubkey ?? "",
              onSuccess: () {
                final shownSnackbarController = SnackBars.text(
                  context,
                  "copySuccess".tr(),
                );
              },
            );
          },
        ),
        BottomSheetOption(
          title: "copyMetaDataEvent".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(
              currentUserMetadataContent ?? "",
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copySuccess".tr());
              },
            );
          },
        ),
        BottomSheetOption(
          title: "copyProfileEvent".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(
              currentUserMetadata?.serialized() ?? "",
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copySuccess".tr());
              },
            );
          },
        ),
        BottomSheetOption(
          title: "copyImageUrl".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(
              metadata.picture ?? "",
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copySuccess".tr());
              },
            );
          },
        ),
        BottomSheetOption(
          title: "copyUsername".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(
              metadata.username,
              onSuccess: () {
                final shownSnackbarController =
                    SnackBars.text(context, "copySuccess".tr());
              },
            );
          },
        ),
        BottomSheetOption(
          title: "logout".tr(),
          icon: FlutterRemix.logout_box_line,
          onPressed: onLogout,
        ),
      ],
    );
  }

  /// Shows more options in the followings section.
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
          title: "copyFollowingsKeys".tr(),
          onPressed: () {
            AppUtils.copy(
              followings.join("\n"),
            );
          },
        ),
        BottomSheetOption(
          icon: FlutterRemix.copyleft_line,
          title: "unFollowAll".tr(),
          onPressed: onUnFollowAll,
        ),
      ],
    );
  }

  /// Shows more options in the followers section.
  Future<void> onFollowersMorePressed(
    BuildContext context, {
    required List<String> followings,
  }) {
    return BottomSheetService.showProfileFollowings(
      context,
      options: <BottomSheetOption>[
        BottomSheetOption(
          icon: FlutterRemix.copyleft_line,
          title: "copyFollowingsKeys".tr(),
          onPressed: () {},
        ),
      ],
    );
  }

  void _handleStreams() {
    _handleCurrentUserMetadata();
  }

  void _handleCurrentUserMetadata() {
    _currentUserMetadataSubscription = currentUserMetadataStream.stream.listen(
      (event) {
        emit(
          state.copyWith(
            currentUserMetadata: event,
          ),
        );
      },
    );
  }

  void _init() {
    _handleStreams();
  }
}
