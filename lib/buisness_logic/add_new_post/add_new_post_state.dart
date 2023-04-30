part of 'add_new_post_cubit.dart';

class AddNewPostState extends Equatable {
  final List<File>? pickedImages;
  final List<FeedCategory> categories;
  final bool isLoading;
  final String? success;
  final String? error;

  @override
  List<Object?> get props => [
        pickedImages,
        categories,
        success,
        error,
        isLoading,
      ];

  const AddNewPostState({
    this.pickedImages,
    this.categories = const [],
    this.isLoading = false,
    this.error,
    this.success,
  });

  AddNewPostState copyWith({
    List<File>? pickedImages,
    List<FeedCategory>? categories,
    bool? isLoading,
    String? error,
    String? success,
  }) {
    return AddNewPostState(
      pickedImages: pickedImages,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success,
    );
  }
}

class AddNewPostInitial extends AddNewPostState {
  const AddNewPostInitial({
    required super.categories,
  });
}
