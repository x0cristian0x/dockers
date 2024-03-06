// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class VelocidadController extends GetxController {
  final pesoViejo = TextEditingController();
  final pesoActual = TextEditingController();
  final tallaVieja = TextEditingController();
  final tallaActual = TextEditingController();
  final headActual = TextEditingController();
  final headViejo = TextEditingController();

  final edad = TextEditingController();
  final intervalo = TextEditingController();
  RxInt sexo = 1.obs;

  late InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;
  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-2015860081666244/8791682096",
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    pesoViejo.text = "2.4";
    pesoActual.text = "3.4";
    tallaVieja.text = "55.1";
    tallaActual.text = "55.5";
    headViejo.text = "55.1";
    headActual.text = "55.5";
    intervalo.text = "1";
    edad.text = '1';
    _createInterstitialAd();
  }

  actualizarVelocidad_1() {
    pesoViejo.value;
    pesoActual.value;
    tallaVieja.value;
    tallaActual.value;
    headViejo.value;
    headActual.value;
    edad.value;
    intervalo.value;
    update();

    if (_isAdLoaded) {
      _interstitialAd.show();
    }
    _isAdLoaded = false;
  }

  actualizarVelocidad_2() {
    sexo;
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;

    _interstitialAd.fullScreenContentCallback =
        FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
      _interstitialAd.dispose();
      _createInterstitialAd();
    }, onAdFailedToShowFullScreenContent: (ad, error) {
      _interstitialAd.dispose();
      _createInterstitialAd();
    });
  }
}

class SalesVelocidad {
  SalesVelocidad(this.edad, this.intervalo, this.iz_3, this.iz_2, this.iz_1,
      this.median, this.de_1, this.de_2, this.de_3, this.sex);

  final int edad;
  final String intervalo;
  // ignore: non_constant_identifier_names
  final double iz_3;
  // ignore: non_constant_identifier_names
  final double iz_2;
  // ignore: non_constant_identifier_names
  final double iz_1;
  final double median;
  // ignore: non_constant_identifier_names
  final double de_1;
  // ignore: non_constant_identifier_names
  final double de_2;
  // ignore: non_constant_identifier_names
  final double de_3;
  final String sex;

  factory SalesVelocidad.fromJson(Map<String, dynamic> parsedjson) {
    return SalesVelocidad(
        parsedjson['edad'],
        parsedjson['intervalo'].toString(),
        parsedjson['iz_3'],
        parsedjson['iz_2'],
        parsedjson['iz_1'],
        parsedjson['median'],
        parsedjson['de_1'],
        parsedjson['de_2'],
        parsedjson['de_3'],
        parsedjson['sex'].toString());
  }
}
