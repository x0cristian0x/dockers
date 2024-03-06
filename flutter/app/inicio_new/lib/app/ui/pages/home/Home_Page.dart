// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inicio_new/app/controllers/Home_Controller.dart';

import 'package:inicio_new/app/ui/pages/Ads/bottom_banner_ad.dart';
import 'package:store_redirect/store_redirect.dart';

//getpage
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomBannerAd(),
      appBar: AppBar(
          title: const Text(
        'PÁGINA PRINCIPAL',
        style: TextStyle(
          fontSize: 35,
          fontStyle: FontStyle.italic,
        ),
      )),
      body: SafeArea(child:
          // Necesario el <HomeController> segun la page y la _
          GetBuilder<HomeController>(builder: (_) {
        return Container(
          padding: const EdgeInsets.all(15),
          child: ListView(children: [
            Column(
              children: [
                _ClickPage(
                    texto: 'Patrón de Crecimiento de la OMS de 0 a 18 años',
                    cambiarPagina: () => _.voyOMS()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto:
                        'Patrón de Crecimiento del Recién Nacido de 0 a 13 semanas de la OMS',
                    cambiarPagina: () => _.voyRN()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto:
                        'Patrón de Crecimiento para el Prematuro de 23 a 50 semanas',
                    cambiarPagina: () => _.voyPremature()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto:
                        'Determinar la Anémia según los niveles de Hemoglobina y altitud',
                    cambiarPagina: () => _.voyHemo()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto:
                        'Patrón de Crecimiento para el Síndrome de Down de 1 a 36 meses',
                    cambiarPagina: () => _.voyDownMonths()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto:
                        'Patrón de Crecimiento para el Síndrome de Down de 2 a 20 años',
                    cambiarPagina: () => _.voyDownYears()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto:
                        'Estado Nutricional de la embarazada de 10 a 42 semanas',
                    cambiarPagina: () => _.voyPregnation()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto:
                        'Patrón de Crecimiento del Síndrome de Turner de 3 a 18 años',
                    cambiarPagina: () => _.voyTurner()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto: 'Velocidad de Crecimiento de la OMS de 0 a 2 años',
                    cambiarPagina: () => _.voyVelocidad()),
                const Divider(
                  height: 15,
                ),
                _ClickPage(
                    texto: 'Información',
                    cambiarPagina: () => _.voyInformacion()),
                const Divider(
                  height: 15,
                ),
                ElevatedButton(
                    child: const Text('Comparte la App'),
                    onPressed: () async {
                      StoreRedirect.redirect(
                          androidAppId: "com.cristianheredia.crecer",
                          iOSAppId: "585027354");
                    }),
              ],
            ),
          ]),
        );
      })),
    );
  }
}

class _ClickPage extends StatelessWidget {
  final String texto;
  // ignore: prefer_typing_uninitialized_variables
  final cambiarPagina;
  const _ClickPage({
    required this.texto,
    required this.cambiarPagina,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: cambiarPagina,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(70, 248, 248, 1),
              fixedSize: const Size(double.infinity, double.infinity),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          child: Text(
            texto,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        )
      ],
    );
  }
}
