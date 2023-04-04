import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  Stream<NostrEvent> currentUserPostsStream;
  Stream<NostrEvent> currentUserMetadataStream;

  ProfileCubit(
    this.currentUserPostsStream,
    this.currentUserMetadataStream,
  ) : super(ProfileInitial()) {
    handleStreams();
  }

  void handleStreams() {
    _handleCurrentUserPosts();
    _handleCurrentUserMetadata();
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
    currentUserMetadataStream.listen((event) {
      emit(
        state.copyWith(
          currentUserPosts: [...state.currentUserPosts, event],
        ),
      );
    });
  }
}
