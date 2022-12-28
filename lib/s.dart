
import 'package:WeatherApp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

void sErrorSnackBar(String message) {
  Get.snackbar('Error', message, backgroundColor: Colors.red, colorText: Colors.white);
}

void sSuccessSnackBar(String message) {
  Get.snackbar('Success', message, backgroundColor: Colors.green, colorText: Colors.white);
}
