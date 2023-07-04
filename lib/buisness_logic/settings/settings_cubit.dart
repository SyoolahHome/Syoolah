import 'package:bloc/bloc.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:equatable/equatable.dart';

/// {@template settings_cubit}
/// The responsible cubit about the settings UI.
/// {@endtemplate}
class SettingsCubit extends Cubit<Null> {
  /// {@macro settings_cubit}
  SettingsCubit() : super(null);

  /// Toggles the dark mode.
  Future<void> switchDarkMode() {
    return LocalDatabase.instance.toggleThemeState();
  }

  /// Logs out the current user.
  Future<void> logout({required void Function() onSuccess}) {
    return LocalDatabase.instance.logoutUser(onSuccess: onSuccess);
  }
}
