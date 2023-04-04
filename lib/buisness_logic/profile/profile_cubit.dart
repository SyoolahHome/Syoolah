import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  Stream<NostrEvent> currentUserPosts;
  ProfileCubit(
    this.currentUserPosts,
  ) : super(ProfileInitial()) {
    handleStreams();
  }

  void handleStreams() {
    currentUserPosts.listen((event) {
      emit(
        state.copyWith(
          currentUserPosts: [...state.currentUserPosts, event],
        ),
      );
    });
  }
}
