// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_new/app/controllers/Turner_Controller.dart';

class FormularioTurner extends StatelessWidget {
  const FormularioTurner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TurnerController>(
      init: TurnerController(),
      initState: (_) {},
      builder: (_) {
        const divider = Divider(
          height: 5,
        );
        return Column(
          children: [
            FormSimple(
              controlador: _.year,
              etiquetaTexto: 'Ingrese la edad en años',
              textoOculto: 'Ingrese la edad en años',
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
