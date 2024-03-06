// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_1/app/controllers/Premature_Controller.dart';

class FormularioPremature extends StatelessWidget {
  const FormularioPremature({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrematureController>(
      init: PrematureController(),
      initState: (_) {},
      builder: (_) {
        const divider = Divider(
          height: 5,
        );
        return Column(
          children: [
            FormSimple(
              controlador: _.week,
              etiquetaTexto: 'Ingrese las semanas de nacimiento del prematuro',
              textoOculto: 'Ingrese las semanas de nacimiento del prematuro',
            ),
            divider,
            FormSimple(
              controlador: _.estatura,
              etiquetaTexto: 'Ingrese la longitud en cm',
              textoOculto: 'Ingrese la longitud en cm',
            ),
            divider,
            FormSimple(
              controlador: _.peso,
              etiquetaTexto: 'Ingrese el peso en kg',
              textoOculto: 'Ingrese el peso en kg',
            ),
            divider,
            FormSimple(
              controlador: _.head,
              etiquetaTexto: 'Ingrese el Perímetro Cefálico en cm',
              textoOculto: 'Ingrese el Perímetro Cefálico en cm',
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
