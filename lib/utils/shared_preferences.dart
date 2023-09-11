import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<SharedPreferences> getSharedPref() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveValue(String key, String value) async {
    await getSharedPref().then((instance) {
      instance.setString(key, value);
    });
  }

  Future<void> saveList(String key, List<String> value) async {
    await getSharedPref().then((instance) {
      instance.setStringList(key, value);
    });
  }

  Future<String?> getValue(String key) async {
    String? val;
    await getSharedPref().then((instance) {
      val = instance.getString(key);
    });
    return val;
  }

  Future<List<String>?> getList(String key) async {
    List<String>? val;
    await getSharedPref().then((instance) {
      val = instance.getStringList(key);
    });
    return val;
  }


}