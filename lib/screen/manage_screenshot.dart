import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:manage_screenshot/helper/handle_screenshots.dart';
import 'package:manage_screenshot/screen/next_screen/next_screen.dart';
import 'package:manage_screenshot/constant/app_strings.dart';
import 'package:screen_protector/screen_protector.dart';

Logger log = Logger();

class ManageScreenshotScreen extends StatefulWidget {
  const ManageScreenshotScreen({super.key});

  @override
  State<ManageScreenshotScreen> createState() => _ScreenShotDeniedScreenState();
}

class _ScreenShotDeniedScreenState extends State<ManageScreenshotScreen>
    with WidgetsBindingObserver {
  // late final NoScreenshot _denyScreenshot;
  ValueNotifier<bool> ssAllowed = ValueNotifier(false);
  @override
  void initState() {
    super.initState();
    // _denyScreenshot = NoScreenshot.instance;
    // _denyScreenshot.screenshotOff();
    // HandleScreenshots.toggleScreenshot(disableSs: true);
    ScreenProtector.preventScreenshotOn();
  }

  // _enableScreenshot(context) {
  //   ToggleScreenshot.enableSS;
  //   ssAllowed.value = true;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       backgroundColor: Colors.lightGreen,
  //       duration: Duration(seconds: 1),
  //       content: Text(
  //         AppStrings.screenshotEnabled,
  //       ),
  //     ),
  //   );
  // }

  // _disableScreenshot(context) {
  //   ToggleScreenshot.disableSS;
  //   ssAllowed.value = false;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       backgroundColor: Colors.red,
  //       duration: Duration(seconds: 1),
  //       content: Text(
  //         AppStrings.screenshotDisabled,
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.appTitle),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NextScreen(),
            ),
          );
          // ToggleScreenshot.enableSS;
          ScreenProtector.preventScreenshotOff();
          // HandleScreenshots.toggleScreenshot(disableSs: false);
          ssAllowed.value = false;
        },
        child: const Icon(
          Icons.arrow_right_outlined,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: ssAllowed,
              builder: (context, value, child) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(110),
                    ),
                    border: Border.all(
                      width: 10,
                      color: ssAllowed.value ? Colors.green : Colors.red,
                    ),
                  ),
                  child: Image.network(
                    AppStrings.ssImageLink,
                    height: 200,
                    width: 200,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // HandleScreenshots.toggleScreenshot(disableSs: false);
                ssAllowed.value = true;
                ScreenProtector.preventScreenshotOff();
                ScreenProtector.protectDataLeakageOff();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 1),
                    content: Text(
                      AppStrings.screenshotEnabled,
                    ),
                  ),
                );
              },
              // _enableScreenshot(context),
              child: const Text(AppStrings.ssEnabelBtn),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // HandleScreenshots.toggleScreenshot(disableSs: true);
                ScreenProtector.preventScreenshotOn();
                ScreenProtector.protectDataLeakageOn();
                ssAllowed.value = false;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1),
                    content: Text(
                      AppStrings.screenshotDisabled,
                    ),
                  ),
                );
              },
              // _disableScreenshot(context),
              child: const Text(AppStrings.ssDisableBtn),
            ),
          ],
        ),
      ),
    );
  }
}
