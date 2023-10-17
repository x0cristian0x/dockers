// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../controllers/Velocidad_Controller.dart';

class VelocidadDTHead extends StatelessWidget {
  final String fileJsonData;
  final int rango;
  final int edad;
  final double valorViejo;
  final double valorActual;

  const VelocidadDTHead(
      {Key? key,
      required this.fileJsonData,
      required this.rango,
      required this.edad,
      required this.valorViejo,
      required this.valorActual})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VelocidadController>(
      builder: (_) {
        return FutureBuilder(
          future: getProductDataSource(
            fileJson: fileJsonData,
            rango: rango,
            edad: edad,
            valorViejo: valorViejo,
            valorActual: valorActual,
          ),
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
                : const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
          },
        );
      },
    );
  }

  Future<ProductDataGridSource> getProductDataSource(
      {fileJson, edad, valorViejo, valorActual, rango}) async {
    var productList = await generateProductList(
      fileJson: fileJson,
      rango: rango,
      edad: edad,
    );
    return ProductDataGridSource(
        productList, rango, edad, valorViejo, valorActual);
  }

// Obtener Colum INICIO
  List<GridColumn> getColumns() {
    return <GridColumn>[
      repetirColumn(
          columnName: 'interpretacion', nombreColumn: 'Interpretación'),
      repetirColumn(columnName: 'sex', nombreColumn: 'Sexo'),
      repetirColumn(columnName: 'intervalo', nombreColumn: 'Meses'),
      repetirColumn(columnName: 'sd_iz_3', nombreColumn: '-3 SD'),
      repetirColumn(columnName: 'sd_iz_2', nombreColumn: '-2 SD'),
      repetirColumn(columnName: 'sd_iz_1', nombreColumn: '-1 SD'),
      repetirColumn(columnName: 'median', nombreColumn: 'Mediana'),
      repetirColumn(columnName: 'sd_de_1', nombreColumn: '+1 SD'),
      repetirColumn(columnName: 'sd_de_2', nombreColumn: '+2 SD'),
      repetirColumn(columnName: 'sd_de_3', nombreColumn: '+3 SD'),
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
  Future<List<SalesVelocidad>> generateProductList({
    fileJson,
    interpretacion,
    required edad,
    required rango,
  }) async {
    late int valorInicial;

    if (rango == 2) {
      valorInicial = 0;
      edad = edad - 2;
    } else if (rango == 3) {
      valorInicial = 11;
      edad = edad - 3;
    } else if (rango == 4) {
      valorInicial = 21;
      edad = edad - 4;
    } else if (rango == 6) {
      valorInicial = 42;
      edad = edad - 6;
    } else {
      valorInicial = 0;
      edad = 0;
    }

    var response = await rootBundle.loadString(fileJson);
    var decodedProducts = jsonDecode(response)
        .getRange(valorInicial + edad, valorInicial + 1 + edad)
        .cast<Map<String, dynamic>>();
    List<SalesVelocidad> productList = await decodedProducts
        .map<SalesVelocidad>((json) => SalesVelocidad.fromJson(json))
        .toList();

    return productList;
  }

// Leer Data FIN

}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(
      this.productList, rango, edad, valorViejo, valorActual) {
    buildDataGridRow(valorViejo, valorActual);
  }
  late List<DataGridRow> dataGridRows;
  late List<SalesVelocidad> productList;

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
          repetirCell(row, numCell: 9),
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

  void buildDataGridRow(valorViejo, valorActual) {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      late String significado;

      late double resultado = valorActual - valorViejo;

      if (resultado <= dataGridRow.iz_3) {
        significado = 'Es menor o igual a -3 DE';
      } else if (resultado > dataGridRow.iz_3 &&
          resultado <= dataGridRow.iz_2) {
        significado = 'Es menor o igual a -2 DE';
      } else if (resultado > dataGridRow.iz_2 &&
          resultado <= dataGridRow.iz_1) {
        significado = 'Es menor o igual a -1 DE';
      } else if (resultado > dataGridRow.iz_1 && resultado < dataGridRow.de_1) {
        significado = 'Esta alrededor de la Mediana';
      } else if (resultado >= dataGridRow.de_1 &&
          resultado < dataGridRow.de_2) {
        significado = 'Es mayor o igual a +1 DE';
      } else if (resultado >= dataGridRow.de_2 &&
          resultado < dataGridRow.de_3) {
        significado = 'Es mayor o igual a +2 DE';
      } else {
        significado = 'Es mayor o igual a +3 DE';
      }

      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'interpretacon', value: significado),
        DataGridCell<String>(columnName: 'sex', value: dataGridRow.sex),
        DataGridCell<String>(columnName: 'inter', value: dataGridRow.intervalo),
        DataGridCell<double>(columnName: 'sd_iz_3', value: dataGridRow.iz_3),
        DataGridCell<double>(columnName: 'sd_iz_2', value: dataGridRow.iz_2),
        DataGridCell<double>(columnName: 'sd_iz_1', value: dataGridRow.iz_1),
        DataGridCell<double>(columnName: 'median', value: dataGridRow.median),
        DataGridCell<double>(columnName: 'sd_de_1', value: dataGridRow.de_1),
        DataGridCell<double>(columnName: 'sd_de_2', value: dataGridRow.de_2),
        DataGridCell<double>(columnName: 'sd_de_3', value: dataGridRow.de_3),
      ]);
    }).toList(growable: false);
  }
}
