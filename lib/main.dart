import 'package:flutter/material.dart';
import 'package:flutter_mvvm/domain/usecase/login_usecase.dart';
import 'package:flutter_mvvm/presentation/login/login_viewmodel.dart';
import 'package:flutter_mvvm/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<OnBoardingViewModel>(
          create: (_) => OnBoardingViewModel(),
        ),
        ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(null))
      ],
      child: MyApp(),
    ),
  );
}
