// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final List<NostrEvent> currentUserPosts;
  final List<NostrEvent> currentUserLikedPosts;
  final NostrEvent? currentUserMetadata;
  const ProfileState({
    this.currentUserPosts = const [],
    this.currentUserLikedPosts = const [],
    this.currentUserMetadata,
  });

  @override
  List<Object?> get props => [
        currentUserPosts,
        currentUserMetadata,
        currentUserLikedPosts,
      ];

  ProfileState copyWith({
    List<NostrEvent>? currentUserPosts,
    List<NostrEvent>? currentUserLikedPosts,
    NostrEvent? currentUserMetadata,
  }) {
    return ProfileState(
      currentUserMetadata: currentUserMetadata ?? this.currentUserMetadata,
      currentUserPosts: currentUserPosts ?? this.currentUserPosts,
      currentUserLikedPosts:
          currentUserLikedPosts ?? this.currentUserLikedPosts,
    );
  }
}

class ProfileInitial extends ProfileState {}
