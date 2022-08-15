import 'dart:convert';
import 'dart:io';
import 'package:bkc_field_form/models/completeForm.dart';
import 'package:bkc_field_form/models/user.dart';
import 'package:bkc_field_form/network/api.dart';
import 'package:bkc_field_form/network/response_status.dart';
import 'package:bkc_field_form/objectbox.g.dart';
import 'package:bkc_field_form/repository/user_repository.dart';
import 'package:bkc_field_form/utils/sharedPreference.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<bool> upload(CompleteForm form) async {
  bool result = false;
  Map generalMap = form.general.target!.toMap();
  Map houseMap = form.house.target!.toMap();
  Map b1map = form.buildComponentOne.target!.toMap();
  Map b2map = form.buildComponentTwo.target!.toMap();
  Map b3map = form.buildComponentThree.target!.toMap();
  Map formMap = form.toMap(form.id, generalMap, houseMap, b1map, b2map, b3map);
  try {
    final response = await http.post(
        Uri.parse('${Api.baseUrl}/form/createForm'),
        body: json.encode(formMap),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 201) {
      result = true;
    } else {
      result = false;
      result = _response(response);
    }
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
  return result;
}

Future<List<CompleteForm>> getForm() async {
  List<CompleteForm> result;
  Map formMap = {
    "email": currentUser.value.email,
  };
  try {
    final response = await http.post(Uri.parse('${Api.baseUrl}/form/getForm'),
        body: json.encode(formMap),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200) {
      result = [CompleteForm()];
      result.clear();
      var resultList = json.decode(response.body)["data"];
      for (int i = 0; i < resultList.length; i++) {
      result.add(CompleteForm.fromJSON(resultList[i]));
      }
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
