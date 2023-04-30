import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'loading_user_resources_state.dart';

class LoadingUserResourcesCubit extends Cubit<LoadingUserResourcesStatus> {
  LoadingUserResourcesCubit() : super(LoadingUserResourcesStatus.initial);
}

enum LoadingUserResourcesStatus { initial, loading, success, error }
