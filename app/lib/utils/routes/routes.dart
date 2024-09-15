import 'package:Edukids/utils/routes/routes_name.dart';
import 'package:Edukids/view/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../view/auth/login_screen.dart';
import '../../view/auth/register_screen.dart';
import '../../view/menu_lesson/product_list_screen.dart';

class Routes {
  static Route<dynamic> routeBuilder(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => Container());

      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());

      case RoutesName.register:
        return MaterialPageRoute(
            builder: (BuildContext context) => const RegisterScreen());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case RoutesName.productList: // Thêm ProductListScreen vào đây
        return MaterialPageRoute(builder: (BuildContext context) => ProductListScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }

  static void goToRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(RoutesName.register);
  }

  static void goToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RoutesName.login, (Route<dynamic> route) => false);
  }

  static void goToHomeScreen(BuildContext context) {
   // Navigator.of(context).pushNamed(RoutesName.home);

     Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.home, (Route<dynamic> route) => false);
  }
}
