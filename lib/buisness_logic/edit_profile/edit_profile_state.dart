part of "./edit_profile_cubit.dart";

class EditProfileState extends Equatable {
  final String? error;

  const EditProfileState({
    this.error,
  });

  @override
  List<Object?> get props => [error];

  EditProfileState copyWith({
    String? error,
  }) {
    return EditProfileState(
      error: error,
    );
  }
}
