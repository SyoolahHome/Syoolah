// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final List<NostrEvent> currentUserPosts;
  const ProfileState({
    this.currentUserPosts = const [],
  });

  @override
  List<Object> get props => [
        currentUserPosts,
      ];

  ProfileState copyWith({
    List<NostrEvent>? currentUserPosts,
  }) {
    return ProfileState(
      currentUserPosts: currentUserPosts ?? this.currentUserPosts,
    );
  }
}

class ProfileInitial extends ProfileState {}
