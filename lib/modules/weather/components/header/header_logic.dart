import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../weather_logic.dart';


class HeaderLogic extends GetxController {

  RxString city = ''.obs;
  String date = DateFormat('yMMMMd').format(DateTime.now());


  final WeatherLogic weatherLogic =
  Get.put(WeatherLogic());

  @override
  void onInit() {
    getAddress(weatherLogic.getLatitude().value,
        weatherLogic.getLongitude().value);
    super.onInit();
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    city.value = place.locality!;
  }

}