import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;
    static const _keyRoom = 'room';
    static const _keyEmail= 'email';
    static const _keyPass = 'pass';
    static const _keyType = 'type';


  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setRoom(String room) async =>
      await _preferences?.setString(_keyRoom, room);

  static String? getRoom() => _preferences?.getString(_keyRoom);
  
  
  static Future setEmail(String email) async =>
      await _preferences?.setString(_keyEmail, email);

  static String? getEmail() => _preferences?.getString(_keyEmail);
  
  
  
  static Future setPass(String pass) async =>
      await _preferences?.setString(_keyPass,pass);

  static String? getPass() => _preferences?.getString(_keyPass);

  static Future setType(String type) async =>
      await _preferences?.setString(_keyType,type);

  static String? getType() => _preferences?.getString(_keyType);

  
  static void erase()async =>await _preferences?.clear();


 
}