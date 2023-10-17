// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inicio_1/app/controllers/Turner_Controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class GraficosTurner extends StatelessWidget {
  final int valorX;
  final dynamic valorY;
  final String fileJsonData;
  final String titulo;
  final String labelY;
  final String labelX;

  const GraficosTurner({
    Key? key,
    required this.valorX,
    required this.valorY,
    required this.titulo,
    required this.labelX,
    required this.labelY,
    required this.fileJsonData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    late ZoomPanBehavior _zoomPanBehavior;

    return GetBuilder<TurnerController>(
      initState: (_) {},
      builder: (_) {
        List<SalesTurner> sales1 = [];

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
                        text: 'Percentiles',
                        textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
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
                    maximum: valorX + 2,
                    minimum: valorX - 2,
                    title: AxisTitle(
                        text: labelX,
                        textStyle: const TextStyle(color: Colors.black))),
                series: [
                  LineSeries(
                    name: 'P-3',
                    color: Colors.red[900],
                    dataSource: sales1,
                    xValueMapper: (SalesTurner details, _) => details.years,
                    yValueMapper: (SalesTurner details, _) => details.p_3,
                  ),
                  LineSeries(
                    name: 'P-10',
                    color: Colors.orange[900],
                    dataSource: sales1,
                    xValueMapper: (SalesTurner details, _) => details.years,
                    yValueMapper: (SalesTurner details, _) => details.p_10,
                  ),
                  LineSeries(
                      name: 'P-25',
                      color: Colors.yellow[600],
                      dataSource: sales1,
                      xValueMapper: (SalesTurner details, _) => details.years,
                      yValueMapper: (SalesTurner details, _) => details.p_25),
                  LineSeries(
                    name: 'Median',
                    color: Colors.greenAccent[400],
                    dataSource: sales1,
                    xValueMapper: (SalesTurner details, _) => details.years,
                    yValueMapper: (SalesTurner details, _) => details.median,
                  ),
                  LineSeries(
                      name: 'P-75',
                      color: Colors.yellow[600],
                      dataSource: sales1,
                      xValueMapper: (SalesTurner details, _) => details.years,
                      yValueMapper: (SalesTurner details, _) => details.p_75),
                  LineSeries(
                      name: 'P-90',
                      color: Colors.orange[600],
                      dataSource: sales1,
                      xValueMapper: (SalesTurner details, _) => details.years,
                      yValueMapper: (SalesTurner details, _) => details.p_90),
                  LineSeries(
                    name: 'P-97',
                    color: Colors.red[900],
                    dataSource: sales1,
                    xValueMapper: (SalesTurner details, _) => details.years,
                    yValueMapper: (SalesTurner details, _) => details.p_97,
                  ),
                  pointGrafico(sales1)
                ],
              );
            });
      },
    );
  }

  BubbleSeries<SalesTurner, int> pointGrafico(List<SalesTurner> sales1) {
    return BubbleSeries(
        name: 'Valor',
        color: Colors.black,
        dataSource: sales1,
        maximumRadius: 1.5,
        minimumRadius: 1.5,
        xValueMapper: (SalesTurner details, _) => valorX,
        yValueMapper: (SalesTurner details, _) => valorY);
  }

  Future getDataJson({fileJson, variable}) async {
    // ignore: non_constant_identifier_names
    var GetData = await rootBundle.loadString(fileJson);
    final jsonResponse = json.decode(GetData);

    for (Map<String, dynamic> i in jsonResponse) {
      variable.add(SalesTurner.fromJson(i));
    }
    return variable = variable;
  }
}
