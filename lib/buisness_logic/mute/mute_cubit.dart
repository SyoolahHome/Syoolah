import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:equatable/equatable.dart';

part 'mute_state.dart';

class MuteCubit extends Cubit<MuteState> {
  final NostrEventsStream muteEventStream;

  MuteCubit({
    required this.muteEventStream,
  }) : super(MuteInitial()) {
    _init();
  }

  void _init() {
    muteEventStream.stream.listen((event) {
      emit(state.copyWith(muteEvent: event));
    });
  }

  void muteUserPublicly({
    required void Function() onSuccess,
    required String pubKey,
  }) {
    NostrService.instance.muteUserWithPubKeyPublicly(
      currentMuteEvent: state.muteEvent,
      pubKey: pubKey,
    );

    onSuccess.call();
  }

  void muteUserPrivately({
    required void Function() onSuccess,
    required String pubKey,
  }) {
    NostrService.instance.muteUserWithPubKeyPrivately(
      currentMuteEvent: state.muteEvent,
      pubKey: pubKey,
    );

    onSuccess.call();
  }
}
