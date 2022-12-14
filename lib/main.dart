import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'modules/weather/weather_view.dart';

void main() {
  runApp(
      const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: WeatherView(),
      title: 'My Weather App',
      debugShowCheckedModeBanner: false,
    );
  }
}
