import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:her_aid/res/navigator.dart';
import 'package:her_aid/views/screens/authentication/login_view.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorHelper.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            foregroundColor: Colors.black,
            backgroundColor: Colors.transparent,
            elevation: 0),
        fontFamily: "Poppins",
        useMaterial3: false,
      ),
      home: const LoginView(),
    );
    // This widget is the root of your application.
  }
}
