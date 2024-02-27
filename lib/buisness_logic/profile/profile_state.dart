part of 'profile_cubit.dart';

/// {@template profile_state}
///  The state of [ProfileCubit].
/// {@endtemplate}
class ProfileState extends Equatable {
  /// The event containing the user meta data.
  final NostrEvent? userMetadataEvent;

  /// The decoded user meta data.
  final UserMetaData? metadata;

  /// The profile tabs items to be represented in the UI.
  final List<TabItem> profileTabsItems;

  /// The picker avatar image.
  final XFile? pickedAvatarImage;

  /// The picked banner image.
  final XFile? pickedBannerImage;

  /// An error if it exists to be represented.
  final String? error;

  /// The number of user's followers.
  final int followersCount;

  /// The number of user's followings.
  final int followingCount;

  /// The scale value of the avatar UI box.
  final double profileAvatarScale;

  /// Weither is loading.
  final bool isLoading;

  @override
  List<Object?> get props => [
        userMetadataEvent,
        pickedAvatarImage,
        pickedBannerImage,
        error,
        profileTabsItems,
        followersCount,
        followingCount,
        profileAvatarScale,
        isLoading,
      ];

  /// {@macro profile_state}
  const ProfileState({
    this.metadata,
    this.profileTabsItems = const [],
    this.error,
    this.userMetadataEvent,
    this.pickedAvatarImage,
    this.pickedBannerImage,
    this.followersCount = 0,
    this.followingCount = 0,
    this.profileAvatarScale = 1.0,
    this.isLoading = false,
  });

// {@macro profile_state}
  ProfileState copyWith({
    NostrEvent? userMetadataEvent,
    XFile? pickedAvatarImage,
    XFile? pickedBannerImage,
    String? error,
    List<TabItem>? profileTabsItems,
    int? followersCount,
    int? followingCount,
    double? profileAvatarScale,
    bool? isLoading,
    UserMetaData? metadata,
  }) {
    return ProfileState(
      profileTabsItems: profileTabsItems ?? this.profileTabsItems,
      error: error ?? this.error,
      userMetadataEvent: userMetadataEvent ?? this.userMetadataEvent,
      pickedAvatarImage: pickedAvatarImage ?? this.pickedAvatarImage,
      pickedBannerImage: pickedBannerImage ?? this.pickedBannerImage,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      profileAvatarScale: profileAvatarScale ?? this.profileAvatarScale,
      isLoading: isLoading ?? this.isLoading,
      metadata: metadata ?? this.metadata,
    );
  }

// {@macro profile_state}
  ProfileState copyWithNullAvatar() {
    return ProfileState(
      profileTabsItems: this.profileTabsItems,
      error: this.error,
      userMetadataEvent: this.userMetadataEvent,
      pickedAvatarImage: null,
      pickedBannerImage: this.pickedBannerImage,
      followersCount: this.followersCount,
      followingCount: this.followingCount,
      profileAvatarScale: this.profileAvatarScale,
      isLoading: this.isLoading,
      metadata: this.metadata,
    );
  }

// {@macro profile_state}
  ProfileState copyWithNullBanner() {
    return ProfileState(
      profileTabsItems: this.profileTabsItems,
      error: this.error,
      userMetadataEvent: this.userMetadataEvent,
      pickedAvatarImage: this.pickedAvatarImage,
      pickedBannerImage: null,
      followersCount: this.followersCount,
      followingCount: this.followingCount,
      profileAvatarScale: this.profileAvatarScale,
      isLoading: this.isLoading,
      metadata: this.metadata,
    );
  }

  /// {@macro profile_state}
  factory ProfileState.initial({
    required List<TabItem> profileTabsItems,
  }) {
    return ProfileInitial(profileTabsItems: profileTabsItems);
  }
}

/// {@macro profile_state}

class ProfileInitial extends ProfileState {
  const ProfileInitial({
    required super.profileTabsItems,
  });
}
