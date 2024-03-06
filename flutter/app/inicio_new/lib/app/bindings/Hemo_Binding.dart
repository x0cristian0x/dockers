// ignore_for_file: file_names
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/Hemo_Controller.dart';

class HemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HemoController>(
      HemoController(),
    );
  }
}
