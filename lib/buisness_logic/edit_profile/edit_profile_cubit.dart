import 'package:bloc/bloc.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part "./edit_profile_state.dart";

/// {@template edit_profile_cubit}
/// The responsible cubit for editing the user's profile
/// {@endtemplate}
class EditProfileCubit extends Cubit<EditProfileState> {
  /// The name new name controller.
  TextEditingController? nameController;

  /// The name new username controller.
  TextEditingController? usernameController;

  /// The name new picture controller.
  TextEditingController? pictureController;

  /// The name new banner controller.
  TextEditingController? bannerController;

  /// The name new bio controller.
  TextEditingController? bioController;

  /// The metadata if the existent user, this will be used to get the user's profile info in order to initialize it in the text field via the controllers.
  UserMetaData metaData;

  /// {@template edit_profile_cubit}
  EditProfileCubit(this.metaData) : super(EditProfileState.initial()) {
    _init();
  }

  @override
  Future<void> close() {
    nameController?.dispose();
    usernameController?.dispose();
    pictureController?.dispose();
    bannerController?.dispose();
    bioController?.dispose();

    return super.close();
  }

  /// Saves the changes of the profile which the user did.
  /// if any of the controllers is not initialized, it will throw an error.
  /// if the name or username is empty, it will ignore.
  void saveEdits() {
    _checkControllersInitailized();

    try {
      if (nameController?.text.trim() == "") {
        emit(state.copyWith(error: "nameError".tr()));
      } else if (usernameController?.text == null ||
          usernameController?.text.trim() == "") {
        emit(state.copyWith(error: "usernameError".tr()));
      } else {
        NostrService.instance.send.setCurrentUserMetaData(
          metadata: UserMetaData(
            name: nameController?.text ?? metaData.name,
            picture: pictureController?.text ?? metaData.picture,
            banner: bannerController?.text ?? metaData.banner,
            username: usernameController?.text ?? metaData.username,
            about: bioController?.text ?? metaData.about,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(error: "error".tr()));
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  /// Asserts that all controller are initialized.
  void _checkControllersInitailized() {
    assert(
      nameController != null &&
          usernameController != null &&
          pictureController != null &&
          bannerController != null &&
          bioController != null,
    );
  }

  void _init() {
    nameController = TextEditingController(text: metaData.name);
    usernameController = TextEditingController(text: metaData.username);
    pictureController = TextEditingController(text: metaData.picture);
    bannerController = TextEditingController(text: metaData.banner);
    bioController = TextEditingController(text: metaData.about);
  }
}
