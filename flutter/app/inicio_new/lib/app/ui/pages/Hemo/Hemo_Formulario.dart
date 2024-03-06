// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_new/app/controllers/Hemo_Controller.dart';

class FormularioHemo extends StatelessWidget {
  const FormularioHemo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HemoController>(
      init: HemoController(),
      initState: (_) {},
      builder: (_) {
        const divider = Divider(
          height: 5,
        );
        return Column(
          children: [
            FormSimple(
              controlador: _.clasificacion,
              etiquetaTexto:
                  'Ingrese el número de la clasificación que le corresponda',
              textoOculto:
                  'Ingrese el número de la clasificación que le corresponda',
            ),
            divider,
            FormSimple(
              controlador: _.hemoglobina,
              etiquetaTexto: 'Ingrese el nivel de hemoglobina en g/L',
              textoOculto: 'Ingrese el nivel de hemoglobina en g/L',
            ),
            divider,
            FormSimple(
              controlador: _.opcional,
              etiquetaTexto: 'Introduzca la altitud en metros (msnm)',
              textoOculto: 'Introduzca la altitud en metros (msnm)',
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
