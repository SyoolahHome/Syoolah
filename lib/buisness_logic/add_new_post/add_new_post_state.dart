// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_new_post_cubit.dart';

class AddNewPostState extends Equatable {
  final File? pickedImage;
  const AddNewPostState({
    this.pickedImage,
  });

  @override
  List<Object?> get props => [
        pickedImage,
      ];

  AddNewPostState copyWith({
    File? pickedImage,
  }) {
    return AddNewPostState(
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }
}

class AddNewPostInitial extends AddNewPostState {}
