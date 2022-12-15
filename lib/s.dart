
import 'package:WeatherApp/utils/utils.dart';

class S {
  static const apikey = "179454a4510b10d79e818051f341e531";
  static const locationListKey = 'location_list';
}

String sApiUrl(lat, long) {
  // String url;
  String url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&appid=${ApiKey.apiKey}&units=metric&exclude=minutely";
  return url;
}