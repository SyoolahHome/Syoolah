// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'current_user_reposts_cubit.dart';

class CurrentUserRepostsState extends Equatable {
  final List<NostrEvent> currentUserReposts;

  const CurrentUserRepostsState({
    this.currentUserReposts = const [],
  });

  @override
  List<Object> get props => [
        currentUserReposts,
      ];

  CurrentUserRepostsState copyWith({
    List<NostrEvent>? currentUserReposts,
  }) {
    return CurrentUserRepostsState(
      currentUserReposts: currentUserReposts ?? this.currentUserReposts,
    );
  }
}

class CurrentUserRepostsInitial extends CurrentUserRepostsState {}
