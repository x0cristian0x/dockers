// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/OMS_Controller.dart';

class OMSBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OMSController>(() => OMSController());
  }
}
