import 'package:bloc/bloc.dart';
import 'package:ditto/model/tts_voice.dart';
import 'package:ditto/services/tts/tts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

part 'eleven_labs_voices_selection_state.dart';

class ElevenLabsVoicesSelectionCubit
    extends Cubit<ElevenLabsVoicesSelectionState> {
  static List<TtsVoice>? _localCachedVoices;

  ElevenLabsVoicesSelectionCubit() : super(ElevenLabsVoicesSelectionInitial()) {
    _loadVoices();
  }

  Future<void> _loadVoices() async {
    try {
      if (_localCachedVoices != null && _localCachedVoices!.isNotEmpty) {
        emit(state.copyWith(
          voices: _localCachedVoices,
        ));

        return;
      }

      emit(state.copyWith(
        isLoading: true,
      ));
      final voices = await TTS.voices();

      _localCachedVoices = voices;

      emit(state.copyWith(
        voices: voices,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: "error".tr(),
      ));
    } finally {
      emit(state.copyWith(
        isLoading: false,
      ));
    }
  }
}
