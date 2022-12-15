import 'package:flutter/material.dart';
import 'package:my_widgets/my_widgets.dart';
import '../../../../utils/utils.dart';
import 'current_model.dart';

class CurrentWeatherView extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeatherView({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // temprature area
        TemperatureAreaWidget(),

        // Sized Box
        const SizedBox(
          height: 20,
        ),

        // more details - winds peed, humidity, clouds
        CurrentWeatherMoreDetailsWidget(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget TemperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          'assets/weather/${weatherDataCurrent.current.weather![0].icon}.png',
          height: 80,
          width: 80,
        ),
        Container(
          height: 50,
          width: 1,
          color: Clr.dividerLine,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "${weatherDataCurrent.current.temp!.toInt()}°",
                style: const TextStyle(
                    color: Clr.textCotorBtack,
                    fontWeight: FontWeight.w600,
                    fontSize: 68),
              ),
              TextSpan(
                text: "${weatherDataCurrent.current.weather![0].description}°",
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              )
            ],
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget CurrentWeatherMoreDetailsWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Clr.cardC010r,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/windspeed.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Clr.cardC010r,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/clouds.png"),
            ),
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Clr.cardC010r,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset("assets/icons/humidity.png"),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherDataCurrent.current.windSpeed}km/h',
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherDataCurrent.current.clouds}%',
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
              width: 60,
              child: Text(
                '${weatherDataCurrent.current.humidity}%',
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )
      ],
    );
  }
}
