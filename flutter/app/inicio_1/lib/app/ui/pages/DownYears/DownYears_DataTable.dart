<<<<<<< HEAD
// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_1/app/controllers/DownYears_Controller.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DownYearsDataTable extends StatelessWidget {
  final String fileJsonData;
  final double interpretacion;
  const DownYearsDataTable(
      {Key? key, required this.fileJsonData, required this.interpretacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownYearsController>(
      builder: (_) {
        return FutureBuilder(
          future: getProductDataSource(
              fileJson: fileJsonData,
              rango:
                  int.parse((double.parse(_.year.text) - 2).toStringAsFixed(0)),
              interpretacion: interpretacion),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasData
                ? Container(
                    constraints: const BoxConstraints(maxHeight: 120), // BOX CO
                    child: SfDataGrid(
                      source: snapshot.data,
                      columns: getColumns(),
                      columnWidthMode: ColumnWidthMode.fill,
                      rowHeight: 50, // tamaño de las filas sobre la ALTURA,
                      headerRowHeight: 30, // tamaño del HEADER sobre la ALTURA
                    ),
                  )
                : const Text(
                    'El valor de los años de nacimiento de estar entre 2 y 20');
          },
        );
      },
    );
  }

  Future<ProductDataGridSource> getProductDataSource(
      {fileJson, rango, interpretacion}) async {
    var productList = await generateProductList(
        fileJson: fileJson, rango: rango, interpretacion: interpretacion);
    return ProductDataGridSource(productList, interpretacion);
  }

// Obtener Colum INICIO
  List<GridColumn> getColumns() {
    return <GridColumn>[
      repetirColumn(
          columnName: 'interpretacion', nombreColumn: 'Interpretación'),
      repetirColumn(columnName: 'sex', nombreColumn: 'Sexo'),
      repetirColumn(columnName: 'years', nombreColumn: 'Años'),
      repetirColumn(columnName: 'sd_iz_2', nombreColumn: '-2 DE'),
      repetirColumn(columnName: 'sd_iz_1', nombreColumn: '-1 DE'),
      repetirColumn(columnName: 'median', nombreColumn: 'Mediana'),
      repetirColumn(columnName: 'sd_de_1', nombreColumn: '+1 DE'),
      repetirColumn(columnName: 'sd_de_2', nombreColumn: '+2 DE'),
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
  Future<List<SalesDownYear>> generateProductList(
      {fileJson, rango, interpretacion}) async {
    //int dos=2;
    if (rango > 0 && rango < 18) {
      rango = rango + rango;
    } else if (rango == 18) {
      rango = 35;
    } else {
      rango = rango + rango;
    }

    var response = await rootBundle.loadString(fileJson);
    var decodedProducts = jsonDecode(response)
        .getRange(rango, rango + 2)
        .cast<Map<String, dynamic>>();
    List<SalesDownYear> productList = await decodedProducts
        .map<SalesDownYear>((json) => SalesDownYear.fromJson(json))
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
  late List<SalesDownYear> productList;
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
      if (interpretacion <= dataGridRow.sd_iz_2) {
        significado = 'Es menor o igual a -2 DE';
      } else if (interpretacion > dataGridRow.sd_iz_2 &&
          interpretacion <= dataGridRow.sd_iz_1) {
        significado = 'Es menor o igual a -1 DE';
      } else if (interpretacion > dataGridRow.sd_iz_1 &&
          interpretacion < dataGridRow.sd_de_1) {
        significado = 'Esta alrededor de la Mediana';
      } else if (interpretacion >= dataGridRow.sd_de_1 &&
          interpretacion < dataGridRow.sd_de_2) {
        significado = 'Es mayor o igual a +1 DE';
      } else {
        significado = 'Es mayor o igual a +2 DE';
      }
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'interpretacion', value: significado),
        DataGridCell<String>(columnName: 'sex', value: dataGridRow.sex),
        DataGridCell<double>(columnName: 'years', value: dataGridRow.years),
        DataGridCell<double>(columnName: 'sd_iz_2', value: dataGridRow.sd_iz_2),
        DataGridCell<double>(columnName: 'sd_iz_1', value: dataGridRow.sd_iz_1),
        DataGridCell<double>(columnName: 'median', value: dataGridRow.median),
        DataGridCell<double>(columnName: 'sd_de_1', value: dataGridRow.sd_de_1),
        DataGridCell<double>(columnName: 'sd_de_2', value: dataGridRow.sd_de_2),
      ]);
    }).toList(growable: false);
  }
}
=======
// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_1/app/controllers/DownYears_Controller.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DownYearsDataTable extends StatelessWidget {
  final String fileJsonData;
  final double interpretacion;
  const DownYearsDataTable(
      {super.key, required this.fileJsonData, required this.interpretacion});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DownYearsController>(
      builder: (_) {
        return FutureBuilder(
          future: getProductDataSource(
              fileJson: fileJsonData,
              rango:
                  int.parse((double.parse(_.year.text) - 2).toStringAsFixed(0)),
              interpretacion: interpretacion),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return snapshot.hasData
                ? Container(
                    constraints: const BoxConstraints(maxHeight: 120), // BOX CO
                    child: SfDataGrid(
                      source: snapshot.data,
                      columns: getColumns(),
                      columnWidthMode: ColumnWidthMode.fill,
                      rowHeight: 50, // tamaño de las filas sobre la ALTURA,
                      headerRowHeight: 30, // tamaño del HEADER sobre la ALTURA
                    ),
                  )
                : const Text(
                    'El valor de los años de nacimiento de estar entre 2 y 20');
          },
        );
      },
    );
  }

  Future<ProductDataGridSource> getProductDataSource(
      {fileJson, rango, interpretacion}) async {
    var productList = await generateProductList(
        fileJson: fileJson, rango: rango, interpretacion: interpretacion);
    return ProductDataGridSource(productList, interpretacion);
  }

