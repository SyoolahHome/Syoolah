// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final List<NostrEvent> currentUserPosts;
  final NostrEvent? currentUserMetadata;
  const ProfileState({
    this.currentUserPosts = const [],
    this.currentUserMetadata,
  });

  @override
  List<Object?> get props => [currentUserPosts, currentUserMetadata];

  ProfileState copyWith({
    List<NostrEvent>? currentUserPosts,
    NostrEvent? currentUserMetadata,
  }) {
    return ProfileState(
      currentUserMetadata: currentUserMetadata ?? this.currentUserMetadata,
      currentUserPosts: currentUserPosts ?? this.currentUserPosts,
    );
  }
}

class ProfileInitial extends ProfileState {}
