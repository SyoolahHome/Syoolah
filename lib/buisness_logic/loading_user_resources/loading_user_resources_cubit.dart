import 'package:bloc/bloc.dart';

import '../../constants/app_enums.dart';

/// {@template loading_user_resource_cubit}
/// The responsible cubit about the laoding user resource.
/// {@endtemplate}
class LoadingUserResourcesCubit extends Cubit<LoadingUserResourcesStatus> {
  /// {@macro loading_user_resource_cubit}
  LoadingUserResourcesCubit() : super(LoadingUserResourcesStatus.initial);
}
