// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inicio_new/app/controllers/Velocidad_Controller.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class GrafVelocidadWeight extends StatelessWidget {
  final int valorX;
  final dynamic valorY;
  final String fileJsonData;
  final String titulo;
  final String labelY;
  final String labelX;
  final int rango;

  const GrafVelocidadWeight(
      {super.key,
      required this.valorX,
      required this.valorY,
      required this.titulo,
      required this.labelX,
      required this.labelY,
      required this.fileJsonData,
      required this.rango});

  @override
  Widget build(BuildContext context) {
    late ZoomPanBehavior zoomPanBehavior;
    return GetBuilder<VelocidadController>(
      initState: (_) {},
      builder: (_) {
        List<SalesVelocidad> sales1 = [];

        return FutureBuilder(
            future: getDataJson(
                fileJson: fileJsonData, variable: sales1, rango: rango),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              zoomPanBehavior = ZoomPanBehavior(
                enablePinching: true,
                enableDoubleTapZooming: true,
                enableSelectionZooming: true,
                selectionRectBorderColor: Colors.red,
                selectionRectBorderWidth: 2,
                selectionRectColor: Colors.grey,
                enablePanning: true,
              );
              return SfCartesianChart(
                zoomPanBehavior: zoomPanBehavior,
                title: ChartTitle(
                    text: titulo,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                legend: Legend(
                    isVisible: true,
                    title: LegendTitle(
                        text: 'Desv Estandar',
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    itemPadding: 1,
                    height: '52%',
                    alignment: ChartAlignment.near),
                primaryYAxis: NumericAxis(
                    maximum: valorY + 3.0, //  +6
                    minimum: valorY - 3.0, //  -7
                    title: AxisTitle(
                        text: labelY,
                        textStyle: const TextStyle(color: Colors.black))),
                primaryXAxis: NumericAxis(
                    maximum: valorX + 2,
                    minimum: valorX - 2,
                    title: AxisTitle(
                        text: labelX,
                        textStyle: const TextStyle(color: Colors.black))),
                series: [
                  LineSeries(
                    name: '+3 SD',
                    color: Colors.red[600],
                    dataSource: sales1,
                    xValueMapper: (SalesVelocidad details, _) => details.edad,
                    yValueMapper: (SalesVelocidad details, _) => details.de_3,
                  ),
                  LineSeries(
                    name: '+2 SD',
                    color: Colors.orange[600],
                    dataSource: sales1,
                    xValueMapper: (SalesVelocidad details, _) => details.edad,
                    yValueMapper: (SalesVelocidad details, _) => details.de_2,
                  ),
                  LineSeries(
                      name: '+1 SD',
                      color: Colors.yellow[600],
                      dataSource: sales1,
                      xValueMapper: (SalesVelocidad details, _) => details.edad,
                      yValueMapper: (SalesVelocidad details, _) =>
                          details.de_1),
                  LineSeries(
                    name: 'Median',
                    color: Colors.greenAccent[400],
                    dataSource: sales1,
                    xValueMapper: (SalesVelocidad details, _) => details.edad,
                    yValueMapper: (SalesVelocidad details, _) => details.median,
                  ),
                  LineSeries(
                      name: '-1 SD',
                      color: Colors.yellow[600],
                      dataSource: sales1,
                      xValueMapper: (SalesVelocidad details, _) => details.edad,
                      yValueMapper: (SalesVelocidad details, _) =>
                          details.iz_1),
                  LineSeries(
                      name: '-2 SD',
                      color: Colors.orange[600],
                      dataSource: sales1,
                      xValueMapper: (SalesVelocidad details, _) => details.edad,
                      yValueMapper: (SalesVelocidad details, _) =>
                          details.iz_2),
                  LineSeries(
                    name: '-3 SD',
                    color: Colors.red[600],
                    dataSource: sales1,
                    xValueMapper: (SalesVelocidad details, _) => details.edad,
                    yValueMapper: (SalesVelocidad details, _) => details.iz_3,
                  ),
                  pointGrafico(sales1)
                ],
              );
            });
      },
    );
  }

  BubbleSeries<SalesVelocidad, int> pointGrafico(List<SalesVelocidad> sales1) {
    return BubbleSeries(
        name: 'Valor',
        color: Colors.black,
        dataSource: sales1,
        maximumRadius: 1.5,
        minimumRadius: 1.5,
        xValueMapper: (SalesVelocidad details, _) => valorX,
        yValueMapper: (SalesVelocidad details, _) => valorY);
  }

  Future getDataJson({fileJson, variable, rango}) async {
    late int rangoInicio;
    late int rangoFinal;

    if (rango == 1) {
      rangoInicio = 0;
      rangoFinal = 12;
    } else if (rango == 2) {
      rangoInicio = 13;
      rangoFinal = 35;
    } else if (rango == 3) {
      rangoInicio = 36;
      rangoFinal = 57;
    } else if (rango == 4) {
      rangoInicio = 58;
      rangoFinal = 78;
    } else if (rango == 6) {
      rangoInicio = 79;
      rangoFinal = 97;
    } else {
      rangoInicio = 0;
      rangoFinal = 0;
    }

    // ignore: non_constant_identifier_names
    var GetData = await rootBundle.loadString(fileJson);

    final jsonResponse = json.decode(GetData).getRange(rangoInicio, rangoFinal);

    for (Map<String, dynamic> i in jsonResponse) {
      variable.add(SalesVelocidad.fromJson(i));
    }
    return variable = variable;
  }
}
