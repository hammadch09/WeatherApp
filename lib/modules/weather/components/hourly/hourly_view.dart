import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../utils/utils.dart';
import 'hourly_model.dart';

class HourlyView extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  const HourlyView({super.key, required this.weatherDataHourly});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          alignment: Alignment.topCenter,
          child: const Text(
            'Today',
            style: TextStyle(fontSize: 16),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 160,
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 12
            ? 12
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Container(
            width: 90,
            margin: const EdgeInsets.only(left: 20, right: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0.5, 0),
                  blurRadius: 30,
                  spreadRadius: 1,
                  color: Clr.dividerLine.withAlpha(150),
                )
              ],
            ),
            child: HourlyDetail(
              temp: weatherDataHourly.hourly[index].temp!,
              timeStamp: weatherDataHourly.hourly[index].dt!,
              weatherIcon:
              weatherDataHourly.hourly[index].weather![0].icon!,
              index: index,
            ),
          );
        },
      ),
    );
  }
}

// hourly detail class
class HourlyDetail extends StatelessWidget {
  int temp;
  int timeStamp;
  String weatherIcon;
  int index;

  HourlyDetail({
    super.key,
    required this.timeStamp,
    required this.temp,
    required this.weatherIcon,
    required this.index,
  });

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: const TextStyle(
              color: Clr.textCotorBtack,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            'assets/weather/$weatherIcon.png',
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            "$temp°",
            style: const TextStyle(
              color: Clr.textCotorBtack,
            ),
          ),
        )
      ],
    );
  }
}
