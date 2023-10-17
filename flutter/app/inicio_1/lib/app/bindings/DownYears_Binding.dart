// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/DownYears_Controller.dart';

class DownYearsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownYearsController>(() => DownYearsController());
  }
}
