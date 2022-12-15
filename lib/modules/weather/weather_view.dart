import 'package:WeatherApp/modules/weather/weather_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_widgets/widgets/dividers.dart';
import 'package:my_widgets/widgets/get_images.dart';
import 'package:my_widgets/widgets/loading.dart';
import 'package:my_widgets/widgets/txt.dart';

import '../../utils/utils.dart';
import 'components/comfort_level/comfort_level_view.dart';
import 'components/current/current_view.dart';
import 'components/daily/daily_view.dart';
import 'components/header/header_view.dart';
import 'components/hourly/hourly_view.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherLogic>(
        init: WeatherLogic(),
        builder: (weather) {
          return Scaffold(
            appBar: AppBar(
              title: const Txt(
                "Weather Forecast",
                textColor: Colors.white,
                fontSize: 23,
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: weather.onAddTap,
                    child: const Icon(
                      Icons.add,
                      size: 26.0,
                    ),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: weather.checkLoading() == true
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          GetImage(
                            imagePath: 'assets/icons/clouds.png',
                            width: 120,
                            height: 120,
                            isAssets: true,
                          ),
                          LoadingPro(valueColor: Colors.blue,)
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
                              CurrentWeatherView(
                                weatherDataCurrent: weather.weatherDataList[i]
                                    .getCurrentWeatherData(),
                              ),
                              const MyDivider(
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
                              const MyDivider(
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
