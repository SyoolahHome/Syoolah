import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';

part 'mute_state.dart';

/// {@template mute_cubit}
/// The responsible cubut about the mute feature for shown notes.
/// {@endtemplate}
class MuteCubit extends Cubit<MuteState> {
  /// The mute event Nostr stream.
  final NostrEventsStream muteEventStream;

  /// The subscription that will listen to [muteEventStream.stream].
  StreamSubscription<NostrEvent>? muteEventStreamSubscription;

  /// {@macrp mute_cubit}
  MuteCubit({
    required this.muteEventStream,
  }) : super(MuteState.initial()) {
    _init();
  }

  @override
  Future<void> close() {
    muteEventStreamSubscription?.cancel();

    return super.close();
  }

  /// Mute users in a public way so everyone will be able to see and check it.
  void muteUserPublicly({
    required void Function() onSuccess,
    required String pubKey,
  }) {
    NostrService.instance.send.muteUserWithPubKeyPublicly(
      currentMuteEvent: state.muteEvent,
      pubKey: pubKey,
    );

    onSuccess.call();
  }

  /// Mute users in a private way so only the owner user of the mute event will be able to see and check it.
  void muteUserPrivately({
    required void Function() onSuccess,
    required String pubKey,
  }) {
    NostrService.instance.send.muteUserWithPubKeyPrivately(
      currentMuteEvent: state.muteEvent,
      pubKey: pubKey,
    );

    onSuccess.call();
  }

  void _init() {
    muteEventStreamSubscription = muteEventStream.stream.listen((event) {
      emit(state.copyWith(muteEvent: event));
    });
  }
}
