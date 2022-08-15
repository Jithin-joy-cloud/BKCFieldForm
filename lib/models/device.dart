import 'package:flutter/cupertino.dart';

ValueNotifier<Device> currentDevice = ValueNotifier(Device());
class Device {
  String name = "";
  double height = 0;
  double width = 0;

  Device();

  Device.fromJSON(Map<String, dynamic> jsonMap) {
    if (jsonMap.isNotEmpty) {
      name = jsonMap['name'].toString();
      height = jsonMap['height'];
      width = jsonMap['width'];
    }
  }
}
