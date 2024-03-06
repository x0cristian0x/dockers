// ignore_for_file: file_names, must_be_immutable, camel_case_types, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/Hemo_Controller.dart';

import 'Hemo_Formulario.dart';

class HemoPage extends GetView<HemoController> {
  const HemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
                'Determinar la Anémia según los niveles de Hemoglobina y la altitud')),
        body: GetBuilder<HemoController>(builder: (_) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*hola */
                  const Text('CLASIFICACIÓN'),
                  clasi(texto: '0 : Nacidos a termino de 0 a 1 mes cumplido'),
                  clasi(texto: '1 : Niños entre 2 a 5 meses cumplidos'),
                  clasi(texto: '2 : Niños entre 6 a 59 meses cumplidos'),
                  clasi(texto: '3 : Escolares de 5 a 11 años cumplidos'),
                  clasi(texto: '4 : Jovenes de 12 a 14 años cumplidos'),
                  clasi(texto: '5 : Varones de 15 años o mas'),
                  clasi(texto: '6 : No embarazada o Puerpera de 15 años o mas'),
                  clasi(texto: '7 : Mujeres gestantes de 15 años o mas'),
                  const FormularioHemo(),
                  get_altura(
                    clasificacion: int.parse(controller.clasificacion.text),
                    hemoglobina: int.parse(controller.hemoglobina.text),
                    opcional: int.parse(controller.opcional.text),
                    update: () {
                      _.actualizarHemo();
                    },
                  ),
                ],
              )
            ],
          );
        }));
  }
}

class clasi extends StatelessWidget {
  clasi({super.key, required this.texto});
  String texto;
  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: const TextStyle(fontSize: 12),
    );
  }
}

class get_altura extends StatefulWidget {
  final clasificacion;
  final hemoglobina;
  final update;
  final opcional;
  const get_altura(
      {super.key,
      required this.clasificacion,
      required this.hemoglobina,
      required this.opcional,
      required this.update});

  @override
  getAlturaHome createState() => getAlturaHome();
}

