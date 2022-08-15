import 'package:bkc_field_form/network/response_status.dart';
import 'package:bkc_field_form/utils/sharedPreference.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RemoteConfigService {
  static Future<FirebaseRemoteConfig> setupRemoteConfig(
      BuildContext context) async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
        minimumFetchInterval: const Duration(seconds: 1),
        fetchTimeout: const Duration(minutes: 1)));
    remoteConfig.setDefaults(<String, dynamic>{
      'default': "default",
    });
    try {
      await remoteConfig.fetch();
      await remoteConfig.fetchAndActivate();
      SharedPreference.savePreference(
          remoteConfig.getValue("houseDetails").asString(), 'houseDetails');
      SharedPreference.savePreference(
          remoteConfig.getValue("buildingComponentOne").asString(),
          'buildingComponentOne');
      SharedPreference.savePreference(
          remoteConfig.getValue("buildingComponentTwo").asString(),
          'buildingComponentTwo');
      SharedPreference.savePreference(
          remoteConfig.getValue("buildingComponentThree").asString(),
          'buildingComponentThree');
    } on FetchDataException catch (exception) {
      if (kDebugMode) {
        print(exception);
      }
    } catch (exception) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
          content: Text("Please check your internet connection"),
        ));
    }
    return remoteConfig;
  }
}
