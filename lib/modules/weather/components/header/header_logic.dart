import 'package:get/get.dart';
import 'package:intl/intl.dart';


class HeaderLogic extends GetxController {
  String date = DateFormat('yMMMMd').format(DateTime.now());
}