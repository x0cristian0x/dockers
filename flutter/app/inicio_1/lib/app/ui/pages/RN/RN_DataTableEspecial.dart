// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_1/app/controllers/RN_Controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:convert';

class RNDataTableEspecial extends StatelessWidget {
  final String fileJsonData;
  const RNDataTableEspecial({
    super.key,
    required this.fileJsonData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RNController>(builder: (_) {
      return FutureBuilder(
        future: getProductDataSource(
            fileJson: fileJsonData,
            estatura: double.parse(_.estatura.text),
            peso: double.parse(_.peso.text),
            week: int.parse(double.parse(_.week.text).toStringAsFixed(0))),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? Container(
                  constraints: const BoxConstraints(maxHeight: 75),
                  child: SfDataGrid(
                    source: snapshot.data, columns: getColumns(),
                    columnWidthMode: ColumnWidthMode.lastColumnFill,
                    rowHeight: 20, // tamaño de las filas sobre la ALTURA,
                    headerRowHeight: 30, // tamaño del HEADER sobre la ALTURA
                  ),
                )
              : const Text(
                  'No hay datos suficientes para calcular segun la clasifacación de Waterlow');
          //const Center(
          //     child: CircularProgressIndicator(
          //       strokeWidth: 3,
          //     ),
          //   );
        },
      );
    });
  }

  Future<ProductDataGridSource> getProductDataSource(
      {fileJson, peso, estatura, week}) async {
    var productList = await generateProductList(fileJson: fileJson, week: week);
    return ProductDataGridSource(productList, estatura, peso, week);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'orderID',
          label: Container(
              color: const Color.fromRGBO(0, 150, 100, 1), //Color Cell TITULOS
              alignment: Alignment.centerLeft,
              child: const Text('Clasificación de Waterlow',
                  style: TextStyle(fontSize: 14, color: Colors.white)))),
    ];
  }

  Future<List<SalesRNWater>> generateProductList({fileJson, week}) async {
    var response = await rootBundle.loadString(fileJson);
    var decodedProducts = jsonDecode(response)
        .getRange(week, week + 1)
        .cast<Map<String, dynamic>>();
    List<SalesRNWater> productList = await decodedProducts
        .map<SalesRNWater>((json) => SalesRNWater.fromJson(json))
        .toList();
    return productList;
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList, estatura, peso, week) {
    buildDataGridRow(estatura, peso, week);
  }
  late List<DataGridRow> dataGridRows;
  late List<SalesRNWater> productList;
  late double estatura;
  late double peso;
  late int week;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: const Color.fromRGBO(221, 225, 221, 1),
        cells: [
          Text(
            row.getCells()[0].value.toString(),
            style: const TextStyle(fontSize: 12),
          ),
        ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow(estatura, peso, mes) {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      String interpretacion;
      double cronico = (estatura / dataGridRow.medianDC) * 100;
      double agudo = (peso / dataGridRow.medianDA) * 100;

      if (cronico > 90 && agudo < 80) {
        interpretacion = "Desnutrido agudo (emaciado)";
      } else if (cronico < 90 && agudo < 80) {
        interpretacion = "Desnutrido crónico agudizado (emaciado y acortado)";
      } else if (cronico < 90 && agudo > 80) {
        interpretacion = "Desnutrido crónico (acortado)";
      } else {
        interpretacion = "Normal";
      }
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'orderID', value: interpretacion),
      ]);
    }).toList(growable: false);
  }
}
