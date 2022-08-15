import 'dart:convert';
import 'package:bkc_field_form/models/user.dart';
import 'package:bkc_field_form/repository/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/device.dart';
import 'helper.dart';

class SharedPreference {
  static savePreference(String jsonString, String name) async {
    try {
      if (json.decode(jsonString) != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(name, json.encode(json.decode(jsonString)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

Future<User> getCurrentUser() async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {

      currentUser.value =
          User.fromJSON(json.decode(prefs.getString('current_user')!)['user']);
    } else {
      return currentUser.value;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return currentUser.value;
}

Future<String> logoutWithCache() async {
  String value = "";
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    value = "Pref cleared";
  } catch (e) {
    value = "Something went wrong";
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return value;
}
