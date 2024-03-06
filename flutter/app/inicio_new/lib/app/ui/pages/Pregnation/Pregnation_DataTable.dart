// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_new/app/controllers/Pregnation_Controller.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PregnationDataTable extends StatelessWidget {
  final String fileJsonData;
  final double interpretacion;
  const PregnationDataTable(
      {super.key, required this.fileJsonData, required this.interpretacion});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PregnationController>(
      builder: (_) {
        return FutureBuilder(
          future: getProductDataSource(
              fileJson: fileJsonData,
              rango: int.parse(
                  (double.parse(_.week.text) - 10).toStringAsFixed(0)),
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
                : const Text(
                    'El valor de las semanas de embarazo debe estar entre 10 y 42');
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
      repetirColumn(columnName: 'imc', nombreColumn: 'IMC'),
      repetirColumn(columnName: 'weeks', nombreColumn: 'Semana'),
      repetirColumn(columnName: 'autor', nombreColumn: 'Autor'),
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
  Future<List<SalesPregnation>> generateProductList(
      {fileJson, rango, interpretacion}) async {
    var response = await rootBundle.loadString(fileJson);
    var decodedProducts = jsonDecode(response)
        .getRange(rango, rango + 1)
        .cast<Map<String, dynamic>>();
    List<SalesPregnation> productList = await decodedProducts
        .map<SalesPregnation>((json) => SalesPregnation.fromJson(json))
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
  late List<SalesPregnation> productList;
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
      if (interpretacion <= dataGridRow.bajopeso) {
        significado = 'Tiene Bajo Peso';
      } else if (interpretacion > dataGridRow.bajopeso &&
          interpretacion < dataGridRow.sobrepeso) {
        significado = 'Tiene Peso Normal';
      } else if (interpretacion >= dataGridRow.sobrepeso &&
          interpretacion < dataGridRow.obesidad) {
        significado = 'Tiene Sobrepeso';
      } else {
        significado = 'Tiene Obesidad';
      }

      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'interpretacon', value: significado),
        DataGridCell<double>(columnName: 'imc', value: interpretacion),
        DataGridCell<int>(columnName: 'weeks', value: dataGridRow.weeks),
        DataGridCell<String>(columnName: 'autor', value: dataGridRow.autor),
      ]);
    }).toList(growable: false);
  }
}
