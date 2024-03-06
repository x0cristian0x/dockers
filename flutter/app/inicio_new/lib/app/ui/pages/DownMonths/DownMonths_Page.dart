// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/DownMonths_Controller.dart';
import 'package:inicio_new/app/ui/pages/DownMonths/DownMonths_DataTable.dart';
import 'package:inicio_new/app/ui/pages/DownMonths/DownMonths_Formulario.dart';
import 'package:inicio_new/app/ui/pages/DownMonths/DownMonths_Grafico.dart';
import 'package:inicio_new/app/ui/pages/DownMonths/DownMonths_Radio.dart';

class DownMonthsPage extends GetView<DownMonthsController> {
  const DownMonthsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
              'Patron de Crecimiento del Sindrome de Down de 1 a 36 meses')),
      body: GetBuilder<DownMonthsController>(
        builder: (_) {
          List dataSex;
          List dataBoy = [
            "assets/data/DownMonths_data/Boy_Length_Syndrome_1_36.json",
            "assets/data/DownMonths_data/Boy_Weight_Syndrome_1_36.json",
            "assets/data/DownMonths_data/Boy_Head_Syndrome_1_36.json",
          ];
          List dataGirl = [
            "assets/data/DownMonths_data/Girl_Length_Syndrome_1_36.json",
            "assets/data/DownMonths_data/Girl_Weight_Syndrome_1_36.json",
            "assets/data/DownMonths_data/Girl_Head_Syndrome_1_36.json",
          ];
          controller.sexo.value == 1 ? dataSex = dataBoy : dataSex = dataGirl;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioDownMonths(),
                  const DownMonthsRadio(),
                  ButtonEnviar(update: () => _.actualizarDownMonths_1()),
                  GraficosDownMonths(
                    valorX: double.parse(controller.mes.text).round(),
                    valorY: double.parse(controller.estatura.text),
                    fileJsonData: dataSex[0],
                    labelX: 'Meses',
                    labelY: 'Longitud/Estatura (cm)',
                    titulo: 'Longitud/Estatura - Edad',
                  ),
                  DownMonthsDataTable(
                      fileJsonData: dataSex[0],
                      interpretacion: double.parse(controller.estatura.text)),
                  GraficosDownMonths(
                    valorX: double.parse(controller.mes.text).round(),
                    valorY: (double.parse(controller.peso.text)),
                    fileJsonData: dataSex[1],
                    labelX: 'Meses',
                    labelY: 'Peso (kg)',
                    titulo: 'Peso - Edad',
                  ),
                  DownMonthsDataTable(
                      fileJsonData: dataSex[1],
                      interpretacion: double.parse(controller.peso.text)),
                  GraficosDownMonths(
                    valorX: double.parse(controller.mes.text).round(),
                    valorY: (double.parse(controller.head.text)),
                    fileJsonData: dataSex[2],
                    labelX: 'Meses',
                    labelY: 'Perímetro Cefálico (cm)',
                    titulo: 'Perímetro Cefálico - Edad',
                  ),
                  DownMonthsDataTable(
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
