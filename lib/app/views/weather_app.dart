import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_getx/app/controller/main_controller.dart';
import 'package:weather_app_getx/app/controller/theme_controller.dart';
import 'package:weather_app_getx/app/models/current_weather_model.dart';
import 'package:weather_app_getx/app/models/five_days_weather_model.dart';
import 'package:weather_app_getx/app/views/user_location.dart';
import 'package:weather_app_getx/utils/app_colors.dart';

class WeatherApp extends StatelessWidget {
  WeatherApp({super.key});

  final date = DateFormat("yMMMMd").format(
    DateTime.now(),
  );

  final time = DateFormat("jm").format(
    DateTime.now(),
  );

  final themeController = Get.find<ThemeController>();
  final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontSize: 18,
                  color: theme.primaryColor,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 17,
                  color: theme.primaryColor,
                ),
              ),
            ],
          ),
          actions: [
            Obx(() {
              return IconButton(
                  onPressed: () {
                    themeController.toggleTheme();
                  },
                  icon: Icon(
                    themeController.isChange.value
                        ? Icons.light_mode_outlined
                        : Icons.nightlight_outlined,
                    color: theme.iconTheme.color,
                  ));
            }),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
              future: controller.weatherData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  CurrentWeather dataTwo = snapshot.data as CurrentWeather;
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataTwo.name.toUpperCase(),
                          style: TextStyle(
                              color: theme.primaryColor,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 32),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/weather/${dataTwo.weather[0].icon}.png",
                              height: 50,
                              width: 50,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: dataTwo.main.temp.toString(),
                                style: TextStyle(
                                    color: theme.primaryColor,
                                    fontFamily: "Poppins",
                                    fontSize: 45),
                              ),
                              TextSpan(
                                text: dataTwo.weather[0].main,
                                style: TextStyle(
                                    color: theme.primaryColor,
                                    fontFamily: "Poppins",
                                    letterSpacing: 3,
                                    fontSize: 14),
                              )
                            ]))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              label: Text(
                                dataTwo.main.tempMin.toString(),
                                style: TextStyle(color: theme.primaryColor),
                              ),
                              icon: Icon(
                                Icons.expand_less_rounded,
                                color: theme.iconTheme.color,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              label: Text(
                                dataTwo.main.tempMax.toString(),
                                style: TextStyle(color: theme.primaryColor),
                              ),
                              icon: Icon(
                                Icons.expand_more_rounded,
                                color: theme.iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(3, (index) {
                            List iconList = [
                              "assets/images/clouds.png",
                              "assets/images/humidity.png",
                              "assets/images/windspeed.png",
                            ];
                            List values = [
                              (dataTwo.clouds.all.toString()),
                              (dataTwo.main.humidity.toString()),
                              (dataTwo.wind.speed.toString())
                            ];
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: theme.cardColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    iconList[index],
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  values[index],
                                  style: TextStyle(color: theme.primaryColor),
                                )
                              ],
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: theme.primaryColor,
                        ),
                        const SizedBox(height: 10),
                        FutureBuilder(
                            future: controller.hourlyWeather,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                FiveDaysWeather hourlyData =
                                    snapshot.data as FiveDaysWeather;
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                      itemCount: hourlyData.list.length > 6
                                          ? 6
                                          : hourlyData.list.length,
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var time = DateFormat.jm().format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                hourlyData.list[index].dt
                                                        .toInt() *
                                                    1000));
                                        return Container(
                                          padding: const EdgeInsets.all(15),
                                          margin:
                                              const EdgeInsets.only(right: 12),
                                          decoration: BoxDecoration(
                                            color: theme.cardColor,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                time.toString(),
                                                style: TextStyle(
                                                  color: AppColors.c4,
                                                ),
                                              ),
                                              Image.asset(
                                                "assets/weather/${hourlyData.list[index].weather[0].icon}.png",
                                                height: 80,
                                              ),
                                              Text(
                                                hourlyData.list[index].main.temp
                                                    .toString(),
                                                style: TextStyle(
                                                    color: AppColors.c4),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                );
                              } else {
                                return const Center(
                                  child: Text("No Data Available"),
                                );
                              }
                            }),
                        const SizedBox(height: 50),
                        Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            height: 55,
                            minWidth: MediaQuery.of(context).size.width * 0.7,
                            color: theme.cardColor,
                            onPressed: () async {
                              await controller.getUserLocation();
                              Get.to(UserLocation());
                            },
                            child: Text(
                              "Grab Location",
                              style:
                                  TextStyle(fontSize: 18, color: AppColors.c4),
                            ),
                          ),
                        ),
                      ]);
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ));
                }
              }),
        ));
  }
}
