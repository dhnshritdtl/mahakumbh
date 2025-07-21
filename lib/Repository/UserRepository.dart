import 'dart:convert';

import '../Api/api.dart';
import '../Util/preferences.dart';
import '../Util/util_preferences.dart';


class UserRepository {
  Future<dynamic> savePhoneNo(String phoneNo) async {
    return await UtilPreferences.setString(
      Preferences.phoneNo,
      phoneNo,
    );
  }

  Future<dynamic> saveUser(String name) async {
    return await UtilPreferences.setString(
      Preferences.name,
      name,
    );
  }

  dynamic getUser() {
    return UtilPreferences.getString(Preferences.name);
  }

  dynamic getPhoneNo() {
    return UtilPreferences.getString(Preferences.phoneNo);
  }

  Future<dynamic> saveRole(String role) async {
    return await UtilPreferences.setString(
      Preferences.role,
      role,
    );
  }

  dynamic getRole() {
    return UtilPreferences.getString(Preferences.role);
  }

  Future<dynamic> registration(
      {
        String? fullname,
        String? createPassword,
        String? email,
        String? mobileNo,
        String? role,
        String? remark
      }) async {
    final params = {
      'name': fullname,
      'password': createPassword,
      'remark': remark,
      'email': email,
      'mobile_number': mobileNo,
      'role': role,
    };
    return await Api.registration(params);
  }

  // ///Fetch api login
  Future<dynamic> login(
      {String? email,
        String? password,
        // String? token,
        // String? deviceID
      }) async {
    final params = {
      "email": email,
      "password": password,
      // "token": 'Bearer $token',
      // "device_id": deviceID
    };
    return await Api.login(params);
  }

}
