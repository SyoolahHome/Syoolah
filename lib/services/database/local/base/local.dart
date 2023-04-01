abstract class LocalDatabaseBase {
  Future<void> setValue(String key, dynamic value);
  dynamic getValue(String key);
  Future<void> deleteValue(String key);
  Future<void> init();

  Stream getStream(String key);
  Future deletePrivateKey();
}
