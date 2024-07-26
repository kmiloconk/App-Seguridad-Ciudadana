import 'package:app_prueba/app/ui/pages/emergenci/emergenci_page.dart';
import 'package:app_prueba/app/ui/pages/emergenci/prueba.dart';
import 'package:app_prueba/app/ui/pages/home/home_page.dart';
import 'package:app_prueba/app/ui/pages/request_permission/request_permission_page.dart';
import 'package:app_prueba/app/ui/pages/splash/splash_page.dart';
import 'package:app_prueba/app/ui/routes/routers.dart';
import 'package:app_prueba/app/ui/pages/admin_home/admin_page.dart';
import 'package:app_prueba/app/ui/pages/login/login_page.dart';
import 'package:flutter/widgets.dart';

Map<String, Widget Function(BuildContext)> appRoutes() {
  return {
    Routes.SPLASH: (_) => const SplashPage(),
    Routes.PERMISSIONS: (_) => const RequestPermisionPage(),
    Routes.HOME: (_) => HomePage(),
    Routes.ADMIN: (contex) => AdminPage(),
    Routes.LOGIN: (_) => Login(),
    Routes.EMERGENCI: (_) => Emergenci(),
    Routes.PRUEBA: (p0) => Prueba()
  };
}
