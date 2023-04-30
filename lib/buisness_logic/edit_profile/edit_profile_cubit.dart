import 'package:bloc/bloc.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  TextEditingController? nameController;
  TextEditingController? usernameController;
  TextEditingController? pictureController;
  TextEditingController? bannerController;
  TextEditingController? aboutController;

  UserMetaData metaData;
  EditProfileCubit(this.metaData) : super(EditProfileInitial()) {
    _init();
  }

  @override
  Future<void> close() {
    nameController?.dispose();
    usernameController?.dispose();
    pictureController?.dispose();
    bannerController?.dispose();
    aboutController?.dispose();

    return super.close();
  }

  void saveEdits() {
    NostrService.instance.setCurrentUserMetaData(
      metadata: UserMetaData(
        name: nameController?.text ?? metaData.name,
        picture: pictureController?.text ?? metaData.picture,
        banner: bannerController?.text ?? metaData.banner,
        username: usernameController?.text ?? metaData.username,
        about: aboutController?.text ?? metaData.about,
      ),
    );
  }

  void updateAvatar() {}
  void _init() {
    nameController = TextEditingController(text: metaData.name);
    usernameController = TextEditingController(text: metaData.username);
    pictureController = TextEditingController(text: metaData.picture);
    bannerController = TextEditingController(text: metaData.banner);
    aboutController = TextEditingController(text: metaData.about);
  }
}
