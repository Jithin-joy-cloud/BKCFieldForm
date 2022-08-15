import 'dart:convert';
import 'dart:io';
import 'package:bkc_field_form/models/user.dart';
import 'package:bkc_field_form/network/api.dart';
import 'package:bkc_field_form/network/response_status.dart';
import 'package:bkc_field_form/utils/sharedPreference.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

ValueNotifier<User> currentUser = ValueNotifier(User());

Future<User> register(User user) async {
  var result = User();
  Map userMap = {
    "username": user.username,
    "employeeID": user.employeeID,
    "phoneNumber": user.phoneNumber,
    "email": user.email,
    "password": user.password,
  };

  try {
    final response = await http.post(Uri.parse('${Api.baseUrl}/user/register'),
        body: json.encode(userMap),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 201) {
      currentUser.value = User.fromJSON(json.decode(response.body)["user"]);
      result = User.fromJSON(json.decode(response.body)["user"]);
      SharedPreference.savePreference(response.body, 'current_user');
    } else {
      result = _response(response);
    }
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
  return result;
}

Future<User> update(User user) async {
  var result = User();
  Map userMap = {
    "_id": user.id,
    "username": user.username,
    "employeeID": user.employeeID,
    "phoneNumber": user.phoneNumber,
  };
  try {
    final response = await http.post(Uri.parse('${Api.baseUrl}/user/updateProfile'),
        body: json.encode(userMap),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      currentUser.value = User.fromJSON(json.decode(response.body)["user"]);
      result = User.fromJSON(json.decode(response.body)["user"]);
      SharedPreference.savePreference(response.body, 'current_user');
    } else {
      result = _response(response);
    }
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
  return result;
}

Future<User> login(User user) async {
  var result = User();
  Map userMap = {
    "email": user.email,
    "password": user.password,
  };
  try {
    final response = await http.post(Uri.parse('${Api.baseUrl}/user/login'),
        body: json.encode(userMap),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      currentUser.value = User.fromJSON(json.decode(response.body)["user"]);
      SharedPreference.savePreference(response.body, 'current_user');
      result = User.fromJSON(json.decode(response.body)["user"]);
    } else {
      result = _response(response);
    }
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
  return result;
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 409:
      throw DuplicateEntryException("");
    case 404:
      throw UnauthorisedException("");
    case 401:
      throw PasswordMissMatchException("");
    case 400:
      throw BadRequestException("");
    case 500:
      throw ServerErrorException("");
    default:
      throw FetchDataException(
          'Error occurred while Communication with Server ');
  }
}
