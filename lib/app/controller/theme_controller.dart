import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isChange = false.obs;

  void toggleTheme() {
    isChange.value = !isChange.value;
    Get.changeThemeMode(isChange.value ? ThemeMode.dark : ThemeMode.light);
  }
}
