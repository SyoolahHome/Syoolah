// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mute_cubit.dart';

class MuteState extends Equatable {
  final NostrEvent? muteEvent;

  const MuteState({
    this.muteEvent,
  });

  @override
  List<Object?> get props => [muteEvent];

  MuteState copyWith({
    NostrEvent? muteEvent,
  }) {
    return MuteState(
      muteEvent: muteEvent ?? this.muteEvent,
    );
  }
}

class MuteInitial extends MuteState {
  MuteInitial({
    super.muteEvent,
  });
}
