import 'package:bloc/bloc.dart';

class LoadingUserResourcesCubit extends Cubit<LoadingUserResourcesStatus> {
  LoadingUserResourcesCubit() : super(LoadingUserResourcesStatus.initial);
}
