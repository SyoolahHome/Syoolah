import 'package:bloc/bloc.dart';
import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  Future<void> switchDarkMode() {
    return LocalDatabase.instance.toggleThemeState();
  }

  Future<void> logout() {
    return LocalDatabase.instance.logoutUser(
      onSuccess: () {},
    );
  }
}
