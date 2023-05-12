part of 'add_new_post_cubit.dart';

class AddNewPostState extends Equatable {
  final List<File>? pickedImages;
  final List<FeedCategory> categories;
  final bool isLoading;
  final String? success;
  final String? error;
  final String? youtubeUrl;
  final String? acceptedYoutubeUrl;
  final int currentPostAssetsSectionIndex;

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
      ];

  const AddNewPostState({
    this.pickedImages,
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.success,
    this.youtubeUrl,
    this.currentPostAssetsSectionIndex = 0,
    this.acceptedYoutubeUrl,
  });

  AddNewPostState copyWith({
    List<File>? pickedImages,
    List<FeedCategory>? categories,
    bool? isLoading,
    String? error,
    String? success,
    String? youtubeUrl,
    String? acceptedYoutubeUrl,
    int? currentPostAssetsSectionIndex,
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
    );
  }
}

class AddNewPostInitial extends AddNewPostState {
  const AddNewPostInitial({
    required super.categories,
  });
}
