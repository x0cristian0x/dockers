<<<<<<< HEAD
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/OMS_Controller.dart';

class OMSRadio extends StatelessWidget {
  const OMSRadio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OMSController>(
      init: OMSController(),
      initState: (_) {},
      builder: (_) {
        return Row(children: [
          const Text('Sexo:'),
          Obx(
            () => Radio(
              value: 1,
              groupValue: _.sexo.value,
              onChanged: (int? value) {
                _.sexo.value = value!;
              },
            ),
          ),
          const Text('Hombre'),
          //
          Obx(() => Radio(
              value: 2,
              groupValue: _.sexo.value,
              onChanged: (int? value) {
                _.sexo.value = value!;
              })),
          const Text('Mujer'),
        ]);
      },
    );
  }
}
=======
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/OMS_Controller.dart';

class OMSRadio extends StatelessWidget {
  const OMSRadio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OMSController>(
      init: OMSController(),
      initState: (_) {},
      builder: (_) {
        return Row(children: [
          const Text('Sexo:'),
          Obx(
            () => Radio(
              value: 1,
              groupValue: _.sexo.value,
              onChanged: (int? value) {
                _.sexo.value = value!;
              },
            ),
          ),
          const Text('Hombre'),
          //
          Obx(() => Radio(
              value: 2,
              groupValue: _.sexo.value,
              onChanged: (int? value) {
                _.sexo.value = value!;
              })),
          const Text('Mujer'),
        ]);
      },
    );
  }
}
>>>>>>> rama_3
