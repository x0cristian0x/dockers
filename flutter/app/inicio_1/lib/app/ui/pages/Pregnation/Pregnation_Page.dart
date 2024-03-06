// ignore_for_file: file_names

import 'dart:math' show pow;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/Pregnation_Controller.dart';
import 'package:inicio_1/app/ui/pages/Pregnation/Pregnation_Formulario.dart';
import 'package:inicio_1/app/ui/pages/Pregnation/Pregnation_Grafico.dart';
import 'package:inicio_1/app/ui/pages/Pregnation/Pregnation_Radio.dart';

import 'Pregnation_DataTable.dart';

class PregnationPage extends GetView<PregnationController> {
  const PregnationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Estado Nutricional de la Embarazada mayor a 10 semanas')),
      body: GetBuilder<PregnationController>(
        builder: (_) {
          List dataAutor;
          List dataAtalah = [
            "assets/data/Pregnation_data/IMC_week_pregnation_atalah.json",
          ];
          List dataChile = [
            "assets/data/Pregnation_data/IMC_week_pregnation_chile.json",
          ];
          controller.autor.value == 1
              ? dataAutor = dataAtalah
              : dataAutor = dataChile;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioPregnation(),
                  const PregnationRadio(),
                  ButtonEnviar(update: () => _.actualizarPregnation_1()),
                  GraficosPregnation(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: double.parse(((double.parse(controller.peso.text) /
                                pow(double.parse(controller.estatura.text) / 10,
                                    2)) *
                            100)
                        .toStringAsFixed(2)),
                    fileJsonData: dataAutor[0],
                    labelX: 'Semanas',
                    labelY: 'IMC (Estatura/Peso^2)',
                    titulo: 'IMC - Semanas',
                  ),
                  PregnationDataTable(
                      fileJsonData: dataAutor[0],
                      interpretacion: double.parse(((double.parse(
                                      controller.peso.text) /
                                  pow(
                                      double.parse(controller.estatura.text) /
                                          10,
                                      2)) *
                              100)
                          .toStringAsFixed(2))),
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
  const ButtonEnviar({super.key, required this.update});

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
