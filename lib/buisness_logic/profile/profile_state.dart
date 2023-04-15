// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final List<NostrEvent> currentUserPosts;
  final List<NostrEvent> currentUserLikedPosts;
  final NostrEvent? currentUserMetadata;
  final List<TabItem> profileTabsItems;
  final File? pickedAvatarImage;
  final File? pickedBannerImage;
  final String? error;
  final int followersCount;
  final int followingCount;
  final double profileAvatarScale;
  final bool isLoading;
  const ProfileState({
    this.profileTabsItems = const [],
    this.error,
    this.currentUserPosts = const [],
    this.currentUserLikedPosts = const [],
    this.currentUserMetadata,
    this.pickedAvatarImage,
    this.pickedBannerImage,
    this.followersCount = 0,
    this.followingCount = 0,
    this.profileAvatarScale = 1.0,
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        currentUserPosts,
        currentUserMetadata,
        currentUserLikedPosts,
        pickedAvatarImage,
        pickedBannerImage,
        error,
        profileTabsItems,
        followersCount,
        followingCount,
        profileAvatarScale,
        isLoading,
      ];

  ProfileState copyWith({
    List<NostrEvent>? currentUserPosts,
    List<NostrEvent>? currentUserLikedPosts,
    NostrEvent? currentUserMetadata,
    File? pickedAvatarImage,
    File? pickedBannerImage,
    String? error,
    List<TabItem>? profileTabsItems,
    int? followersCount,
    int? followingCount,
    double? profileAvatarScale,
    bool? isLoading,
  }) {
    return ProfileState(
      pickedAvatarImage: pickedAvatarImage ?? this.pickedAvatarImage,
      pickedBannerImage: pickedBannerImage ?? this.pickedBannerImage,
      currentUserMetadata: currentUserMetadata ?? this.currentUserMetadata,
      currentUserPosts: currentUserPosts ?? this.currentUserPosts,
      currentUserLikedPosts:
          currentUserLikedPosts ?? this.currentUserLikedPosts,
      error: error ?? this.error,
      profileTabsItems: profileTabsItems ?? this.profileTabsItems,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      profileAvatarScale: profileAvatarScale ?? this.profileAvatarScale,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProfileInitial extends ProfileState {
  const ProfileInitial({
    required super.profileTabsItems,
  });
}
