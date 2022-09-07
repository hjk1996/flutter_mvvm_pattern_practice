import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/domain/model/model.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";

  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      name = build.brand + " " + build.model;
      identifier = build.androidId;
      version = build.version.toString();
      return DeviceInfo(name, identifier, version);
    } else if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      name = build.name + " " + build.model;
      identifier = build.identifierForVendor;
      version = build.systemVersion;
      return DeviceInfo(name, identifier, version);
    }
  } on PlatformException {
    // return default data
    return DeviceInfo(name, identifier, version);
  }

  return DeviceInfo(name, identifier, version);
}
