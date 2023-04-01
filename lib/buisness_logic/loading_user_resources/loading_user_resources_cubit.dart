import 'package:bloc/bloc.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';
import 'package:nostr/nostr.dart';

part 'loading_user_resources_state.dart';

enum LoadingUserResourcesStatus { initial, loading, success, error }

class LoadingUserResourcesCubit extends Cubit<LoadingUserResourcesStatus> {
  LoadingUserResourcesCubit() : super(LoadingUserResourcesStatus.initial) {
  }


}
