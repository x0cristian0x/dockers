// ignore: duplicate_ignore
// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_1/app/controllers/Informacion_Controller.dart';

class InformacionPage extends GetView<InformacionController> {
  const InformacionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Página de Información')),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextInfo(
                    titulo: 'Posibles Problemas al usar la aplicación',
                    frase:
                        'Si la pantalla esta en blanco o no muestra los Gráficos y/o Resultados posiblemente se debe a 2 situaciones: \n a) Dejar en BLANCO O VACIO alguna de las variables que se pida, si no posee algun dato, coloque el cero (0). \n b) Al usar decimales: debe usar el punto "." en vez de la coma ",". ejm: 7.8 \n\nSi persiste el problema contactanos para poder solucionarlo'),
                const Divider(height: 10),
                TextInfo(
                    titulo: 'Abreviatura',
                    frase:
                        'Kilogramo = kg \nCentímetro = cm \nDesviación Estándar = DE \nPercentil = P'),
                const Divider(height: 10),
                TextInfo(
                    titulo: 'Modo de uso',
                    frase:
                        'Utiliza la LONGITUD (Infantometro) en menores (recién nacidos, prematuros y en el síndrome de Down) de 2 años (de 0 a 23 meses). \n\nUtiliza la ESTATURA (Tallímetro) en los niños mayores a 2 años (mayor o igual a 24 meses) y en el síndrome de Down mayores de 2 años (mayor o igual a 24 meses). \n\nEn caso de usar la ESTATURA (Tallímetro) en vez de la LONGITUD (Infantometro) en los niños que se menciona anteriormente restar 0.7 centímetros (-0.7) a valor obtenido, como lo recomienda la OMS. \n\nPara visualizar mejor los gráficos, debe presionar por 2 seg. el gráfico y sin despegar el dedo debe dibujar un cuadrado alrededor del punto negro'),
                const Divider(height: 10),
                TextInfo(
                    titulo: 'Equivalencia Aproximada',
                    frase:
                        '-3 DE = Percentil 0.1 \n-2 DE = Percentil 3 \n-1 DE = Percentil 15 \nMediana = Percentil 50 \n+1 DE = Percentil 85 \n+2 DE = Percentil 97 \n+3 DE = Percentil 99.9'),
                const Divider(height: 10),
                TextInfo(
                    titulo: 'Rango de las Tablas',
                    frase:
                        'El PERÍMETRO CEFÁLICO para la EDAD de la OMS es de 0 a 60 meses. \n\nEl PERÍMETRO BRAQUIAL para la EDAD de la OMS es de 3 a 60 meses. \n\nEl PESO para la ESTATURA es de 0 a 60 meses (5 años). \n\nEl PESO para EDAD de la OMS es de 0 a 120 meses (0 a 10 años). \n\nPara la clasificación de WATERLOW se requiere del peso, la talla y la edad (la edad debe ser menor a 120 meses). \n\nVelocidad de Crecimiento de la OMS es de 0 a 2 años. '),
                const Divider(height: 10),
                TextInfo(
                    titulo: 'Fuentes de Información',
                    frase:
                        'Patrón de crecimiento de la Organización Mundial de la Salud para niños de 0 a 18 años y de 0 a 13 semanas. \n\nPatrón de Crecimiento de Fenton para el prematuro de 23 a 50 semanas.* \n\nPatrón de Crecimiento para el síndrome de Down de 1 a 36 meses y de 2 a 20 años de Babette, Zemel et al.* \n\nPatrón de Crecimiento para el síndrome de Turner de 3 a 18 años de Darendeliler, Yesilkaya et al. \n\nEstado nutricional de la embarazada de 10 a 42 semanas de Atalah de 1997 y 2005. \n\nConcentracion de hemoglobina para diagnosticar la anemia y evaluar sus gravedad OMS 2011.\n*Las tablas y los graficos se realizaron según LMS.'),
                const Divider(height: 10),
                textRow(
                  primerRow: '\nCONTACTOS',
                  segundoRow: '',
                ),
                textRow(
                  primerRow: 'Correo: ',
                  segundoRow: 'r.shiny.nutricion@gmail.com',
                ),
                textRow(
                  primerRow: 'Teléfono: ',
                  segundoRow: '(591)-79391176',
                ),
                textRow(
                  primerRow: 'Elaborado por: ',
                  segundoRow: 'Heredia Cristian',
                ),
                textRow(
                  primerRow: 'Colaborado por: ',
                  segundoRow: 'Dominguez Cesar - Quinteros Valentín',
                ),
              ],
            ),
          )
        ]));
  }
}

// ignore: camel_case_types
class textRow extends StatelessWidget {
  String primerRow;
  String segundoRow;
  textRow({super.key, required this.primerRow, required this.segundoRow});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          primerRow,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
        ),
        Text(segundoRow, style: const TextStyle(fontSize: 9))
      ],
    );
  }
}

class TextInfo extends StatelessWidget {
  String titulo;
  String frase;
  TextInfo({super.key, required this.titulo, required this.frase});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          frase,
          style: const TextStyle(color: Colors.black, fontSize: 10),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
