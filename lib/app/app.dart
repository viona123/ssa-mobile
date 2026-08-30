import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

class SragenSmartCityApp extends StatelessWidget {
  const SragenSmartCityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sragen Smart City',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}