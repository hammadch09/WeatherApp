import 'dart:convert';
import 'dart:developer';
import 'package:WeatherApp/modules/weather/components/location_list/location_list_modal.dart';
import 'package:WeatherApp/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationListLogic extends GetxController {
  var formKey = GlobalKey<FormState>();
  static String locationListKey = 'location_list';

  var locationList = [];

  final TextEditingController _latitudeFieldController =
      TextEditingController();
  final TextEditingController _longitudeFieldController =
      TextEditingController();

  TextEditingController latitudeFieldController() => _latitudeFieldController;

  TextEditingController longitudeFieldController() => _longitudeFieldController;

  @override
  Future<void> onInit() async {
    SharedPref sharedPref = SharedPref();
    locationList = await sharedPref.read(locationListKey);
    super.onInit();
  }

  void onSubmit(context) async {
    final prefs = await SharedPreferences.getInstance();
    SharedPref sharedPref = SharedPref();
    if (formKey.currentState!.validate()) {
      log(_latitudeFieldController.text);
      log(_longitudeFieldController.text);

      // final coordinates =
      List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(_latitudeFieldController.text), double.parse(_longitudeFieldController.text));

      log('here');
      print(placemarks);

      var address = {
        'city': placemarks[0].locality.toString(),
        'country': placemarks[0].country.toString(),
        'latitude': double.parse(_latitudeFieldController.text).toDouble(),
        'longitude': double.parse(_longitudeFieldController.text).toDouble(),
      };

      if(prefs.getString(locationListKey) != null) {
        locationList = await sharedPref.read(locationListKey);
      }
      locationList.add(address);
      print(locationList);
      sharedPref.save(locationListKey, locationList);

      Navigator.pop(context);
      update();
      // formKey.currentState?.reset();
    }
  }
}
