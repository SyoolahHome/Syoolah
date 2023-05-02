import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/nostr/nostr_service.dart';

part 'nostr_service_loading_state.dart';

class NostrServiceLoadingCubit extends Cubit<bool?> {
  NostrServiceLoadingCubit() : super(null) {
    _load();
  }

  Future<void> _load() async {
    try {
      await NostrService.instance.relaysConnectionCompleter.future;
      emit(true);
    } catch (e) {
      print(e);
      emit(false);
    }
  }
}
