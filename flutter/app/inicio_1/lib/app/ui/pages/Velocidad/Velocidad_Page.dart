// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/Velocidad_Controller.dart';
import 'package:inicio_1/app/ui/pages/Velocidad/Velocidad_DT_Length.dart';
import 'package:inicio_1/app/ui/pages/Velocidad/Velocidad_DT_Weight.dart';
import 'package:inicio_1/app/ui/pages/Velocidad/Velocidad_Formulario.dart';
import 'package:inicio_1/app/ui/pages/Velocidad/Velocidad_Graf_Head.dart';
import 'package:inicio_1/app/ui/pages/Velocidad/Velocidad_Graf_Length.dart';
import 'package:inicio_1/app/ui/pages/Velocidad/Velocidad_Graf_Weight.dart';
import 'package:inicio_1/app/ui/pages/Velocidad/Velocidad_Radio.dart';

import 'Velocidad_DT_Head.dart';

class VelocidadPage extends GetView<VelocidadController> {
  const VelocidadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Velocidad de Crecimiento de la OMS')),
      body: GetBuilder<VelocidadController>(
        builder: (_) {
          List dataSex;
          late double resultadoPeso;
          late double resultadoTalla;
          late double resultadoHead;

          List dataBoy = [
            "assets/data/Velocidad_data/velocidad_weight_boy.json",
            "assets/data/Velocidad_data/velocidad_length_boy.json",
            "assets/data/Velocidad_data/velocidad_head_boy.json",
          ];
          List dataGirl = [
            "assets/data/Velocidad_data/velocidad_weight_girl.json",
            "assets/data/Velocidad_data/velocidad_length_girl.json",
            "assets/data/Velocidad_data/velocidad_head_girl.json",
          ];
          controller.sexo.value == 1 ? dataSex = dataBoy : dataSex = dataGirl;

          resultadoPeso = double.parse(controller.pesoActual.text) -
              double.parse(controller.pesoViejo.text);
          resultadoTalla = double.parse(controller.tallaActual.text) -
              double.parse(controller.tallaVieja.text);
          resultadoHead = double.parse(controller.headActual.text) -
              double.parse(controller.headViejo.text);

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('INSTRUCCIONES',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Velocidad/Peso:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text(
                      'Edades de 1 a 24 meses y intervalos de 1,2,3,4 y 6'),
                  const Text('Velocidad/Longitud:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text(
                      'Edades de 2 a 24 meses y intervalos de 2,3,4 y 6'),
                  const Text('Velocidad/Perímetro Cefálico:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text(
                      'Edades de 2 a 24 meses y intervalos de 2,3,4 y 6'),
                  const Divider(),
                  const FormularioVelocidad(),
                  const VelocidadRadio(),
                  ButtonEnviar(update: () => _.actualizarVelocidad_1()),
                  GrafVelocidadWeight(
                    valorX: int.parse(controller.edad.text).round(),
                    valorY: resultadoPeso,
                    fileJsonData: dataSex[0],
                    rango: int.parse(controller.intervalo.text).round(),
                    labelX: 'Edad',
                    labelY: 'Velocidad/Peso (kg)',
                    titulo: 'Velocidad/Peso - Edad',
                  ),
                  VelocidadDTWeight(
                      fileJsonData: dataSex[0],
                      edad: int.parse(controller.edad.text),
                      rango: int.parse(controller.intervalo.text),
                      valorViejo: double.parse(controller.pesoViejo.text),
                      valorActual: double.parse(controller.pesoActual.text)),
                  GrafVelocidadLength(
                    valorX: int.parse(controller.edad.text).round(),
                    valorY: resultadoTalla,
                    fileJsonData: dataSex[1],
                    rango: int.parse(controller.intervalo.text).round(),
                    labelX: 'Edad',
                    labelY: 'Velocidad/Longitud (cm)',
                    titulo: 'Velocidad/Longitud - Edad',
                  ),
                  VelocidadDTLength(
                      fileJsonData: dataSex[1],
                      edad: int.parse(controller.edad.text),
                      rango: int.parse(controller.intervalo.text),
                      valorViejo: double.parse(controller.pesoViejo.text),
                      valorActual: double.parse(controller.pesoActual.text)),
                  GrafVelocidadHead(
                    valorX: int.parse(controller.edad.text).round(),
                    valorY: resultadoHead,
                    fileJsonData: dataSex[2],
                    rango: int.parse(controller.intervalo.text).round(),
                    labelX: 'Edad',
                    labelY: 'Velocidad/Perímetro cefalico (cm)',
                    titulo: 'Velocidad/Perímetro cefalico - Edad',
                  ),
                  VelocidadDTHead(
                      fileJsonData: dataSex[2],
                      edad: int.parse(controller.edad.text),
                      rango: int.parse(controller.intervalo.text),
                      valorViejo: double.parse(controller.headViejo.text),
                      valorActual: double.parse(controller.headActual.text)),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

class ButtonEnviar extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final update;
  const ButtonEnviar({super.key, required this.update});

  @override
  State<ButtonEnviar> createState() => _ButtonEnviarState();
}

class _ButtonEnviarState extends State<ButtonEnviar> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(1)),
          side: BorderSide(
            color: Colors.black,
          )),
      backgroundColor: const Color.fromRGBO(73, 81, 114, 1),
      tooltip: 'Enviar',
      hoverColor: Colors.black,
      onPressed: widget.update,
      child: const Text('Enviar'),
    );
  }
}
