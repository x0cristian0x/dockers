// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inicio_1/app/controllers/OMS_Controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class GraficoEspecialOMS extends StatelessWidget {
  final dynamic valorX;
  final dynamic valorY;
  final String fileJsonData;
  final String titulo;
  final String labelY;
  final String labelX;
  final int tablaEdad;

  late final int rangoMin;
  late final int rangoMax;

  // ignore: prefer_const_constructors_in_immutables
  GraficoEspecialOMS(
      {super.key,
      required this.valorX,
      required this.valorY,
      required this.titulo,
      required this.labelX,
      required this.labelY,
      required this.fileJsonData,
      required this.tablaEdad});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    late ZoomPanBehavior _zoomPanBehavior;
    return GetBuilder<OMSController>(
      initState: (_) {},
      builder: (_) {
        List<SalesDetailsEspecial> salesEspecial = [];

        return FutureBuilder(
            future: getDataJson(
              fileJson: fileJsonData,
              variable: salesEspecial,
              rangoEspecial: tablaEdad,
            ),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              _zoomPanBehavior = ZoomPanBehavior(
                enablePinching: true,
                enableDoubleTapZooming: true,
                enableSelectionZooming: true,
                selectionRectBorderColor: Colors.red,
                selectionRectBorderWidth: 2,
                selectionRectColor: Colors.grey,
                enablePanning: true,
              );

              return SfCartesianChart(
                zoomPanBehavior: _zoomPanBehavior,
                title: ChartTitle(
                    text: titulo,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                legend: Legend(
                    isVisible: true,
                    title: LegendTitle(
                        text: 'Desv Estandar',
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.bold)),
                    itemPadding: 1,
                    height: '60%',
                    alignment: ChartAlignment.near),
                primaryYAxis: NumericAxis(
                    maximum: valorY + 50, //  +6
                    minimum: valorY - 50, //  -7
                    title: AxisTitle(
                        text: labelY,
                        textStyle: const TextStyle(color: Colors.black))),
                primaryXAxis: NumericAxis(
                    maximum: valorX + 10,
                    minimum: valorX - 10,
                    title: AxisTitle(
                        text: labelX,
                        textStyle: const TextStyle(color: Colors.black))),
                series: [
                  LineSeries(
                    name: '+3 DE',
                    color: Colors.red[900],
                    dataSource: salesEspecial,
                    xValueMapper: (SalesDetailsEspecial details, _) =>
                        details.cm,
                    yValueMapper: (SalesDetailsEspecial details, _) =>
                        details.sd_de_3,
                  ),
                  LineSeries(
                    name: '+2 DE',
                    color: Colors.orange[600],
                    dataSource: salesEspecial,
                    xValueMapper: (SalesDetailsEspecial details, _) =>
                        details.cm,
                    yValueMapper: (SalesDetailsEspecial details, _) =>
                        details.sd_de_2,
                  ),
                  LineSeries(
                    name: '+1 DE',
                    color: Colors.yellow[600],
                    dataSource: salesEspecial,
                    xValueMapper: (SalesDetailsEspecial details, _) =>
                        details.cm,
                    yValueMapper: (SalesDetailsEspecial details, _) =>
                        details.sd_de_1,
                  ),
                  LineSeries(
                    name: 'Median',
                    color: Colors.greenAccent[400],
                    dataSource: salesEspecial,
                    xValueMapper: (SalesDetailsEspecial details, _) =>
                        details.cm,
                    yValueMapper: (SalesDetailsEspecial details, _) =>
                        details.median,
                  ),
                  LineSeries(
                      name: '-1 DE',
                      color: Colors.yellow[600],
                      dataSource: salesEspecial,
                      xValueMapper: (SalesDetailsEspecial details, _) =>
                          details.cm,
                      yValueMapper: (SalesDetailsEspecial details, _) =>
                          details.sd_iz_1),
                  LineSeries(
                      name: '-2 DE',
                      color: Colors.orange[600],
                      dataSource: salesEspecial,
                      xValueMapper: (SalesDetailsEspecial details, _) =>
                          details.cm,
                      yValueMapper: (SalesDetailsEspecial details, _) =>
                          details.sd_iz_2),
                  LineSeries(
                    name: '-3 DE',
                    color: Colors.red[900],
                    dataSource: salesEspecial,
                    xValueMapper: (SalesDetailsEspecial details, _) =>
                        details.cm,
                    yValueMapper: (SalesDetailsEspecial details, _) =>
                        details.sd_iz_3,
                  ),
                  pointGrafico(salesEspecial)
                ],
              );
            });
      },
    );
  }

  BubbleSeries<SalesDetailsEspecial, double> pointGrafico(
      List<SalesDetailsEspecial> salesEspecial) {
    return BubbleSeries(
        name: 'Valor',
        color: Colors.black,
        dataSource: salesEspecial,
        maximumRadius: 1.5,
        minimumRadius: 1.5,
        xValueMapper: (SalesDetailsEspecial details, _) => valorX,
        yValueMapper: (SalesDetailsEspecial details, _) => valorY);
  }

  Future getDataJson({fileJson, variable, rangoEspecial}) async {
    if (rangoEspecial <= 23) {
      rangoMin = 0;
      rangoMax = 651; //Parece q hay q aumentar +1 entonces 131
    } else if (rangoEspecial > 23 && rangoEspecial <= 60) {
      rangoMin = 652;
      rangoMax = 1203; // Lo mismo aqui +1, entonces 242
    } else {
      rangoMin = 0;
      rangoMax = 0;
    }
    // ignore: non_constant_identifier_names
    var GetData = await rootBundle.loadString(fileJson);
    final jsonResponse = json.decode(GetData).getRange(rangoMin, rangoMax);

    for (Map<String, dynamic> i in jsonResponse) {
      variable.add(SalesDetailsEspecial.fromJson(i));
    }
    return variable = variable;
  }
}
