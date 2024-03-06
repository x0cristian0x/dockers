// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inicio_new/app/controllers/Velocidad_Controller.dart';

class FormularioVelocidad extends StatelessWidget {
  const FormularioVelocidad({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VelocidadController>(
      init: VelocidadController(),
      initState: (_) {},
      builder: (_) {
        const divider = Divider(
          height: 5,
        );
        return Column(
          children: [
            FormSimple(
              controlador: _.edad,
              etiquetaTexto: 'Ingrese la edad en meses (Mayor o igual a 1)',
              textoOculto: 'Ingrese la edad en meses (Mayor o igual a 1)',
            ),
            divider,
            FormSimple(
              controlador: _.tallaVieja,
              etiquetaTexto: 'Ingrese la longitud PASADA en cm',
              textoOculto: 'Ingrese la longitud PASADA en cm',
            ),
            divider,
            FormSimple(
              controlador: _.tallaActual,
              etiquetaTexto: 'Ingrese la longitud ACTUAL en cm',
              textoOculto: 'Ingrese la longitud ACTUAL en cm',
            ),
            divider,
            FormSimple(
              controlador: _.pesoViejo,
              etiquetaTexto: 'Ingrese el peso PASADO en kg',
              textoOculto: 'Ingrese el peso PASADO en kg',
            ),
            divider,
            FormSimple(
              controlador: _.pesoActual,
              etiquetaTexto: 'Ingrese el peso ACTUAL en cm',
              textoOculto: 'Ingrese el peso ACTUAL en cm',
            ),
            divider,
            FormSimple(
              controlador: _.headViejo,
              etiquetaTexto: 'Ingrese el perímetro cefalico PASADO en cm',
              textoOculto: 'Ingrese el perímetro cefalico PASADA en cm',
            ),
            divider,
            FormSimple(
              controlador: _.headActual,
              etiquetaTexto: 'Ingrese el perímetro cefalico ACTUAL en cm',
              textoOculto: 'Ingrese el perímetro cefalico ACTUAL en cm',
            ),
            divider,
            FormSimple(
              controlador: _.intervalo,
              etiquetaTexto:
                  'Ingrese el intervalo en meses (Mayor o igual a 1)',
              textoOculto: 'Ingrese el intervalo en meses(Mayor o igual a 1)',
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
