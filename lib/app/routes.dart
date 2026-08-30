import 'package:flutter/material.dart';

import '../presentation/splash/splash_screen.dart';
import '../presentation/home/home_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
    };
  }
}