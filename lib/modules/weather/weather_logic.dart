import 'package:WeatherApp/modules/weather/components/static/permission.dart';
import 'package:WeatherApp/modules/weather/weather_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/weather_api_service.dart';
import '../../utils/shared_pref.dart';
import '../weather/weather_model.dart';
import 'components/static/location.dart';
import 'package:geocoding/geocoding.dart';


class WeatherLogic extends GetxController {
  // Create various variables
  var isLoading = true;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  static String locationListKey = 'location_list';
  var locationList = [];
  var weatherDataList = [];

  bool checkLoading() => isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  SharedPref sharedPref = SharedPref();

  WeatherData getWeatherData() {
    return weatherData.value;
  }

  @override
  Future<void> onInit() async {
    if (isLoading == true) {
      getLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getLocation() async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //return is service is not enabled
    if (!isServiceEnabled) {
      isLoading = false;
      print('Location is not enabled');
      return Get.off(const LocationStaticView());
    }

    // status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      isLoading = false;
      Get.off(const PermissionStaticView());
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // Request permission
      locationPermission = await Geolocator.requestPermission();
       isLoading = false;
       if(locationPermission == LocationPermission.denied) {
         Get.off(const PermissionStaticView());
         return Future.error("Location permission is not enabled");
       }
    }

    // getting the current position
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      // update our lat and long
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      List<Placemark> placemark = await placemarkFromCoordinates(value.latitude, value.longitude);
      if(prefs.getString(locationListKey) == null) {
        await sharedPref.save(locationListKey, [{'city': placemark[0].locality, 'country': placemark[0].country, 'latitude': value.latitude.toDouble(), 'longitude': value.longitude.toDouble()}]);
      }

      locationList = await sharedPref.read(locationListKey);
      print(locationList);

      for (var element in locationList) {
        await WeatherApiService().processData(element['latitude'], element['longitude'])
            .then((value) {
              weatherData.value = value!;
              weatherDataList.add(weatherData.value);
        });
      }

      // calling our weather api
      return WeatherApiService()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value!;
        isLoading = false;
        Get.off(const WeatherView());
        update();
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }

  onCheckLocation() async {
    bool isServiceEnabled;
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //return is service is not enabled
    if (!isServiceEnabled) {
      bool result = await Geolocator.openLocationSettings();
      print(result);
    } else {
      await getLocation();
      return Get.off(const PermissionStaticView());
    }
  }

}