import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyLogic extends GetxController {

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 100);
    final x = DateFormat('EEE').format(time);
    return x;
  }

}