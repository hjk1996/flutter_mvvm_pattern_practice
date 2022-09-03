import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  //타이머에서 설정한 시간 지나면 다음 페이지로 이동하는 함수.
  void _startDelay() {
    _timer =
        Timer(Duration(seconds: 2), _goNext); 
  }

  //다음 페이지로 이동하는 함수
  void _goNext() {
    Navigator.of(context).pushReplacementNamed(Routes.onBoardingRoute);
  }

  @override
  void initState() {
    super.initState();
    // 타이머 시작
    _startDelay();
  }

  @override
  void dispose() {
    // 타이머 처분
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image.asset(ImageAssets.splashLogo),
      ),
    );
  }
}
