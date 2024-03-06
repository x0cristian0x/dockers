<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:inicio_1/app/ui/pages/Ads/ad_service.dart';
import 'package:inicio_1/app/bindings/Home_Binding.dart';

import 'app/routes/app_pages.dart';
import 'app/ui/themes/Theme_Dark.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final adService = AdService(MobileAds.instance);
  GetIt.instance.registerSingleton<AdService>(adService);
  await adService.init();

  runApp(

      // GetMaterialApp es el Getx
      GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
  ));
}
=======
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:inicio_1/app/ui/pages/Ads/ad_service.dart';
import 'package:inicio_1/app/bindings/Home_Binding.dart';

import 'app/routes/app_pages.dart';
import 'app/ui/themes/Theme_Dark.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final adService = AdService(MobileAds.instance);
  GetIt.instance.registerSingleton<AdService>(adService);
  await adService.init();

  runApp(

      // GetMaterialApp es el Getx
      GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: Routes.HOME,
    theme: appThemeData,
    defaultTransition: Transition.fade,
    initialBinding: HomeBinding(),
    getPages: AppPages.pages,
  ));
}
>>>>>>> rama_3
