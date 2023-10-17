// ignore_for_file: file_names

import 'dart:math' show pow;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/DownYears_Controller.dart';
import 'package:inicio_1/app/ui/pages/DownYears/DownYears_DataTable.dart';
import 'package:inicio_1/app/ui/pages/DownYears/DownYears_Formulario.dart';
import 'package:inicio_1/app/ui/pages/DownYears/DownYears_Grafico.dart';
import 'package:inicio_1/app/ui/pages/DownYears/DownYears_Radio.dart';

class DownYearsPage extends GetView<DownYearsController> {
  const DownYearsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Patron de Crecimiento del Sindrome de Down de 2 a 20 años')),
      body: GetBuilder<DownYearsController>(
        builder: (_) {
          List dataSex;
          List dataBoy = [
            "assets/data/DownYears_data/Boy_Length_Syndrome_2_20.json",
            "assets/data/DownYears_data/Boy_Weight_Syndrome_2_20.json",
            "assets/data/DownYears_data/Boy_BMI_Syndrome_2_20.json",
            "assets/data/DownYears_data/Boy_Head_Syndrome_2_20.json",
          ];
          List dataGirl = [
            "assets/data/DownYears_data/Girl_Length_Syndrome_2_20.json",
            "assets/data/DownYears_data/Girl_Weight_Syndrome_2_20.json",
            "assets/data/DownYears_data/Girl_BMI_Syndrome_2_20.json",
            "assets/data/DownYears_data/Girl_Head_Syndrome_2_20.json",
          ];
          controller.sexo.value == 1 ? dataSex = dataBoy : dataSex = dataGirl;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioDownYears(),
                  const DownYearsRadio(),
                  ButtonEnviar(update: () => _.actualizarDownYears_1()),
                  GraficosDownYears(
                    valorX:
                        (double.parse(controller.year.text)).roundToDouble(),
                    valorY: double.parse(controller.estatura.text),
                    fileJsonData: dataSex[0],
                    labelX: 'Años',
                    labelY: 'Longitud/Estatura (cm)',
                    titulo: 'Longitud/Estatura - Edad',
                  ),
                  DownYearsDataTable(
                      fileJsonData: dataSex[0],
                      interpretacion: double.parse(controller.estatura.text)),
                  GraficosDownYears(
                    valorX:
                        (double.parse(controller.year.text)).roundToDouble(),
                    valorY: (double.parse(controller.peso.text)),
                    fileJsonData: dataSex[1],
                    labelX: 'Años',
                    labelY: 'Peso (kg)',
                    titulo: 'Peso - Edad',
                  ),
                  DownYearsDataTable(
                      fileJsonData: dataSex[1],
                      interpretacion: double.parse(controller.peso.text)),
                  GraficosDownYears(
                    valorX:
                        (double.parse(controller.year.text)).roundToDouble(),
                    valorY: double.parse(((double.parse(controller.peso.text) /
                                pow(double.parse(controller.estatura.text) / 10,
                                    2)) *
                            100)
                        .toStringAsFixed(2)),
                    fileJsonData: dataSex[2],
                    labelX: 'Años',
                    labelY: 'IMC (Estatura/Peso^2)',
                    titulo: 'IMC - Edad',
                  ),
                  DownYearsDataTable(
                      fileJsonData: dataSex[2],
                      interpretacion: double.parse(((double.parse(
                                      controller.peso.text) /
                                  pow(
                                      double.parse(controller.estatura.text) /
                                          10,
                                      2)) *
                              100)
                          .toStringAsFixed(2))),
                  GraficosDownYears(
                    valorX:
                        (double.parse(controller.year.text)).roundToDouble(),
                    valorY: (double.parse(controller.head.text)),
                    fileJsonData: dataSex[3],
                    labelX: 'Años',
                    labelY: 'Perímetro Cefálico (cm)',
                    titulo: 'Perímetro Cefálico - Edad',
                  ),
                  DownYearsDataTable(
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
