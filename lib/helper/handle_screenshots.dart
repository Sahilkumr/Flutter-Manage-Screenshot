import "dart:io";
import "package:flutter/services.dart";
import "package:flutter_windowmanager/flutter_windowmanager.dart";

//using the windowmanger and Native IOS Code [which is not working (? isCaptured[depreceted])]

class HandleScreenshots {
  static Future<void> toggleScreenshot({required bool disableSs}) async {
    if (Platform.isAndroid) {
      await _toggleScreenshotsAndroid(disableSs);
    } else if (Platform.isIOS) {
      // await _toggleScreenshotsIos(disableSs);
      return;
    }
  }

  static Future<void> _toggleScreenshotsAndroid(bool disableAndroidSs) async {
    if (disableAndroidSs == true) {
      try {
        await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
      } catch (e) {
        throw Exception(
          'Unable to Disable Screenshot [Android]:${e.toString()}',
        );
      }
    } else {
      try {
        await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
      } catch (e) {
        throw Exception(
          'Unable to Enable Screenshot [Android]:${e.toString()}',
        );
      }
    }
  }

  //For toggleScreenshot to Work Ios
  //Add Channel Method Acces Code in AppDelegate-> Swift
  static Future<void> _toggleScreenshotsIos(bool disableIosSs) async {
    const platform = MethodChannel('toggle_screenshot');
    if (disableIosSs) {
      try {
        await platform.invokeMethod('disable');
      } catch (e) {
        throw Exception(
          'Unable to Disable Screenshot Feature [IOS] : $e',
        );
      }
    } else {
      try {
        await platform.invokeMethod('enable');
      } catch (e) {
        throw Exception(
          'Unable to Enable ScreenShot Feature [IOS] : $e',
        );
      }
    }
  }
}
