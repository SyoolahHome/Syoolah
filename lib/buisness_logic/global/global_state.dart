// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'global_cubit.dart';

class GlobalState extends Equatable {
  final NostrEvent? currentUserFollowing;
  final NostrEvent? currentUserFollowers;

  const GlobalState({
    this.currentUserFollowers,
    this.currentUserFollowing,
  });

  @override
  List<Object?> get props => [
        currentUserFollowing,
        currentUserFollowers,
      ];

  GlobalState copyWith({
    NostrEvent? currentUserFollowing,
    NostrEvent? currentUserFollowers,
  }) {
    return GlobalState(
      currentUserFollowing: currentUserFollowing ?? this.currentUserFollowing,
      currentUserFollowers: currentUserFollowers ?? this.currentUserFollowers,
    );
  }
}

class GlobalInitial extends GlobalState {}
