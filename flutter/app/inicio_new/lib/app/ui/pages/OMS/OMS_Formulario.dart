// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_new/app/controllers/OMS_Controller.dart';

class FormularioOMS extends StatelessWidget {
  const FormularioOMS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OMSController>(
      init: OMSController(),
      initState: (_) {},
      builder: (_) {
        const divider = Divider(
          height: 5,
        );
        return Column(
          children: [
            FormSimple(
              controlador: _.mes,
              etiquetaTexto: 'Ingrese la edad en meses',
              textoOculto: 'Ingrese la edad en meses',
            ),
            divider,
            FormSimple(
              controlador: _.estatura,
              etiquetaTexto: 'Ingrese la Longitud/Estatura en cm',
              textoOculto: 'Ingrese la Longitud/Estatura en cm',
            ),
            divider,
            FormSimple(
              controlador: _.peso,
              etiquetaTexto: 'Ingrese el Peso en kg',
              textoOculto: 'Ingrese el Peso en kg',
            ),
            divider,
            FormSimple(
              controlador: _.head,
              etiquetaTexto: 'Ingrese el Perímetro Cefálico en cm',
              textoOculto: 'Ingrese el Perímetro Cefálico en cm',
            ),
            divider,
            FormSimple(
              controlador: _.arm,
              etiquetaTexto: 'Ingrese el Perímetro Braquial en cm',
              textoOculto: 'Ingrese el Perímetro Braquial en cm',
            ),
          ],
        );
      },
    );
  }
}

class FormSimple extends StatelessWidget {
  final TextEditingController controlador;
  final String textoOculto;
  final String etiquetaTexto;
  const FormSimple({
    super.key,
    required this.controlador,
    required this.textoOculto,
    required this.etiquetaTexto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 16, color: Colors.red),
        controller: controlador,
        decoration: InputDecoration(
            //icon: Icon(Icons.person),
            hintText: textoOculto,
            labelText: etiquetaTexto,
            labelStyle: const TextStyle(color: Colors.black, fontSize: 18.0),
            border: InputBorder.none),
      ),
    );
  }
}
