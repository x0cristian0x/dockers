// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_new/app/controllers/Turner_Controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TurnerDataTable extends StatelessWidget {
  final String fileJsonData;
  final double interpretacion;
  const TurnerDataTable(
      {super.key, required this.fileJsonData, required this.interpretacion});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TurnerController>(
      builder: (_) {
        return FutureBuilder(
          future: getProductDataSource(
              fileJson: fileJsonData,
              rango:
                  int.parse(double.parse(_.year.text).toStringAsFixed(0)) - 3,
              interpretacion: interpretacion),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasData
                ? Container(
                    constraints: const BoxConstraints(maxHeight: 80), // BOX CO
                    child: SfDataGrid(
                      source: snapshot.data,
                      columns: getColumns(),
                      columnWidthMode: ColumnWidthMode.fill,
                      rowHeight: 50, // tamaño de las filas sobre la ALTURA,
                      headerRowHeight: 30, // tamaño del HEADER sobre la ALTURA
                    ),
                  )
                : const Text('El valor de los años debe estar entre 3 y 18');
          },
        );
      },
    );
  }

  Future<ProductDataGridSource> getProductDataSource(
      {fileJson, rango, interpretacion}) async {
    if (rango > 16) {
      rango = 0;
    }

    var productList = await generateProductList(
        fileJson: fileJson, rango: rango, interpretacion: interpretacion);
    return ProductDataGridSource(productList, interpretacion);
  }

// Obtener Colum INICIO
  List<GridColumn> getColumns() {
    return <GridColumn>[
      repetirColumn(
          columnName: 'interpretacion', nombreColumn: 'Interpretación'),
      repetirColumn(columnName: 'years', nombreColumn: 'Años'),
      repetirColumn(columnName: 'p_3', nombreColumn: 'P-3'),
      repetirColumn(columnName: 'p_10', nombreColumn: 'P-10'),
      repetirColumn(columnName: 'p_25', nombreColumn: 'P-25'),
      repetirColumn(columnName: 'median', nombreColumn: 'Mediana'),
      repetirColumn(columnName: 'p_75', nombreColumn: 'P-75'),
      repetirColumn(columnName: 'p_90', nombreColumn: 'P-90'),
      repetirColumn(columnName: 'p_97', nombreColumn: 'P-97'),
    ];
  }

  GridColumn repetirColumn({columnName, nombreColumn}) {
    return GridColumn(
        columnName: columnName,
        label: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            color: const Color.fromRGBO(0, 150, 100, 1), //Color Cell TITULOS
            alignment: Alignment.centerLeft,
            child: Text(nombreColumn,
                style: const TextStyle(fontSize: 11, color: Colors.white),
                overflow: TextOverflow.clip,
                softWrap: true)));
  }
// Obtener Colum FIN

// Leer Data INICIO
  Future<List<SalesTurner>> generateProductList(
      {fileJson, rango, interpretacion}) async {
    var response = await rootBundle.loadString(fileJson);
    var decodedProducts = jsonDecode(response)
        .getRange(rango, rango + 1)
        .cast<Map<String, dynamic>>();
    List<SalesTurner> productList = await decodedProducts
        .map<SalesTurner>((json) => SalesTurner.fromJson(json))
        .toList();

    return productList;
  }

// Leer Data FIN
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList, this.interpretacion) {
    buildDataGridRow(interpretacion);
  }
  late List<DataGridRow> dataGridRows;
  late List<SalesTurner> productList;
  late double interpretacion;
// Colocar Valor Cell INICIO
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        color: const Color.fromRGBO(221, 225, 221, 1),
        cells: [
          //Color Cell DATOS
          repetirCell(row, numCell: 0),
          repetirCell(row, numCell: 1),
          repetirCell(row, numCell: 2),
          repetirCell(row, numCell: 3),
          repetirCell(row, numCell: 4),
          repetirCell(row, numCell: 5),
          repetirCell(row, numCell: 6),
          repetirCell(row, numCell: 7),
          repetirCell(row, numCell: 8),
        ]);
  }

  Container repetirCell(DataGridRow row, {numCell}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(0),
      child: Text(row.getCells()[numCell].value.toString(),
          style: const TextStyle(fontSize: 10)),
    );
  }
// Colocar Valor Cell FIN

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow(interpretacion) {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      late String significado;
      if (interpretacion <= dataGridRow.p_3) {
        significado = 'Es menor o igual al P-3';
      } else if (interpretacion > dataGridRow.p_3 &&
          interpretacion <= dataGridRow.p_10) {
        significado = 'Es menor o igual al P-10';
      } else if (interpretacion > dataGridRow.p_10 &&
          interpretacion <= dataGridRow.p_25) {
        significado = 'Es menor o igual al P-25';
      } else if (interpretacion > dataGridRow.p_25 &&
          interpretacion < dataGridRow.p_75) {
        significado = 'Esta alrededor de la Mediana';
      } else if (interpretacion >= dataGridRow.p_75 &&
          interpretacion < dataGridRow.p_90) {
        significado = 'Es mayor o igual al P-75';
      } else if (interpretacion >= dataGridRow.p_90 &&
          interpretacion < dataGridRow.p_97) {
        significado = 'Es mayor o igual al P-90';
      } else {
        significado = 'Es mayor o igual al P-97';
      }

      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'interpretacion', value: significado),
        DataGridCell<int>(columnName: 'years', value: dataGridRow.years),
        DataGridCell<double>(columnName: 'p_3', value: dataGridRow.p_3),
        DataGridCell<double>(columnName: 'p_10', value: dataGridRow.p_10),
        DataGridCell<double>(columnName: 'p_25', value: dataGridRow.p_25),
        DataGridCell<double>(columnName: 'median', value: dataGridRow.median),
        DataGridCell<double>(columnName: 'p_75', value: dataGridRow.p_75),
        DataGridCell<double>(columnName: 'p_90', value: dataGridRow.p_90),
        DataGridCell<double>(columnName: 'p_97', value: dataGridRow.p_97),
      ]);
    }).toList(growable: false);
  }
}
