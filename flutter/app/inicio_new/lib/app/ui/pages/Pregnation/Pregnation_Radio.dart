// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/Pregnation_Controller.dart';

class PregnationRadio extends StatelessWidget {
  const PregnationRadio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PregnationController>(
      init: PregnationController(),
      initState: (_) {},
      builder: (_) {
        return Row(children: [
          const Text('Tabla:'),
          Obx(
            () => Radio(
              value: 1,
              groupValue: _.autor.value,
              onChanged: (int? value) {
                _.autor.value = value!;
              },
            ),
          ),
          const Text('Atalah 1997'),
          //
          Obx(() => Radio(
              value: 2,
              groupValue: _.autor.value,
              onChanged: (int? value) {
                _.autor.value = value!;
              })),
          const Text('Atalah 2005'),
        ]);
      },
    );
  }
}
