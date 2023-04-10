import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/strings.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  Stream<NostrEvent> currentUserPostsStream;
  Stream<NostrEvent> currentUserMetadataStream;
  Stream<NostrEvent> currentUserLikedPosts;

  ProfileCubit({
    required this.currentUserPostsStream,
    required this.currentUserMetadataStream,
    required this.currentUserLikedPosts,
  }) : super(ProfileInitial()) {
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

  Future<void> pickAvatar() async {
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
}
