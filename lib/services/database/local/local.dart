import 'package:hive_flutter/adapters.dart';

import 'base/local.dart';

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
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(dbName);
  }

  Future<void> setPrivateKey(String key) {
    return setValue("privateKey", key);
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

  String getPrivateKey() {
    return getValue("privateKey") as String;
  }
}
