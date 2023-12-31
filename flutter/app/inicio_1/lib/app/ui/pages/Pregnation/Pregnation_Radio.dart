// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/Pregnation_Controller.dart';

class PregnationRadio extends StatelessWidget {
  const PregnationRadio({
    Key? key,
  }) : super(key: key);

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
