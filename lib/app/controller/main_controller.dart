import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app_getx/app/models/five_days_weather_model.dart';
import 'package:weather_app_getx/utils/constant.dart';

import '../models/current_weather_model.dart';

class MainController extends GetxController {
  @override
  void onInit() async {
    await getUserLocation();
    weatherData = getWeather(latitude.value, longitude.value);
    hourlyWeather = hourlyWeatherData(latitude.value, longitude.value);
    super.onInit();
  }

  var isLoading = false.obs;
  dynamic hourlyWeather;
  dynamic weatherData;
  var longitude = 0.0.obs;
  var latitude = 0.0.obs;

  /// TODO: Current Weather Data Services
  getWeather(lat, long) async {
    isLoading.value = true;
    var currentWeatherLink =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric";
    var response = await http.get(Uri.parse(currentWeatherLink));
    if (response.statusCode == 200) {
      print(
          "============ Current Weather Data Is Loading........... ===========");
      var data = currentWeatherFromJson(response.body.toString());
      print("======${data.name.toString()}=======");
      print("========== Current Weather Is Recieved ============");
      isLoading.value = false;
      return data;
    } else {
      throw Exception(
          ">>>>>>>>>>> Current Weather Data is  not working >>>>>>>>>>>>");
    }
  }

  /// TODO: Hourly Weather Data Services
  hourlyWeatherData(lat, long) async {
    isLoading.value = true;
    var hourlyWeatherLink =
        "http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey";
    var res = await http.get(Uri.parse(hourlyWeatherLink));
    if (res.statusCode == 200) {
      print("====== Response of Hourly Weather Loading........... ======");
      var data = fiveDaysWeatherFromJson(res.body.toString());
      print("=========== Hourly Weather Data is Recieved ===========");
      isLoading.value = false;
      return data;
    } else {
      throw Exception(
          ">>>>>>>>>>>> Hourly Weather Data is not working >>>>>>>>>>>>");
    }
  }

  /// TODO: Geo Location Services
  getUserLocation() async {
    bool isLocationEnable;
    LocationPermission userPermission;
    isLocationEnable = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnable) {
      return Future.error(
          "============== Location is not Enabled ============");
    }

    userPermission = await Geolocator.checkPermission();
    if (userPermission == LocationPermission.deniedForever) {
      return Future.error(
          "============ User Location Denied For Forever ===========");
    } else if (userPermission == LocationPermission.denied) {
      userPermission = await Geolocator.requestPermission();
      if (userPermission == LocationPermission.denied) {
        return Future.error(
            "=========== Location Permission is Denied ==============");
      }
    }
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      longitude.value = value.longitude;
      latitude.value = value.latitude;
      print("------------$longitude-------------");
      print("------------$latitude--------------");
    });
  }
}
