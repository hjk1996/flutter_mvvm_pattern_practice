import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/domain/model/model.dart';
import 'package:flutter_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm/presentation/resources/strings_manager.dart';

class OnBoardingViewModel with ChangeNotifier {
  List<SliderObject> _list = [];
  List<SliderObject> get list => _list;
  int get length => _list.length;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void start() {
    _populateList();
  }

  @override
  void dispose() {
    _list = [];
    _currentIndex = 0;
    super.dispose();
  }

  void _populateList() {
    _list = [
      SliderObject(
        AppStrings.onBoardingTitle1,
        AppStrings.onBoardingSubtitle1,
        ImageAssets.onBoardingLogo1,
      ),
      SliderObject(
        AppStrings.onBoardingTitle2,
        AppStrings.onBoardingSubtitle2,
        ImageAssets.onBoardingLogo2,
      ),
      SliderObject(
        AppStrings.onBoardingTitle3,
        AppStrings.onBoardingSubtitle3,
        ImageAssets.onBoardingLogo3,
      ),
      SliderObject(
        AppStrings.onBoardingTitle4,
        AppStrings.onBoardingSubtitle4,
        ImageAssets.onBoardingLogo4,
      ),
    ];
  }

  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex == _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
