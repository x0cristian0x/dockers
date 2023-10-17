// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/DownYears_Controller.dart';

class DownYearsRadio extends StatelessWidget {
  const DownYearsRadio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownYearsController>(
      init: DownYearsController(),
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
