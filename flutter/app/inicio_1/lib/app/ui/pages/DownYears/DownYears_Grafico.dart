// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inicio_1/app/controllers/DownYears_Controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class GraficosDownYears extends StatelessWidget {
  final dynamic valorX;
  final dynamic valorY;
  final String fileJsonData;
  final String titulo;
  final String labelY;
  final String labelX;

  const GraficosDownYears({
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
    return GetBuilder<DownYearsController>(
      initState: (_) {},
      builder: (_) {
        List<SalesDownYear> sales1 = [];

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
                    height: '51%',
                    alignment: ChartAlignment.near),
                primaryYAxis: NumericAxis(
                    maximum: valorY + 50.0, //  +6
                    minimum: valorY - 50.0, //  -7
                    title: AxisTitle(
                        text: labelY,
                        textStyle: const TextStyle(color: Colors.black))),
                primaryXAxis: NumericAxis(
                    maximum: valorX + 5.0,
                    minimum: valorX - 5.0,
                    title: AxisTitle(
                        text: labelX,
                        textStyle: const TextStyle(color: Colors.black))),
                series: [
                  LineSeries(
                    name: '+2 DE',
                    color: Colors.orange[900],
                    dataSource: sales1,
                    xValueMapper: (SalesDownYear details, _) => details.years,
                    yValueMapper: (SalesDownYear details, _) => details.sd_de_2,
                  ),
                  LineSeries(
                      name: '+1 DE',
                      color: Colors.yellow[600],
                      dataSource: sales1,
                      xValueMapper: (SalesDownYear details, _) => details.years,
                      yValueMapper: (SalesDownYear details, _) =>
                          details.sd_de_1),
                  LineSeries(
                    name: 'Median',
                    color: Colors.greenAccent[400],
                    dataSource: sales1,
                    xValueMapper: (SalesDownYear details, _) => details.years,
                    yValueMapper: (SalesDownYear details, _) => details.median,
                  ),
                  LineSeries(
                      name: '-1 DE',
                      color: Colors.yellow[600],
                      dataSource: sales1,
                      xValueMapper: (SalesDownYear details, _) => details.years,
                      yValueMapper: (SalesDownYear details, _) =>
                          details.sd_iz_1),
                  LineSeries(
                      name: '-2 DE',
                      color: Colors.orange[600],
                      dataSource: sales1,
                      xValueMapper: (SalesDownYear details, _) => details.years,
                      yValueMapper: (SalesDownYear details, _) =>
                          details.sd_iz_2),
                  pointGrafico(sales1)
                ],
              );
            });
      },
    );
  }

  BubbleSeries<SalesDownYear, double> pointGrafico(List<SalesDownYear> sales1) {
    return BubbleSeries(
        name: 'Valor',
        color: Colors.black,
        dataSource: sales1,
        maximumRadius: 1.5,
        minimumRadius: 1.5,
        xValueMapper: (SalesDownYear details, _) => valorX,
        yValueMapper: (SalesDownYear details, _) => valorY);
  }

  Future getDataJson({fileJson, variable}) async {
    // ignore: non_constant_identifier_names
    final GetData = await rootBundle.loadString(fileJson);
    final jsonResponse = json.decode(GetData);

    for (Map<String, dynamic> i in jsonResponse) {
      variable.add(SalesDownYear.fromJson(i));
    }
    return variable = variable;
  }
}
