import 'package:WeatherApp/modules/weather/components/location_list/location_list_view.dart';
import 'package:WeatherApp/modules/weather/weather_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import 'components/comfort_level/comfort_level_view.dart';
import 'components/current/current_view.dart';
import 'components/daily/daily_view.dart';
import 'components/header/header_view.dart';
import 'components/hourly/hourly_view.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  // call
  // final GlobalController globalController =
  // Get.put(GlobalController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherLogic>(
        init: WeatherLogic(),
        builder: (weather) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Weather Forecast"),
              actions: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(LocationListView());
                      },
                      child: const Icon(
                        Icons.add,
                        size: 26.0,
                      ),
                    )),
              ],
            ),
            body: SafeArea(
              child: weather.checkLoading() == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/clouds.png',
                            height: 200,
                            width: 200,
                          ),
                          const CircularProgressIndicator()
                        ],
                      ),
                    )
                  : PageView.builder(
                      itemCount: weather.weatherDataList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return Center(
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              HeaderView(
                                  city: weather.locationList[i]['city']
                                      .toString()),
                              // for our current temp ('current')
                              // CurrentWeatherView(
                              //   weatherDataCurrent: weather
                              //       .getWeatherData()
                              //       .getCurrentWeatherData(),
                              // ),
                              CurrentWeatherView(
                                weatherDataCurrent: weather.weatherDataList[i]
                                    .getCurrentWeatherData(),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // for our hourly temp ('hourly')
                              HourlyView(
                                weatherDataHourly: weather.weatherDataList[i]
                                    .getHourlyWeatherData(),
                              ),
                              DailyForecastView(
                                weatherDataDaily: weather.weatherDataList[i]
                                    .getDailyWeatherData(),
                              ),
                              Container(
                                height: 1,
                                color: Clr.dividerLine,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ComfortLevelView(
                                weatherDataCurrent: weather.weatherDataList[i]
                                    .getCurrentWeatherData(),
                              )
                            ],
                          ),
                        );
                      },
                    ),
            ),
          );
        });
  }
}
