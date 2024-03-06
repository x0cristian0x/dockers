<<<<<<< HEAD
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inicio_1/app/controllers/OMS_Controller.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_DataTable.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_DataTable_Aguda.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_DataTable_Especial.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_Grafico_Especial.dart';
import 'OMS_Formulario.dart';
import 'OMS_Grafico.dart';
import 'OMS_Radio.dart';
import 'dart:math' show pow;

class OMSPage extends GetView<OMSController> {
  const OMSPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Patron de Crecimiento de la OMS de 0 a 18 años')),
      body: GetBuilder<OMSController>(
        builder: (_) {
          List dataSex;

          List dataBoy = [
            "assets/data/OMS_data/Boy_Length_Age_Z_0_19.json",
            "assets/data/OMS_data/Boy_Weight_Age_Z_0_10.json",
            "assets/data/OMS_data/Boy_BMI_Age_Z_0_19.json",
            "assets/data/OMS_data/Boy_Head_Age_Z_0_5.json",
            "assets/data/OMS_data/Boy_Arm_Age_Z_3m_5y.json",
            "assets/data/OMS_data/Boy_Weight_Length_Z_0_5.json",
            "assets/data/OMS_data/Boy_data_waterlow.json",
          ];

          List dataGirl = [
            "assets/data/OMS_data/Girl_Length_Age_Z_0_19.json",
            "assets/data/OMS_data/Girl_Weight_Age_Z_0_10.json",
            "assets/data/OMS_data/Girl_BMI_Age_Z_0_19.json",
            "assets/data/OMS_data/Girl_Head_Age_Z_0_5.json",
            "assets/data/OMS_data/Girl_Arm_Age_Z_3m_5y.json",
            "assets/data/OMS_data/Girl_Weight_Length_Z_0_5.json",
            "assets/data/OMS_data/Girl_data_waterlow.json",
          ];

          controller.sexo.value == 1 ? dataSex = dataBoy : dataSex = dataGirl;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioOMS(),
                  const OMSRadio(),
                  ButtonEnviar(update: () => _.actualizarOMS()),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: double.parse(controller.estatura.text),
                    fileJsonData: dataSex[0],
                    rangoMax: 227, // Num de meses - 1
                    labelX: 'Meses', labelY: 'Longitud/Estatura (cm)',
                    titulo: 'Longitud/Estatura - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[0],
                      interpretacion: double.parse(controller.estatura.text)),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: (double.parse(controller.peso.text)),
                    fileJsonData: dataSex[1],
                    rangoMax: 119,
                    labelX: 'Meses',
                    labelY: 'Peso (kg)',
                    titulo: 'Peso - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[1],
                      interpretacion: double.parse(controller.peso.text)),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: double.parse(((double.parse(controller.peso.text) /
                                pow(double.parse(controller.estatura.text) / 10,
                                    2)) *
                            100)
                        .toStringAsFixed(2)),
                    fileJsonData: dataSex[2],
                    rangoMax: 227,
                    labelX: 'Meses',
                    labelY: 'IMC (Estatura/Peso^2)',
                    titulo: 'IMC - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[2],
                      interpretacion: double.parse(((double.parse(
                                      controller.peso.text) /
                                  pow(
                                      double.parse(controller.estatura.text) /
                                          10,
                                      2)) *
                              100)
                          .toStringAsFixed(2))),
                  GraficoEspecialOMS(
                      valorX: double.parse(controller.estatura.text),
                      valorY: double.parse(controller.peso.text),
                      labelX: 'Longitud/Estatura (cm)',
                      labelY: 'Peso (kg)',
                      titulo: 'Peso - Longitud/Estatura',
                      fileJsonData: dataSex[5],
                      tablaEdad: (double.parse(controller.mes.text).round())),
                  OMSDataTableAguda(
                    fileJsonData: dataSex[5],
                    interpretacion: double.parse(controller.peso.text),
                    estatura: double.parse(controller.estatura.text),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  OMSDataTableEspecial(
                    fileJsonData: dataSex[6],
                  ),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: (double.parse(controller.head.text)),
                    fileJsonData: dataSex[3],
                    rangoMax: 59,
                    labelX: 'Meses',
                    labelY: 'Perímetro Cefálico (cm)',
                    titulo: 'Perímetro Cefálico - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[3],
                      interpretacion: double.parse(controller.head.text)),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: (double.parse(controller.arm.text)),
                    fileJsonData: dataSex[4],
                    rangoMax: 59,
                    labelX: 'Meses',
                    labelY: 'Perímetro braquial (mm)',
                    titulo: 'Perímetro braquial - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[4],
                      interpretacion: double.parse(controller.arm.text)),
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
=======
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inicio_1/app/controllers/OMS_Controller.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_DataTable.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_DataTable_Aguda.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_DataTable_Especial.dart';
import 'package:inicio_1/app/ui/pages/OMS/OMS_Grafico_Especial.dart';
import 'OMS_Formulario.dart';
import 'OMS_Grafico.dart';
import 'OMS_Radio.dart';
import 'dart:math' show pow;

