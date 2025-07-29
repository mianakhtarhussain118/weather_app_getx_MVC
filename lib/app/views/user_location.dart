import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/main_controller.dart';

class UserLocation extends StatelessWidget {
  UserLocation({super.key});
  final myController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(body: Obx(() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Longitude:  ${myController.longitude.toString()}\n",
              style: TextStyle(fontSize: 20, color: theme.primaryColor),
            ),
            Text(
              "Latitude:  ${myController.latitude.toString()}",
              style: TextStyle(fontSize: 20, color: theme.primaryColor),
            )
          ],
        ),
      );
    }));
  }
}
