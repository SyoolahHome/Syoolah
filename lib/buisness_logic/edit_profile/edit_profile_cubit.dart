import 'package:bloc/bloc.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part "./edit_profile_state.dart";

class EditProfileCubit extends Cubit<EditProfileState> {
  TextEditingController? nameController;
  TextEditingController? usernameController;
  TextEditingController? pictureController;
  TextEditingController? bannerController;
  TextEditingController? bioController;

  UserMetaData metaData;
  EditProfileCubit(this.metaData) : super(const EditProfileState()) {
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

  void saveEdits() {
    try {
      if (nameController?.text == null || nameController?.text.trim() == "") {
        emit(state.copyWith(error: "nameError".tr()));
      } else if (usernameController?.text == null ||
          usernameController?.text.trim() == "") {
        emit(state.copyWith(error: "usernameError".tr()));
      } else {
        NostrService.instance.setCurrentUserMetaData(
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
      print(e);
    } finally {
      emit(state.copyWith());
    }
  }

  void _init() {
    nameController = TextEditingController(text: metaData.name);
    usernameController = TextEditingController(text: metaData.username);
    pictureController = TextEditingController(text: metaData.picture);
    bannerController = TextEditingController(text: metaData.banner);
    bioController = TextEditingController(text: metaData.about);
  }
}
