import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
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
  NostrEventsStream currentUserMetadataStream;

  StreamSubscription<NostrEvent>? _currentUserMetadataSubscription;

  ProfileCubit({
    required this.currentUserMetadataStream,
  }) : super(ProfileInitial(
          profileTabsItems: GeneralProfileTabs.profileTabsItems,
        )) {
    _handleStreams();
  }

  @override
  Future<void> close() {
    currentUserMetadataStream.close();

    _currentUserMetadataSubscription?.cancel();

    return super.close();
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
      emit(state.copyWith(error: "error".tr()));
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
      emit(state.copyWith(error: "error".tr()));
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
      emit(state.copyWith(error: "error".tr()));
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
      emit(state.copyWith(error: "error".tr()));

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
      emit(state.copyWith(error: "error".tr()));
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
    required void Function() onMyKeysPressed,
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
          title: "editProfile".tr(),
          icon: FlutterRemix.pencil_line,
          onPressed: onEditProfile,
        ),
        BottomSheetOption(
          title: "myKeys".tr(),
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
            AppUtils.copy(currentUserMetadataContent ?? "", onSuccess: () {
              final shownSnackbarController =
                  SnackBars.text(context, "copySuccess".tr());
            });
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
            AppUtils.copy(metadata.picture ?? "", onSuccess: () {
              final shownSnackbarController =
                  SnackBars.text(context, "copySuccess".tr());
            });
          },
        ),
        BottomSheetOption(
          title: "copyUsername".tr(),
          icon: FlutterRemix.file_copy_line,
          onPressed: () {
            AppUtils.copy(metadata.username, onSuccess: () {
              final shownSnackbarController =
                  SnackBars.text(context, "copySuccess".tr());
            });
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
}
