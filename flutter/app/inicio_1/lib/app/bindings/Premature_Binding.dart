// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/Premature_Controller.dart';

class PrematureBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrematureController>(() => PrematureController());
  }
}
