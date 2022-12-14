import 'dart:convert';
import '../modules/weather/weather_model.dart';
import '../modules/weather/components/current/current_model.dart';
import '../modules/weather/components/daily/daily_model.dart';
import '../modules/weather/components/hourly/hourly_model.dart';
import 'package:http/http.dart' as http;
import '../s.dart';

class WeatherApiService {
  WeatherData? weatherData;

  // processing the data from response -> to json
  Future<WeatherData?> processData(lat, lon) async {
    var response = await http.get(Uri.parse(sApiUrl(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString),
      WeatherDataHourly.fromJson(jsonString),
      WeatherDataDaily.fromJson(jsonString),
    );
    return weatherData;
  }
}
