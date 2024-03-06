// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inicio_1/app/controllers/OMS_Controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class GraficosOMS extends StatelessWidget {
  final dynamic valorX;
  final dynamic valorY;
  final String fileJsonData;
  final int rangoMax;
  final String titulo;
  final String labelY;
  final String labelX;

  const GraficosOMS(
      {super.key,
      required this.valorX,
      required this.valorY,
      required this.titulo,
      required this.labelX,
      required this.labelY,
      required this.fileJsonData,
      required this.rangoMax});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    late ZoomPanBehavior _zoomPanBehavior;
    return GetBuilder<OMSController>(
      initState: (_) {},
      builder: (_) {
        List<SalesDetails> sales1 = [];

        return FutureBuilder(
            future: getDataJson(
                fileJson: fileJsonData,
                variable: sales1,
                rango: valorX,
                rangoMax: rangoMax),
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
                    // distancia figura(-) y el legend
                    alignment: ChartAlignment.near),
                primaryYAxis: NumericAxis(
                    maximum: valorY + 40, //  +6
                    minimum: valorY - 40, //  -7
                    title: AxisTitle(
                        text: labelY,
                        textStyle: const TextStyle(color: Colors.black))),
                primaryXAxis: NumericAxis(
                    title: AxisTitle(
                        text: labelX,
                        textStyle: const TextStyle(color: Colors.black))),
                series: [
                  LineSeries(
                    name: '+3 DE',
                    color: Colors.red[900],
                    dataSource: sales1,
                    xValueMapper: (SalesDetails details, _) => details.months,
                    yValueMapper: (SalesDetails details, _) => details.sd_de_3,
                  ),
                  LineSeries(
                    name: '+2 DE',
                    color: Colors.orange[600],
                    dataSource: sales1,
                    xValueMapper: (SalesDetails details, _) => details.months,
                    yValueMapper: (SalesDetails details, _) => details.sd_de_2,
                  ),
                  LineSeries(
                    name: '+1 DE',
                    color: Colors.yellow[600],
                    dataSource: sales1,
                    xValueMapper: (SalesDetails details, _) => details.months,
                    yValueMapper: (SalesDetails details, _) => details.sd_de_1,
                  ),
                  LineSeries(
                      name: 'Mediana',
                      color: Colors.greenAccent[400],
                      dataSource: sales1,
                      xValueMapper: (SalesDetails details, _) => details.months,
                      yValueMapper: (SalesDetails details, _) =>
                          details.median),
                  LineSeries(
                      name: '-1 DE',
                      color: Colors.yellow[600],
                      dataSource: sales1,
                      xValueMapper: (SalesDetails details, _) => details.months,
                      yValueMapper: (SalesDetails details, _) =>
                          details.sd_iz_1),
                  LineSeries(
                      name: '-2 DE',
                      color: Colors.orange[600],
                      dataSource: sales1,
                      xValueMapper: (SalesDetails details, _) => details.months,
                      yValueMapper: (SalesDetails details, _) =>
                          details.sd_iz_2),
                  LineSeries(
                    name: '-3 DE',
                    color: Colors.red[900],
                    dataSource: sales1,
                    xValueMapper: (SalesDetails details, _) => details.months,
                    yValueMapper: (SalesDetails details, _) => details.sd_iz_3,
                  ),
                  pointGrafico(sales1)
                ],
              );
            });
      },
    );
  }

  BubbleSeries<SalesDetails, int> pointGrafico(List<SalesDetails> sales1) {
    return BubbleSeries(
        name: 'Valor',
        color: Colors.black,
        dataSource: sales1,
        maximumRadius: 2,
        minimumRadius: 2,
        xValueMapper: (SalesDetails details, _) => valorX,
        yValueMapper: (SalesDetails details, _) => valorY);
  }

  Future getDataJson({fileJson, variable, rango, rangoMax}) async {
    if (rango <= 2) {
      rango = 2;
    } else if (rango >= rangoMax) {
      rango = rango - 2;
    }
    var getData = await rootBundle.loadString(fileJson);
    final jsonResponse = json.decode(getData).getRange(rango - 2, rango + 3);

    for (Map<String, dynamic> i in jsonResponse) {
      variable.add(SalesDetails.fromJson(i));
    }
    return variable = variable;
  }
}