class getAlturaHome extends State<get_altura> {
  @override
  Widget build(BuildContext context) {
    late Text textAltitud;
    Text textClasificacion;

// Texto altitud

    textAltitud = Text('Altitud: ${(widget.opcional).round()}');

// Texto clasificacionn
    if (widget.clasificacion == 0) {
      textClasificacion = const Text('Clasificación: Nacidos de 0 a 1 mes');
    } else if (widget.clasificacion == 1) {
      textClasificacion = const Text('Clasificación: 2 a 5 meses');
    } else if (widget.clasificacion == 2) {
      textClasificacion = const Text('Clasificación: 6 a 59 meses');
    } else if (widget.clasificacion == 3) {
      textClasificacion = const Text('Clasificación: 5 a 11 años');
    } else if (widget.clasificacion == 4) {
      textClasificacion = const Text('Clasificación: 12 a 14 años');
    } else if (widget.clasificacion == 5) {
      textClasificacion = const Text('Clasificación: Varones de 15 o +');
    } else if (widget.clasificacion == 6) {
      textClasificacion =
          const Text('Clasificación: No embarazada o puerpera de 15 años o +');
    } else {
      textClasificacion = const Text('Clasificación: Gestantes de 15 años o +');
    }

    int clasi = (widget.clasificacion).round();
    int hemoCorr = (widget.hemoglobina).round();
    int hemoOrig = (widget.hemoglobina).round();

    late double altitud;

    String interpretacion = '';

    altitud = (widget.opcional).toDouble();

    if (altitud < 1000.0) {
      hemoCorr = hemoCorr;
    } else if (altitud >= 1000.0 && altitud < 1500.0) {
      hemoCorr = hemoCorr - 2;
    } else if (altitud >= 1500.0 && altitud < 2000.0) {
      hemoCorr = hemoCorr - 5;
    } else if (altitud >= 2000.0 && altitud < 2500.0) {
      hemoCorr = hemoCorr - 8;
    } else if (altitud >= 2500.0 && altitud < 3000.0) {
      hemoCorr = hemoCorr - 13;
    } else if (altitud >= 3000.0 && altitud < 3500.0) {
      hemoCorr = hemoCorr - 19;
    } else if (altitud >= 3500.0 && altitud < 4000.0) {
      hemoCorr = hemoCorr - 27;
    } else if (altitud >= 4000.0 && altitud < 4500.0) {
      hemoCorr = hemoCorr - 35;
    } else {
      hemoCorr = hemoCorr - 45;
    }

// Edad de 0 a 1 meses cumplidos
    if (clasi == 0) {
      if (hemoOrig < 135) {
        interpretacion = 'Tiene anemia';
      } else {
        interpretacion = 'Sin anemia';
      }
// Edad de 2 a 5 meses cumplidos
    } else if (clasi == 1) {
      if (hemoOrig < 95) {
        interpretacion = 'Tiene anemia';
      } else {
        interpretacion = 'Sin anemia';
      }
// Edad de 6 meses a 4 años cumplidos
    } else if (clasi == 2) {
      if (hemoCorr < 70) {
        interpretacion = 'Anemia severa';
      } else if (hemoCorr >= 70 && hemoCorr < 100) {
        interpretacion = 'Anemia moderada';
      } else if (hemoCorr >= 100 && hemoCorr < 110) {
        interpretacion = 'Anemia leve';
      } else {
        interpretacion = 'Sin anemia';
      }
      // Edad de 5 a 11 años cumplidos
    } else if (clasi == 3) {
      if (hemoCorr < 80) {
        interpretacion = 'Anemia severa';
      } else if (hemoCorr >= 80 && hemoCorr < 110) {
        interpretacion = 'Anemia moderada';
      } else if (hemoCorr >= 110 && hemoCorr < 115) {
        interpretacion = 'Anemia leve';
      } else {
        interpretacion = 'Sin anemia';
      }
// Edad de 12 a 14 años cumplidos
    } else if (clasi == 4) {
      if (hemoCorr < 80) {
        interpretacion = 'Anemia severa';
      } else if (hemoCorr >= 80 && hemoCorr < 110) {
        interpretacion = 'Anemia moderada';
      } else if (hemoCorr >= 110 && hemoCorr < 120) {
        interpretacion = 'Anemia leve';
      } else {
        interpretacion = 'Sin anemia';
      }
// Varones de 15 años a mas
    } else if (clasi == 5) {
      if (hemoCorr < 80) {
        interpretacion = 'Anemia severa';
      } else if (hemoCorr >= 80 && hemoCorr < 110) {
        interpretacion = 'Anemia moderada';
      } else if (hemoCorr >= 110 && hemoCorr < 130) {
        interpretacion = 'Anemia leve';
      } else {
        interpretacion = 'Sin anemia';
      }
// Mujeres No gestanted de 15 años a mas o Puerpera
    } else if (clasi == 6) {
      if (hemoCorr < 80) {
        interpretacion = 'Anemia severa';
      } else if (hemoCorr >= 80 && hemoCorr < 110) {
        interpretacion = 'Anemia moderada';
      } else if (hemoCorr >= 110 && hemoCorr < 120) {
        interpretacion = 'Anemia leve';
      } else {
        interpretacion = 'Sin anemia';
      }
// Mujeres Gestante de 15 años a mas
    } else if (clasi == 7) {
      if (hemoCorr < 70) {
        interpretacion = 'Anemia severa';
      } else if (hemoCorr >= 70 && hemoCorr < 100) {
        interpretacion = 'Anemia moderada';
      } else if (hemoCorr >= 100 && hemoCorr < 110) {
        interpretacion = 'Anemia leve';
      } else {
        interpretacion = 'Sin anemia';
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            onPressed: () async {
              widget.update();
            },
            child: const Text('Enviar')),
        textAltitud,
        textClasificacion,
        Text('Hemoglobina: ${widget.hemoglobina}'),
        Text('Hemoglobina corregida por altitud: $hemoCorr'),
        Text('Resultado: $interpretacion'),
      ],
    );
  }
}
