import 'dart:developer';
import 'package:WeatherApp/modules/weather/components/location_list/location_list_modal.dart';
import 'package:WeatherApp/modules/weather/components/location_list/location_list_view.dart';
import 'package:WeatherApp/modules/weather/components/static/loader.dart';
import 'package:WeatherApp/modules/weather/weather_logic.dart';
import 'package:WeatherApp/services/weather_api_service.dart';
import 'package:WeatherApp/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

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

  WeatherLogic weatherLogic = Get.find();
  
  @override
  Future<void> onInit() async {

    // var weatherLogic = Get.find<WeatherLogic>();
    await updateList();
    super.onInit();
  }

  /// On Submit Form
  void onSubmit(context) async {
    try {
      if (formKey.currentState!.validate()) {
        log(_latitudeFieldController.text);
        log(_longitudeFieldController.text);

        Get.to(() => const LoaderView());

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

        await WeatherApiService().processData(
            double.parse(_latitudeFieldController.text).toDouble(),
            double.parse(_longitudeFieldController.text).toDouble()
        ).then((value) {
          weatherLogic.weatherData.value = value!;
          weatherLogic.weatherDataList.add(weatherLogic.weatherData.value);
          print('weatherDataListCheck in => ${weatherLogic.weatherDataList}');
          print('weatherDataListCheck weatherData in => ${weatherLogic.weatherData.value}');
          // weatherLogic.weathe
          print('weatherDataListCheck out => ${weatherLogic.weatherDataList}');
        });

        Get.off(() => LocationListView());

        sSuccessSnackBar('Location Added!');
        update();
        // formKey.currentState?.reset();
      }
    } catch (e) {
      Get.off(() => LocationListView());
      return sErrorSnackBar('Invalid Coordinates');
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
    sSuccessSnackBar('Location Removed!');
  }

  /// Update location list
  updateList() async {
    locationList = await sharedPref.read(S.locationListKey);
    update();
  }
}
