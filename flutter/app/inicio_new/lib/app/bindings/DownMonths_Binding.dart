// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/DownMonths_Controller.dart';

class DownMonthsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownMonthsController>(() => DownMonthsController());
  }
}
