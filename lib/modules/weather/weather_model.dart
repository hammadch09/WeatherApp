import '../weather/components/current/current_model.dart';
import '../weather/components/daily/daily_model.dart';
import '../weather/components/hourly/hourly_model.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;

  WeatherData([this.current, this.hourly, this.daily]);

  // function to fetch these values
  WeatherDataCurrent getCurrentWeatherData() => current!;
  WeatherDataHourly getHourlyWeatherData() => hourly!;
  WeatherDataDaily getDailyWeatherData() => daily!;
}