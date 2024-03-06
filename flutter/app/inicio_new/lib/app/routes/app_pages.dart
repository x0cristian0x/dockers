import 'package:get/get.dart';
import 'package:inicio_new/app/bindings/DownMonths_Binding.dart';
import 'package:inicio_new/app/bindings/DownYears_Binding.dart';
import 'package:inicio_new/app/bindings/Informacion_Binding.dart';
import 'package:inicio_new/app/bindings/OMS_Binding.dart';
import 'package:inicio_new/app/bindings/Pregnation_Binding.dart';
import 'package:inicio_new/app/bindings/Premature_Binding.dart';
import 'package:inicio_new/app/bindings/RN_Binding.dart';
import 'package:inicio_new/app/bindings/Turner_Binding.dart';
import 'package:inicio_new/app/bindings/Velocidad_Binding.dart';
import 'package:inicio_new/app/ui/pages/DownMonths/DownMonths_Page.dart';
import 'package:inicio_new/app/ui/pages/DownYears/DownYears_Page.dart';
import 'package:inicio_new/app/ui/pages/Hemo/Hemo_Page.dart';
import 'package:inicio_new/app/ui/pages/Informacion/Informacion_Page.dart';
import 'package:inicio_new/app/ui/pages/OMS/OMS_Page.dart';
import 'package:inicio_new/app/ui/pages/Pregnation/Pregnation_Page.dart';
import 'package:inicio_new/app/ui/pages/Premature/Premature_Page.dart';
import 'package:inicio_new/app/ui/pages/RN/RN_Page.dart';
import 'package:inicio_new/app/ui/pages/Turner/Turner_Page.dart';
import 'package:inicio_new/app/ui/pages/Velocidad/Velocidad_Page.dart';
import 'package:inicio_new/app/ui/pages/home/Home_Page.dart';

import '../bindings/Hemo_Binding.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomePage(),
        // Cambiar la forma de cambiar page
        transition: Transition.leftToRight),
    GetPage(
      name: Routes.OMS,
      page: () => const OMSPage(),
      binding: OMSBinding(),
    ),
    GetPage(
      name: Routes.RN,
      page: () => const RNPage(),
      binding: RNBinding(),
    ),
    GetPage(
      name: Routes.PREMATURE,
      page: () => const PrematurePage(),
      binding: PrematureBinding(),
    ),
    GetPage(
      name: Routes.PREGNATION,
      page: () => const PregnationPage(),
      binding: PregnationBinding(),
    ),
    GetPage(
      name: Routes.DOWNYEARS,
      page: () => const DownYearsPage(),
      binding: DownYearsBinding(),
    ),
    GetPage(
      name: Routes.DOWNMONTHS,
      page: () => const DownMonthsPage(),
      binding: DownMonthsBinding(),
    ),
    GetPage(
      name: Routes.TURNER,
      page: () => const TurnerPage(),
      binding: TurnerBinding(),
    ),
    GetPage(
      name: Routes.INFORMACION,
      page: () => const InformacionPage(),
      binding: InformacionBinding(),
    ),
    GetPage(
      name: Routes.HEMO,
      page: () => const HemoPage(),
      binding: HemoBinding(),
    ),
    GetPage(
      name: Routes.VELOCIDAD,
      page: () => const VelocidadPage(),
      binding: VelocidadBiling(),
    ),
  ];
}
