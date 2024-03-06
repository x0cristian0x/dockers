// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/Premature_Controller.dart';
import 'package:inicio_new/app/ui/pages/Premature/Premature_DataTable.dart';
import 'package:inicio_new/app/ui/pages/Premature/Premature_Formulario.dart';
import 'package:inicio_new/app/ui/pages/Premature/Premature_Grafico.dart';
import 'package:inicio_new/app/ui/pages/Premature/Premature_Radio.dart';

class PrematurePage extends GetView<PrematureController> {
  const PrematurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Patron de Crecimiento del Prematuro de Fenton para 23 a 50 semanas')),
      body: GetBuilder<PrematureController>(
        builder: (_) {
          List dataSex;
          List dataBoy = [
            "assets/data/Premature_data/Boy_Length_Premature.json",
            "assets/data/Premature_data/Boy_Weight_Premature.json",
            "assets/data/Premature_data/Boy_Head_Premature.json",
          ];
          List dataGirl = [
            "assets/data/Premature_data/Girl_Length_Premature.json",
            "assets/data/Premature_data/Girl_Weight_Premature.json",
            "assets/data/Premature_data/Girl_Head_Premature.json",
          ];
          controller.sexo.value == 1 ? dataSex = dataBoy : dataSex = dataGirl;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioPremature(),
                  const PrematureRadio(),
                  ButtonEnviar(update: () => _.actualizarPremature_1()),
                  GraficosPremature(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: double.parse(controller.estatura.text),
                    fileJsonData: dataSex[0],
                    labelX: 'Semanas',
                    labelY: 'Longitud (cm)',
                    titulo: 'Longitud - Edad',
                  ),
                  PrematureDataTable(
                      fileJsonData: dataSex[0],
                      interpretacion: double.parse(controller.estatura.text)),
                  GraficosPremature(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: (double.parse(controller.peso.text)),
                    fileJsonData: dataSex[1],
                    labelX: 'Semanas',
                    labelY: 'Peso (kg)',
                    titulo: 'Peso - Edad',
                  ),
                  PrematureDataTable(
                      fileJsonData: dataSex[1],
                      interpretacion: double.parse(controller.peso.text)),
                  GraficosPremature(
                    valorX: (double.parse(controller.week.text)).round(),
                    valorY: (double.parse(controller.head.text)),
                    fileJsonData: dataSex[2],
                    labelX: 'Semanas',
                    labelY: 'Perímetro Cefálico (cm)',
                    titulo: 'Perímetro Cefálico - Edad',
                  ),
                  PrematureDataTable(
                      fileJsonData: dataSex[2],
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
