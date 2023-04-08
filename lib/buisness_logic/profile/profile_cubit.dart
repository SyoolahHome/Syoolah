import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

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
}
