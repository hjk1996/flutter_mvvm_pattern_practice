import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mvvm/presentation/login/login.dart';
import 'package:flutter_mvvm/presentation/onboarding/onboarding.dart';
import 'package:flutter_mvvm/presentation/resources/routes_manager.dart';

import 'package:flutter_mvvm/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal(); // private named constructor
  int appState = 0;
  static final MyApp instance = MyApp._internal(); // singleton

  factory MyApp() => instance; // factory for the class instance

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute, // 초기 라우트
      theme: getApplicationTheme(),
      routes: {
        OnBoardingView.routeName: (context) => const OnBoardingView(),
        LoginView.routeName: (context) => const LoginView(),
      },
    );
  }
}
