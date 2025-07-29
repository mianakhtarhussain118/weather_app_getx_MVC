import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx/utils/app_themes.dart';

import 'app/controller/theme_controller.dart';
import 'app/views/weather_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(
      ThemeController(),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App Getx Statemanagement",
      theme: CustomThemes.light_theme,
      darkTheme: CustomThemes.dark_theme,
      themeMode:
          themeController.isChange.value ? ThemeMode.dark : ThemeMode.light,
      home: WeatherApp(),
    );
  }
}
