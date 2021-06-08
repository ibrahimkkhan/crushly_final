import '../models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  SharedPreferences? _preferences;
  static final SharedPref pref = SharedPref._();

  Future<SharedPreferences?> get _getSharedPref async {
    if (_preferences != null)
      return _preferences;
    else {
      _preferences = await SharedPreferences.getInstance();
      return _preferences;
    }
  }

  Future<void> saveUser(User user) async {
    final SharedPreferences? p = await _getSharedPref;
    p!.setString("id", user.id);
    p.setString("name",user.name!);
    p.setString("profilePhoto", user.profilePhoto!);
  }

  Future<void> daleteUser() async {
    final SharedPreferences? p = await _getSharedPref;
    await p!.clear();
  }

  Future<User> getUser() async {
    final SharedPreferences? p = await _getSharedPref;
    return User.fromJson({"_id":p!.getString("id"),
    "name":p.getString("name"),
    "profilePhoto":p.getString("profilePhoto")});
  }

  Future<User?> checkLogin() async {
    final SharedPreferences? p = await _getSharedPref;
    try {
      final id = p!.getString("id");
      if (id != null) {
        return User(id: id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
