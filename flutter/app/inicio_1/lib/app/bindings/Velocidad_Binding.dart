// ignore_for_file: file_names

import 'package:get/get.dart';

import '../controllers/Velocidad_Controller.dart';

class VelocidadBiling implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VelocidadController>(() => VelocidadController());
  }
}
