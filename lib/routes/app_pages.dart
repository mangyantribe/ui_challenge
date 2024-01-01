
import 'package:get/get.dart';

import '../models/House.dart';
import '../views/details.dart';
import '../views/dashboard.dart';
import '../views/onboarding.dart';
import '../views/photo_viewer.dart';
import 'routes.dart';

class AppPages{
  static var list = [
    GetPage(
      name: Routes.onboarding,
      page: () =>  const Onboarding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () =>  Dashboard(),
    ),
    GetPage(
      name: Routes.details,
      page: () =>  Details(house: House(),),
    ),
    GetPage(
      name: Routes.photos,
      page: () =>  PhotoViewer(),
      transition: Transition.zoom,
    ),
  ];
}