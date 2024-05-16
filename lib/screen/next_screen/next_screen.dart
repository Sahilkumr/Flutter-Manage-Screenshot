import 'package:flutter/material.dart';
import 'package:manage_screenshot/constant/app_strings.dart';
import 'package:manage_screenshot/helper/handle_screenshots.dart';

class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
            onTap: () {
              HandleScreenshots.toggleScreenshot(disableSs: true);
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                color: Colors.amber,
                child: const Center(
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.nextScreenAppBarTitle,
        ),
      ),
      body: const Center(
        child: Text(
          AppStrings.nextScreenWelcomeText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
