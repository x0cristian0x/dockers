// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_1/app/controllers/OMS_Controller.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class OMSDataTable extends StatelessWidget {
  final String fileJsonData;
  final double interpretacion;
  const OMSDataTable(
      {Key? key, required this.fileJsonData, required this.interpretacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OMSController>(
      builder: (_) {
        return FutureBuilder(
          future: getProductDataSource(
              fileJson: fileJsonData,
              rango: int.parse(double.parse(_.mes.text).toStringAsFixed(0)),
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
                    'Los datos que proporciono no existen en la tabla');
            // const Center(
            //     child: CircularProgressIndicator(
            //       strokeWidth: 2,
            //     ),
            //   );
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
      repetirColumn(columnName: 'month', nombreColumn: 'Mes'),
      repetirColumn(columnName: 'sd_iz_3', nombreColumn: '-3 DE'),
      repetirColumn(columnName: 'sd_iz_2', nombreColumn: '-2 DE'),
      repetirColumn(columnName: 'sd_iz_1', nombreColumn: '-1 DE'),
      repetirColumn(columnName: 'median', nombreColumn: 'Mediana'),
      repetirColumn(columnName: 'sd_de_1', nombreColumn: '+1 DE'),
      repetirColumn(columnName: 'sd_de_2', nombreColumn: '+2 DE'),
      repetirColumn(columnName: 'sd_de_2', nombreColumn: '+3 DE'),
    ];
  }

  GridColumn repetirColumn({columnName, nombreColumn}) {
    return GridColumn(
        columnName: columnName,
        //width: 70, Ancho limitado en
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
  Future<List<SalesDetails>> generateProductList(
      {fileJson, rango, interpretacion}) async {
    var response = await rootBundle.loadString(fileJson);
    var decodedProducts = jsonDecode(response)
        .getRange(rango, rango + 1)
        .cast<Map<String, dynamic>>();
    List<SalesDetails> productList = await decodedProducts
        .map<SalesDetails>((json) => SalesDetails.fromJson(json))
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
  late List<SalesDetails> productList;
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
          repetirCell(row, numCell: 9),
        ]);
  }

  Container repetirCell(DataGridRow row, {numCell}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(0),
      child: Text(row.getCells()[numCell].value.toString(),
          // overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 10)),
    );
  }
// Colocar Valor Cell FIN

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow(interpretacion) {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      late String significado;
      if (interpretacion <= dataGridRow.sd_iz_3) {
        significado = 'Es menor o igual a -3 DE';
      } else if (interpretacion > dataGridRow.sd_iz_3 &&
          interpretacion <= dataGridRow.sd_iz_2) {
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
      } else if (interpretacion >= dataGridRow.sd_de_2 &&
          interpretacion < dataGridRow.sd_de_3) {
        significado = 'Es mayor o igual a +2 DE';
      } else {
        significado = 'Es mayor o igual a +3 DE';
      }

      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'interpretacion', value: significado),
        DataGridCell<String>(columnName: 'sex', value: dataGridRow.sex),
        DataGridCell<int>(columnName: 'months', value: dataGridRow.months),
        DataGridCell<double>(columnName: 'sd_iz_3', value: dataGridRow.sd_iz_3),
        DataGridCell<double>(columnName: 'sd_iz_2', value: dataGridRow.sd_iz_2),
        DataGridCell<double>(columnName: 'sd_iz_1', value: dataGridRow.sd_iz_1),
        DataGridCell<double>(columnName: 'median', value: dataGridRow.median),
        DataGridCell<double>(columnName: 'sd_de_1', value: dataGridRow.sd_de_1),
        DataGridCell<double>(columnName: 'sd_de_2', value: dataGridRow.sd_de_2),
        DataGridCell<double>(columnName: 'sd_de_3', value: dataGridRow.sd_de_3),
      ]);
    }).toList(growable: false);
  }
}
