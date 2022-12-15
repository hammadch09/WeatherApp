import 'dart:developer';
import 'package:WeatherApp/modules/weather/components/location_list/location_list_modal.dart';
import 'package:WeatherApp/modules/weather/weather_logic.dart';
import 'package:WeatherApp/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../s.dart';

class LocationListLogic extends GetxController {
  var formKey = GlobalKey<FormState>();

  var locationList = [];

  SharedPref sharedPref = SharedPref();
  final TextEditingController _latitudeFieldController =
      TextEditingController();
  final TextEditingController _longitudeFieldController =
      TextEditingController();

  TextEditingController latitudeFieldController() => _latitudeFieldController;
  TextEditingController longitudeFieldController() => _longitudeFieldController;

  @override
  Future<void> onInit() async {
    print('onInit');
    await updateList();
    super.onInit();
  }

  /// On Submit Form
  void onSubmit(context) async {
    if (formKey.currentState!.validate()) {
      log(_latitudeFieldController.text);
      log(_longitudeFieldController.text);

      // final coordinates =
      List<Placemark> placemarks = await placemarkFromCoordinates(double.parse(_latitudeFieldController.text), double.parse(_longitudeFieldController.text));

      var address = {
        'city': placemarks[0].locality.toString(),
        'country': placemarks[0].country.toString(),
        'latitude': double.parse(_latitudeFieldController.text).toDouble(),
        'longitude': double.parse(_longitudeFieldController.text).toDouble(),
      };

      var address1 = AddressModel(
          city: placemarks[0].locality.toString(),
          country: placemarks[0].country.toString(),
          latitude: double.parse(_latitudeFieldController.text).toDouble(),
          longitude: double.parse(_longitudeFieldController.text).toDouble(),
      );

      print('here 1');
      print(address1.city);


      if (sharedPref.read(S.locationListKey) != null) {
        locationList = await sharedPref.read(S.locationListKey);
      }
      locationList.add(address);
      sharedPref.save(S.locationListKey, locationList);

      Navigator.pop(context);
      update();
      // formKey.currentState?.reset();
    }
  }


  /// On Delete Location
  onDeleteLocation(locationObj, context) async {
    List<dynamic> allLocations = await sharedPref.read(S.locationListKey);
    allLocations.removeWhere((ele) => ele['latitude'] == locationObj['latitude']);
    await sharedPref.save(S.locationListKey, allLocations);
    locationList = allLocations;
    update();
    Navigator.of(context).pop();
  }

  /// Update location list
  updateList() async {
    locationList = await sharedPref.read(S.locationListKey);
    update();
  }
}
