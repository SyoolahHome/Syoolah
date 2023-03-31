import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:ditto/services/nostr/custom.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr/nostr.dart';

import '../../model/filters.dart';
import '../../model/request.dart';

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
