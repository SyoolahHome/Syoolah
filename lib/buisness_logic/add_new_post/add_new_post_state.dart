// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_new_post_cubit.dart';

class AddNewPostState extends Equatable {
  final File? pickedImage;
  final List<FeedCategory> categories;
  const AddNewPostState({this.pickedImage, this.categories = const []});

  @override
  List<Object?> get props => [
        pickedImage,
        categories,
      ];

  AddNewPostState copyWith({
    File? pickedImage,
    List<FeedCategory>? categories,
  }) {
    return AddNewPostState(
      pickedImage: pickedImage ?? this.pickedImage,
      categories: categories ?? this.categories,
    );
  }
}

class AddNewPostInitial extends AddNewPostState {
  const AddNewPostInitial({
    required super.categories,
  });
}
