part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final NostrEvent? currentUserMetadata;
  final List<TabItem> profileTabsItems;
  final File? pickedAvatarImage;
  final File? pickedBannerImage;
  final String? error;

  final int followersCount;
  final int followingCount;
  final double profileAvatarScale;
  final bool isLoading;

  @override
  List<Object?> get props => [
        currentUserMetadata,
        pickedAvatarImage,
        pickedBannerImage,
        error,
        profileTabsItems,
        followersCount,
        followingCount,
        profileAvatarScale,
        isLoading,
      ];

  const ProfileState({
    this.profileTabsItems = const [],
    this.error,
    this.currentUserMetadata,
    this.pickedAvatarImage,
    this.pickedBannerImage,
    this.followersCount = 0,
    this.followingCount = 0,
    this.profileAvatarScale = 1.0,
    this.isLoading = false,
  });

  ProfileState copyWith({
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
      profileTabsItems: profileTabsItems ?? this.profileTabsItems,
      error: error ?? this.error,
      currentUserMetadata: currentUserMetadata ?? this.currentUserMetadata,
      pickedAvatarImage: pickedAvatarImage ?? this.pickedAvatarImage,
      pickedBannerImage: pickedBannerImage ?? this.pickedBannerImage,
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
