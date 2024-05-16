import 'package:no_screenshot/no_screenshot.dart';

//using the package no_screenshot

class ToggleScreenshot {
  static void _enableScreenshot() async {
    await NoScreenshot.instance.screenshotOn();
  }

  static get enableSS => _enableScreenshot();

  static void _disableScreenshot() async {
    await NoScreenshot.instance.screenshotOff();
  }

  static get disableSS => _disableScreenshot();
}
