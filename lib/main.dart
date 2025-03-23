import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:her_aid/core/routes/app_routes.dart';
import 'package:her_aid/core/routes/on_generate_route.dart';
import 'package:her_aid/core/themes/app_themes.dart';
import 'package:her_aid/res/navigator.dart';
import 'package:her_aid/views/screens/authentication/login_view.dart';
import 'package:her_aid/views/screens/dashboard/dashboard_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sesi',
      theme: AppTheme.defaultTheme,
      onGenerateRoute: RouteGenerator.onGenerate,
      initialRoute: AppRoutes.onboarding,
    );
  }
}
