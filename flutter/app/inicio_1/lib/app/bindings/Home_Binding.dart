// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/Home_Controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put inyecta en memoria y lo guarda, y lo llama en cualquier parte del codigo
    // Get.lazyPut crea una nueva instancia por cada llamada, no carga tanto en memoria BEST
    //Get.put(HomeController);
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
