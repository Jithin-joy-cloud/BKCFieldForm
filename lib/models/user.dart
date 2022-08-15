import 'package:flutter/cupertino.dart';


class User {
  String id = "";
  String username = "";
  String email = "";
  String employeeID = "";
  String phoneNumber = "";
  String password = "";
  String token = "";
  String createdAt = "";

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      id = jsonMap['_id'].toString();
      username = jsonMap['username'];
      email = jsonMap['email'];
      employeeID = jsonMap['employeeID'].toString();
      phoneNumber = jsonMap['phoneNumber'].toString();
      password = jsonMap['password'].toString();
      createdAt = jsonMap['createdAt'].toString();
      //token = jsonMap['user']['token'];
    }
  }
}
