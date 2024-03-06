// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/RN_Controller.dart';

class RNBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RNController>(() => RNController());
  }
}
