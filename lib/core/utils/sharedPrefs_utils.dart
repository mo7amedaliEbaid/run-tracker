import 'package:shared_preferences/shared_preferences.dart';

interface class PrefsUtils {

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  static Future<bool> removeRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('refreshToken');
  }

  static Future<bool> setRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('refreshToken', refreshToken);
  }


  static Future<String?> getJwt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt');
  }


  static Future<bool> removeJwt() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove('jwt');
  }


  static Future<bool> setJwt(String jwt) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString('jwt', jwt);
  }


  static Future<bool> removeCachedDataFromUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(url);
  }
}