class OMSPage extends GetView<OMSController> {
  const OMSPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Patron de Crecimiento de la OMS de 0 a 18 años')),
      body: GetBuilder<OMSController>(
        builder: (_) {
          List dataSex;

          List dataBoy = [
            "assets/data/OMS_data/Boy_Length_Age_Z_0_19.json",
            "assets/data/OMS_data/Boy_Weight_Age_Z_0_10.json",
            "assets/data/OMS_data/Boy_BMI_Age_Z_0_19.json",
            "assets/data/OMS_data/Boy_Head_Age_Z_0_5.json",
            "assets/data/OMS_data/Boy_Arm_Age_Z_3m_5y.json",
            "assets/data/OMS_data/Boy_Weight_Length_Z_0_5.json",
            "assets/data/OMS_data/Boy_data_waterlow.json",
          ];

          List dataGirl = [
            "assets/data/OMS_data/Girl_Length_Age_Z_0_19.json",
            "assets/data/OMS_data/Girl_Weight_Age_Z_0_10.json",
            "assets/data/OMS_data/Girl_BMI_Age_Z_0_19.json",
            "assets/data/OMS_data/Girl_Head_Age_Z_0_5.json",
            "assets/data/OMS_data/Girl_Arm_Age_Z_3m_5y.json",
            "assets/data/OMS_data/Girl_Weight_Length_Z_0_5.json",
            "assets/data/OMS_data/Girl_data_waterlow.json",
          ];

          controller.sexo.value == 1 ? dataSex = dataBoy : dataSex = dataGirl;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormularioOMS(),
                  const OMSRadio(),
                  ButtonEnviar(update: () => _.actualizarOMS()),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: double.parse(controller.estatura.text),
                    fileJsonData: dataSex[0],
                    rangoMax: 227, // Num de meses - 1
                    labelX: 'Meses', labelY: 'Longitud/Estatura (cm)',
                    titulo: 'Longitud/Estatura - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[0],
                      interpretacion: double.parse(controller.estatura.text)),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: (double.parse(controller.peso.text)),
                    fileJsonData: dataSex[1],
                    rangoMax: 119,
                    labelX: 'Meses',
                    labelY: 'Peso (kg)',
                    titulo: 'Peso - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[1],
                      interpretacion: double.parse(controller.peso.text)),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: double.parse(((double.parse(controller.peso.text) /
                                pow(double.parse(controller.estatura.text) / 10,
                                    2)) *
                            100)
                        .toStringAsFixed(2)),
                    fileJsonData: dataSex[2],
                    rangoMax: 227,
                    labelX: 'Meses',
                    labelY: 'IMC (Estatura/Peso^2)',
                    titulo: 'IMC - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[2],
                      interpretacion: double.parse(((double.parse(
                                      controller.peso.text) /
                                  pow(
                                      double.parse(controller.estatura.text) /
                                          10,
                                      2)) *
                              100)
                          .toStringAsFixed(2))),
                  GraficoEspecialOMS(
                      valorX: double.parse(controller.estatura.text),
                      valorY: double.parse(controller.peso.text),
                      labelX: 'Longitud/Estatura (cm)',
                      labelY: 'Peso (kg)',
                      titulo: 'Peso - Longitud/Estatura',
                      fileJsonData: dataSex[5],
                      tablaEdad: (double.parse(controller.mes.text).round())),
                  OMSDataTableAguda(
                    fileJsonData: dataSex[5],
                    interpretacion: double.parse(controller.peso.text),
                    estatura: double.parse(controller.estatura.text),
                  ),
                  const Divider(
                    height: 10,
                  ),
                  OMSDataTableEspecial(
                    fileJsonData: dataSex[6],
                  ),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: (double.parse(controller.head.text)),
                    fileJsonData: dataSex[3],
                    rangoMax: 59,
                    labelX: 'Meses',
                    labelY: 'Perímetro Cefálico (cm)',
                    titulo: 'Perímetro Cefálico - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[3],
                      interpretacion: double.parse(controller.head.text)),
                  GraficosOMS(
                    valorX: (double.parse(controller.mes.text)).round(),
                    valorY: (double.parse(controller.arm.text)),
                    fileJsonData: dataSex[4],
                    rangoMax: 59,
                    labelX: 'Meses',
                    labelY: 'Perímetro braquial (mm)',
                    titulo: 'Perímetro braquial - Edad',
                  ),
                  OMSDataTable(
                      fileJsonData: dataSex[4],
                      interpretacion: double.parse(controller.arm.text)),
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
>>>>>>> rama_3
