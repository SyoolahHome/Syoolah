import 'package:bloc/bloc.dart';
import 'package:ditto/services/nostr/nostr_service.dart';

/// {@template nostr_service_loading_cubit}
/// The responsible cubit about the nostr service loading.
/// {@endtemplate}
class NostrServiceLoadingCubit extends Cubit<bool?> {
  /// {@macro nostr_service_loading_cubit}
  NostrServiceLoadingCubit() : super(null) {
    _load();
  }

  /// Loads the nostr service.
  Future<void> _load() async {
    try {
      await NostrService.instance.relaysConnectionCompleter!.future;
      emit(true);
    } catch (e) {
      print(e);
      emit(false);
    }
  }
}
