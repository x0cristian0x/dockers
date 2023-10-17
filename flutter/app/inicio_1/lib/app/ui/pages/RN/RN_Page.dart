// ignore_for_file: file_names

import 'dart:math' show pow;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/RN_Controller.dart';
import 'package:inicio_1/app/ui/pages/RN/RN_DataTable.dart';
import 'package:inicio_1/app/ui/pages/RN/RN_DataTableEspecial.dart';
import 'package:inicio_1/app/ui/pages/RN/RN_Formulario.dart';
import 'package:inicio_1/app/ui/pages/RN/RN_Grafico.dart';
import 'package:inicio_1/app/ui/pages/RN/RN_Radio.dart';

class RNPage extends GetView<RNController> {
  const RNPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Patron de crecimiento del Recien Nacido de 0 a 13 semanas')),
      body: GetBuilder<RNController>(
        builder: (_) {
          List dataSex;
          List dataBoy = [
            "assets/data/RN_data/Boy_Length_Age_Z_weeks.json",
            "assets/data/RN_data/Boy_Weight_Age_Z_weeks.json",
            "assets/data/RN_data/Boy_BMI_Age_Z_weeks.json",
            "assets/data/RN_data/Boy_Head_Age_Z_weeks.json",
            "assets/data/RN_data/Boy_data_Waterlow_weeks.json",
          ];
          List dataGirl = [
            "assets/data/RN_data/Girl_Length_Age_Z_weeks.json",
            "assets/data/RN_data/Girl_Weight_Age_Z_weeks.json",
            "assets/data/RN_data/Girl_BMI_Age_Z_weeks.json",
            "assets/data/RN_data/Girl_Head_Age_Z_weeks.json",
            "assets/data/RN_data/Girl_data_Waterlow_weeks.json",
          ];
          controller.sexo.value == 1 ? dataSex = dataBoy : dataSex = dataGirl;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioRN(),
                  const RNRadio(),
                  ButtonEnviar(update: () => _.actualizarRN()),
                  const Divider(
                    height: 15,
                  ),
                  RNDataTableEspecial(fileJsonData: dataSex[4]),
                  GraficosRN(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: double.parse(controller.estatura.text),
                    fileJsonData: dataSex[0],
                    labelX: 'Semanas',
                    labelY: 'Longitud (cm)',
                    titulo: 'Longitud - Edad',
                  ),
                  RNDataTable(
                      fileJsonData: dataSex[0],
                      interpretacion: double.parse(controller.estatura.text)),
                  GraficosRN(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: (double.parse(controller.peso.text)),
                    fileJsonData: dataSex[1],
                    labelX: 'Semanas',
                    labelY: 'Peso (kg)',
                    titulo: 'Peso - Edad',
                  ),
                  RNDataTable(
                      fileJsonData: dataSex[1],
                      interpretacion: double.parse(controller.peso.text)),
                  GraficosRN(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: double.parse(((double.parse(controller.peso.text) /
                                pow(double.parse(controller.estatura.text) / 10,
                                    2)) *
                            100)
                        .toStringAsFixed(2)),
                    fileJsonData: dataSex[2],
                    labelX: 'Semanas',
                    labelY: 'IMC (Longitud/Peso^2)',
                    titulo: 'IMC - Edad',
                  ),
                  RNDataTable(
                      fileJsonData: dataSex[2],
                      interpretacion: double.parse(((double.parse(
                                      controller.peso.text) /
                                  pow(
                                      double.parse(controller.estatura.text) /
                                          10,
                                      2)) *
                              100)
                          .toStringAsFixed(2))),
                  GraficosRN(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: (double.parse(controller.head.text)),
                    fileJsonData: dataSex[3],
                    labelX: 'Semanas',
                    labelY: 'Perímetro Cefálico (cm)',
                    titulo: 'Perímetro Cefálico - Edad',
                  ),
                  RNDataTable(
                      fileJsonData: dataSex[3],
                      interpretacion: double.parse(controller.head.text)),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class ButtonEnviar extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final update;
  const ButtonEnviar({Key? key, required this.update}) : super(key: key);

  @override
  State<ButtonEnviar> createState() => _ButtonEnviarState();
}

class _ButtonEnviarState extends State<ButtonEnviar> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(1)),
          side: BorderSide(
            color: Colors.black,
          )),
      backgroundColor: const Color.fromRGBO(73, 81, 114, 1),
      tooltip: 'Enviar',
      hoverColor: Colors.black,
      onPressed: widget.update,
      child: const Text('Enviar'),
    );
  }
}
