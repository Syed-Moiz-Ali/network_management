// In your Dart code
// ignore_for_file: avoid_print

import 'package:flutter/services.dart';

class AppControl {
  static const platform = MethodChannel('app_control');

  static Future<void> uninstallApp(String packageName) async {
    try {
      // await platform.invokeMethod('uninstallApp', {'packageName': packageName});

      print('this package $packageName is uninstalled');
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
    }
  }

  static Future<void> blockInternetAccess(String packageName) async {
    try {
      await platform
          .invokeMethod('blockInternetAccess', {'packageName': packageName});
      print('this package $packageName has blockInternetAccess');
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
    }
  }
}
