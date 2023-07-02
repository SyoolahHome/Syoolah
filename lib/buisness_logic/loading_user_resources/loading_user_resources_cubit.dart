import 'package:bloc/bloc.dart';

import '../../constants/app_enums.dart';

class LoadingUserResourcesCubit extends Cubit<LoadingUserResourcesStatus> {
  LoadingUserResourcesCubit() : super(LoadingUserResourcesStatus.initial);
}
