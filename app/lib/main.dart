import 'dart:io';

import 'package:Edukids/res/style/app_colors.dart';
import 'package:Edukids/services/shared_pref_service.dart';
import 'package:Edukids/utils/dimens/dimens_manager.dart';
import 'package:Edukids/utils/routes/routes.dart';
import 'package:Edukids/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'push_notifications.dart';

import 'firebase_options.dart';

import 'locator.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  PushNotifications.init();
  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  HttpOverrides.global = MyHttpOverrides();
  setupLocator();

  SharedPrefService.instance.onInit();

  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 4));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DimensManager();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edukids',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: AppColors.primaryColor),
      ),
      initialRoute: RoutesName.login,
      onGenerateRoute: Routes.routeBuilder,
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..maxConnectionsPerHost = 5
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
