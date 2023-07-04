import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:equatable/equatable.dart';

part 'home_page_after_login_state.dart';

/// {@template home_page_after_login_state}
/// The responsible cubit about the home page that is shown after the auth.
/// {@endtemplate}
class HomePageAfterLoginCubit extends Cubit<HomePageAfterLoginState> {
  /// {@macro home_page_after_login_state}
  HomePageAfterLoginCubit() : super(HomePageAfterLoginState.initial()) {
    connectToRelaysAndSubscribeToTopics();
  }

  /// Connects and starts the connection to the relays
  void connectToRelaysAndSubscribeToTopics() {
    try {
      emit(state.copyWith(isLoading: true));
      emit(state.copyWith(didConnectedToRelaysAndSubscribedToTopics: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
