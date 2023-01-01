import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static final _storage = FlutterSecureStorage();

  // static const _keyImage


  Future writeSecData(String key, String value) async {
    var writeData = await _storage.write(key: key, value: value);
    return writeData;
  }
  Future readSecData(String key) async {
    var readData = await _storage.read(key: key);
    return readData;
  }
  Future deleteSecData(String key) async{
    var deleteData = await _storage.delete(key: key);
  }
}
