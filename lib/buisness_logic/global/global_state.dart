// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_cubit.dart';

class GlobalState extends Equatable {
  final NostrEvent? currentUserFollowing;
  final NostrEvent? currentUserFollowers;

  @override
  List<Object?> get props => [
        currentUserFollowing,
        currentUserFollowers,
      ];

  const GlobalState({
    this.currentUserFollowers,
    this.currentUserFollowing,
  });

  GlobalState copyWith({
    NostrEvent? currentUserFollowing,
    NostrEvent? currentUserFollowers,
  }) {
    return GlobalState(
      currentUserFollowers: currentUserFollowers ?? this.currentUserFollowers,
      currentUserFollowing: currentUserFollowing ?? this.currentUserFollowing,
    );
  }
}

class GlobalInitial extends GlobalState {}
