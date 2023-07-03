part of "./edit_profile_cubit.dart";

/// {@template edit_profile_state}
/// The state of [EditProfileCubit]
/// {endtemplate}
class EditProfileState extends Equatable {
  /// An error string, if it exists
  final String? error;

  /// {@macro edit_profile_state}
  const EditProfileState({
    this.error,
  });

  @override
  List<Object?> get props => [
        error,
      ];

  /// {@macro edit_profile_state}
  EditProfileState copyWith({
    String? error,
  }) {
    return EditProfileState(
      error: error,
    );
  }

  factory EditProfileState.initial() {
    return EditProfileInitial();
  }
}

/// {@macro edit_profile_state}
class EditProfileInitial extends EditProfileState {}
