// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inicio_1/app/controllers/Pregnation_Controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class GraficosPregnation extends StatelessWidget {
  final dynamic valorX;
  final dynamic valorY;
  final String fileJsonData;
  final String titulo;
  final String labelY;
  final String labelX;

  const GraficosPregnation({
    super.key,
    required this.valorX,
    required this.valorY,
    required this.titulo,
    required this.labelX,
    required this.labelY,
    required this.fileJsonData,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    late ZoomPanBehavior _zoomPanBehavior;
    return GetBuilder<PregnationController>(
      initState: (_) {},
      builder: (_) {
        List<SalesPregnation> sales1 = [];

        return FutureBuilder(
            future: getDataJson(fileJson: fileJsonData, variable: sales1),
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
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    itemPadding: 1,
                    height: '40%',
                    alignment: ChartAlignment.near),
                primaryYAxis: NumericAxis(
                    maximum: valorY + 10, //  +6
                    minimum: valorY - 10, //  -7
                    title: AxisTitle(
                        text: labelY,
                        textStyle: const TextStyle(color: Colors.black))),
                primaryXAxis: NumericAxis(
                    title: AxisTitle(
                        text: labelX,
                        textStyle: const TextStyle(color: Colors.black))),
                series: [
                  AreaSeries(
                    name: 'Obesidad',
                    color: Colors.red[700],
                    dataSource: sales1,
                    xValueMapper: (SalesPregnation details, _) => details.weeks,
                    yValueMapper: (SalesPregnation details, _) =>
                        details.maximo,
                  ),
                  AreaSeries(
                    name: 'Sobrepeso',
                    color: Colors.yellow[900],
                    dataSource: sales1,
                    xValueMapper: (SalesPregnation details, _) => details.weeks,
                    yValueMapper: (SalesPregnation details, _) =>
                        details.obesidad,
                  ),
                  AreaSeries(
                    name: 'Normal',
                    color: Colors.greenAccent[400],
                    dataSource: sales1,
                    xValueMapper: (SalesPregnation details, _) => details.weeks,
                    yValueMapper: (SalesPregnation details, _) =>
                        details.sobrepeso,
                  ),
                  AreaSeries(
                      name: 'Bajo Peso',
                      color: Colors.redAccent[100],
                      dataSource: sales1,
                      xValueMapper: (SalesPregnation details, _) =>
                          details.weeks,
                      yValueMapper: (SalesPregnation details, _) =>
                          details.bajopeso),
                  pointGrafico(sales1)
                ],
              );
            });
      },
    );
  }

  BubbleSeries<SalesPregnation, int> pointGrafico(
      List<SalesPregnation> sales1) {
    return BubbleSeries(
        name: 'Valor',
        color: Colors.black,
        dataSource: sales1,
        maximumRadius: 1.5,
        minimumRadius: 1.5,
        xValueMapper: (SalesPregnation details, _) => valorX,
        yValueMapper: (SalesPregnation details, _) => valorY);
  }

  Future getDataJson({fileJson, variable}) async {
    // ignore: non_constant_identifier_names
    var GetData = await rootBundle.loadString(fileJson);
    final jsonResponse = json.decode(GetData);

    for (Map<String, dynamic> i in jsonResponse) {
      variable.add(SalesPregnation.fromJson(i));
    }
    return variable = variable;
  }
}
