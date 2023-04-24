part of 'users_list_to_follow_cubit.dart';

class UsersListToFollowState extends Equatable {
  final List<NostrEvent> pubKeysMetadata;
  const UsersListToFollowState({
    this.pubKeysMetadata = const [],
  });

  @override
  List<Object> get props => [
        pubKeysMetadata,
      ];

  UsersListToFollowState copyWith({
    List<NostrEvent>? pubKeysMetadata,
  }) {
    return UsersListToFollowState(
      pubKeysMetadata: pubKeysMetadata ?? this.pubKeysMetadata,
    );
  }
}

class UsersListToFollowInitial extends UsersListToFollowState {}
