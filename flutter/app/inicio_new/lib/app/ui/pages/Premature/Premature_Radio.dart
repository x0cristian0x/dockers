// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/Premature_Controller.dart';

class PrematureRadio extends StatelessWidget {
  const PrematureRadio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrematureController>(
      init: PrematureController(),
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