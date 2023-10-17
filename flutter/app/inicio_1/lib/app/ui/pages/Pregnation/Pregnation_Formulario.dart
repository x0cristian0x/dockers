// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_1/app/controllers/Pregnation_Controller.dart';

class FormularioPregnation extends StatelessWidget {
  const FormularioPregnation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PregnationController>(
      init: PregnationController(),
      initState: (_) {},
      builder: (_) {
        const divider = Divider(
          height: 5,
        );
        return Column(
          children: [
            FormSimple(
              controlador: _.week,
              etiquetaTexto: 'Ingrese las semanas de embarazo',
              textoOculto: 'Ingrese las semanas de embarazo',
            ),
            divider,
            FormSimple(
              controlador: _.estatura,
              etiquetaTexto: 'Ingrese la estatura en cm',
              textoOculto: 'Ingrese la estatura en cm',
            ),
            divider,
            FormSimple(
              controlador: _.peso,
              etiquetaTexto: 'Ingrese el peso en kg',
              textoOculto: 'Ingrese el peso en kg',
            ),
            divider,
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
    Key? key,
    required this.controlador,
    required this.textoOculto,
    required this.etiquetaTexto,
  }) : super(key: key);

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
