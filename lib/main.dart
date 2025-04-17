import 'package:flutter/material.dart';
import 'package:mzala/core/initializer.dart';
import 'package:mzala/core/routes/app_routes.dart';
import 'package:mzala/core/routes/on_generate_route.dart';
import 'package:mzala/core/themes/app_themes.dart';

void main() async {
  Initializer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mzala',
      theme: AppTheme.defaultTheme,
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.onboarding,
    );
  }
}
