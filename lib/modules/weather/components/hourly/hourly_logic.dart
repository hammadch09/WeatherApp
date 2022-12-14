import 'package:get/get.dart';

import '../../weather_logic.dart';

class HourlyLogic extends GetxController {

  RxInt currentIndex = 0.obs;

  onCardIndex(int index) {
    print('index $index');
    currentIndex.value = index;
  }

}