part of 'add_new_post_cubit.dart';

/// {@template add_new_post_state}
/// the state of the [AddNewPostCubit]
/// {@endtemplate}
class AddNewPostState extends Equatable {
  /// Picked images by user.
  final List<XFile>? pickedImages;

  /// feed categories which user will choose from.
  final List<FeedCategory> categories;

  /// Represents a loading state, to show indicators...
  final bool isLoading;

  /// Represents a success state, to show messages..
  final String? success;

  /// Represents a error state, to show messages..
  final String? error;

  /// Holder of a youtube video url input if any is selected by user.
  final String? youtubeUrl;

  /// Holder of an accepted & validated youtube video url that is taken by [youtubeUrl]
  final String? acceptedYoutubeUrl;

  /// The index of the section to show for assets to the note
  final int currentPostAssetsSectionIndex;

  /// Weither the post send sheet should collapse to full screen or not.
  final bool collapseToFullScreen;

  @override
  List<Object?> get props => [
        pickedImages,
        categories,
        success,
        error,
        isLoading,
        youtubeUrl,
        currentPostAssetsSectionIndex,
        acceptedYoutubeUrl,
        collapseToFullScreen,
      ];

  /// {@macro add_new_post_state}
  const AddNewPostState({
    this.pickedImages,
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.success,
    this.youtubeUrl,
    this.currentPostAssetsSectionIndex = 0,
    this.acceptedYoutubeUrl,
    this.collapseToFullScreen = false,
  });

  /// {@macro add_new_post_state}
  AddNewPostState copyWith({
    List<XFile>? pickedImages,
    List<FeedCategory>? categories,
    bool? isLoading,
    String? error,
    String? success,
    String? youtubeUrl,
    String? acceptedYoutubeUrl,
    int? currentPostAssetsSectionIndex,
    bool? collapseToFullScreen,
  }) {
    return AddNewPostState(
      pickedImages: pickedImages,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      acceptedYoutubeUrl: acceptedYoutubeUrl ?? this.acceptedYoutubeUrl,
      currentPostAssetsSectionIndex:
          currentPostAssetsSectionIndex ?? this.currentPostAssetsSectionIndex,
      collapseToFullScreen: collapseToFullScreen ?? this.collapseToFullScreen,
    );
  }
}

class AddNewPostInitial extends AddNewPostState {
  const AddNewPostInitial({
    required super.categories,
  });
}
