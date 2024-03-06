// ignore_for_file: file_names

import 'dart:math' show pow;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/Turner_Controller.dart';
import 'package:inicio_new/app/ui/pages/Turner/Turner_DataTable.dart';
import 'package:inicio_new/app/ui/pages/Turner/Turner_Formulario.dart';
import 'package:inicio_new/app/ui/pages/Turner/Turner_Grafico.dart';

class TurnerPage extends GetView<TurnerController> {
  const TurnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Patron de crecimiento del Sindrome de Turner de 3 a 18 años')),
      body: GetBuilder<TurnerController>(
        builder: (_) {
          List dataGirl = [
            "assets/data/Turner_data/Length_Turner_P_3_18.json",
            "assets/data/Turner_data/Weight_Turner_P_3_18.json",
            "assets/data/Turner_data/BMI_Turner_P_3_18.json",
          ];

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioTurner(),
                  const Divider(
                    height: 20,
                  ),
                  ButtonEnviar(update: () => _.actualizarTurner()),
                  GraficosTurner(
                    valorX: double.parse(controller.year.text).round(),
                    valorY: double.parse(controller.estatura.text),
                    fileJsonData: dataGirl[0],
                    labelX: 'Años',
                    labelY: 'Estatura (cm)',
                    titulo: 'Estatura - Edad',
                  ),
                  TurnerDataTable(
                      fileJsonData: dataGirl[0],
                      interpretacion: double.parse(controller.estatura.text)),
                  GraficosTurner(
                    valorX: double.parse(controller.year.text).round(),
                    valorY: (double.parse(controller.peso.text)),
                    fileJsonData: dataGirl[1],
                    labelX: 'Años',
                    labelY: 'Peso (kg)',
                    titulo: 'Peso - Edad',
                  ),
                  TurnerDataTable(
                      fileJsonData: dataGirl[1],
                      interpretacion: double.parse(controller.peso.text)),
                  GraficosTurner(
                    valorX: double.parse(controller.year.text).round(),
                    valorY: double.parse(((double.parse(controller.peso.text) /
                                pow(double.parse(controller.estatura.text) / 10,
                                    2)) *
                            100)
                        .toStringAsFixed(2)),
                    fileJsonData: dataGirl[2],
                    labelX: 'Años',
                    labelY: 'IMC (Estatura/Peso^2)',
                    titulo: 'IMC - Edad',
                  ),
                  TurnerDataTable(
                      fileJsonData: dataGirl[2],
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
