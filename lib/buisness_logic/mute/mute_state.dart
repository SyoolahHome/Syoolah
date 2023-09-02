part of 'mute_cubit.dart';

/// {@template mute_state}
/// The stat of [MuteCubit].
/// {@endtemplate}
class MuteState extends Equatable {
  /// TODO: separated private and public events for mute.
  final NostrEvent? muteEvent;

  /// {@macro mute_state}
  const MuteState({
    this.muteEvent,
  });

  @override
  List<Object?> get props => [muteEvent];

  /// {@macro mute_state
  MuteState copyWith({
    NostrEvent? muteEvent,
  }) {
    return MuteState(
      muteEvent: muteEvent ?? this.muteEvent,
    );
  }

  factory MuteState.initial() {
    return MuteInitial();
  }
}

/// {@macro mute_state}
class MuteInitial extends MuteState {
  MuteInitial({
    super.muteEvent,
  });
}