// Obtener Colum INICIO
  List<GridColumn> getColumns() {
    return <GridColumn>[
      repetirColumn(
          columnName: 'interpretacion', nombreColumn: 'Interpretación'),
      repetirColumn(columnName: 'sex', nombreColumn: 'Sexo'),
      repetirColumn(columnName: 'years', nombreColumn: 'Años'),
      repetirColumn(columnName: 'sd_iz_2', nombreColumn: '-2 DE'),
      repetirColumn(columnName: 'sd_iz_1', nombreColumn: '-1 DE'),
      repetirColumn(columnName: 'median', nombreColumn: 'Mediana'),
      repetirColumn(columnName: 'sd_de_1', nombreColumn: '+1 DE'),
      repetirColumn(columnName: 'sd_de_2', nombreColumn: '+2 DE'),
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
  Future<List<SalesDownYear>> generateProductList(
      {fileJson, rango, interpretacion}) async {
    //int dos=2;
    if (rango > 0 && rango < 18) {
      rango = rango + rango;
    } else if (rango == 18) {
      rango = 35;
    } else {
      rango = rango + rango;
    }

    var response = await rootBundle.loadString(fileJson);
    var decodedProducts = jsonDecode(response)
        .getRange(rango, rango + 2)
        .cast<Map<String, dynamic>>();
    List<SalesDownYear> productList = await decodedProducts
        .map<SalesDownYear>((json) => SalesDownYear.fromJson(json))
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
  late List<SalesDownYear> productList;
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
      if (interpretacion <= dataGridRow.sd_iz_2) {
        significado = 'Es menor o igual a -2 DE';
      } else if (interpretacion > dataGridRow.sd_iz_2 &&
          interpretacion <= dataGridRow.sd_iz_1) {
        significado = 'Es menor o igual a -1 DE';
      } else if (interpretacion > dataGridRow.sd_iz_1 &&
          interpretacion < dataGridRow.sd_de_1) {
        significado = 'Esta alrededor de la Mediana';
      } else if (interpretacion >= dataGridRow.sd_de_1 &&
          interpretacion < dataGridRow.sd_de_2) {
        significado = 'Es mayor o igual a +1 DE';
      } else {
        significado = 'Es mayor o igual a +2 DE';
      }
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'interpretacion', value: significado),
        DataGridCell<String>(columnName: 'sex', value: dataGridRow.sex),
        DataGridCell<double>(columnName: 'years', value: dataGridRow.years),
        DataGridCell<double>(columnName: 'sd_iz_2', value: dataGridRow.sd_iz_2),
        DataGridCell<double>(columnName: 'sd_iz_1', value: dataGridRow.sd_iz_1),
        DataGridCell<double>(columnName: 'median', value: dataGridRow.median),
        DataGridCell<double>(columnName: 'sd_de_1', value: dataGridRow.sd_de_1),
        DataGridCell<double>(columnName: 'sd_de_2', value: dataGridRow.sd_de_2),
      ]);
    }).toList(growable: false);
  }
}
>>>>>>> rama_3
