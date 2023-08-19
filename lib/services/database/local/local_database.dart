import 'package:ditto/services/database/local/base/local_database_base.dart';
import 'package:hive_flutter/adapters.dart';

class LocalDatabase implements LocalDatabaseBase {
  final String dbName = "local_database";

  static final LocalDatabase _instance = LocalDatabase._();
  static LocalDatabase get instance => _instance;
  LocalDatabase._();

  @override
  Future<void> deleteValue(String key) {
    return Hive.box(dbName).delete(key);
  }

  @override
  dynamic getValue(String key) {
    return Hive.box(dbName).get(key);
  }

  @override
  Future<void> setValue(String key, value) {
    return Hive.box(dbName).put(key, value);
  }

  @override
  Future<Box> init() async {
    await Hive.initFlutter();
    final box = await Hive.openBox(dbName);

    return box;
  }

  Future<String> setPrivateKey(String? value) async {
    await setValue("privateKey", value);

    return getPrivateKey()!;
  }

  Future<void> setName(String name) {
    return setValue("username", name);
  }

  Future<void> setAuthInformations({
    required String key,
    required String name,
  }) {
    return Future.wait([
      setPrivateKey(key),
      setName(name),
    ]);
  }

  String? getPrivateKey() {
    return getValue("privateKey") as String?;
  }

  @override
  Stream getStream(String key) {
    return Hive.box(dbName).watch(key: key).map((event) => event.value);
  }

  Stream<String?> getPrivateKeyStream() {
    return getStream("privateKey").map((event) => event as String?);
  }

  @override
  Future<void> deletePrivateKey() async {
    await deleteValue("privateKey");

    final maybePrivateKey = getPrivateKey();

    if (maybePrivateKey != null) {
      throw Exception("privateKey is not deleted !");
    }
  }

  Stream<bool> themeStateListenable() {
    return getStream("themeState").map((event) => event as bool);
  }

  Future<void> setThemeState(bool value) {
    return setValue("themeState", value);
  }

  bool? getThemeState() {
    return getValue("themeState");
  }

  Future<void> toggleThemeState() {
    final currentThemeState = getThemeState() ?? false;
    return setThemeState(!currentThemeState);
  }

  bool isAlreadyUserExists() {
    return getPrivateKey() != null;
  }

  Future<void> logoutUser({
    required void Function() onSuccess,
    void Function(Object?)? onError,
  }) async {
    try {
      await deletePrivateKey();

      onSuccess();
    } catch (e) {
      if (onError != null) {
        onError(e);
      }
    }
  }
}
