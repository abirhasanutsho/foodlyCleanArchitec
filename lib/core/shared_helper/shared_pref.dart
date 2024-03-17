import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';

setAccessToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("token", token);
  accessToken = token;
}

clearAll() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('access_token');
  prefs.remove('loginResponse');
  prefs.remove('registerResponse');
  prefs.remove('oneClickResponse');
  prefs.remove('rememberMe');
  prefs.remove('userType');
  prefs.remove('userId');
  prefs.remove('fcm');
  prefs.clear();
}

getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  return token ?? "";
}

setRememberMe(bool remember) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool("rememberMe", remember);
}

Future getRememberMe() async {
  final prefs = await SharedPreferences.getInstance();
  bool? rem = prefs.getBool("rememberMe");
  return rem ?? false;
}

setUserTypeIdLocal(int userType) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt("userType", userType);
}

Future getUserTypeIdLocal() async {
  final prefs = await SharedPreferences.getInstance();
  int? userType = prefs.getInt("userType");
  return userType ?? 0;
}

setUserId(String? userId) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString("userId", userId!);
}

Future getUserID() async {
  final prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString("userId");
  return userId ?? "";
}

void storeFcmToken(String token) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('fcm', token);
}

Future<String> getFcmToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('fcm') ?? "";
}
