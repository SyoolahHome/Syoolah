import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr_client/nostr_client.dart';

part 'home_page_after_login_state.dart';

class HomePageAfterLoginCubit extends Cubit<HomePageAfterLoginState> {
  HomePageAfterLoginCubit() : super(const HomePageAfterLoginInitial()) {
    connectToRelaysAndSubscribeToTopics();
  }

  void connectToRelaysAndSubscribeToTopics() async {
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
