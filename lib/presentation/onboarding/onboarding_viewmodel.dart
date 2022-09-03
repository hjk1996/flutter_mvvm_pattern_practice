import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/domain/model.dart';
import 'package:flutter_mvvm/presentation/base/base_viewmodel.dart';
import 'package:flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _list;
  int _currentIndex = 0;

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void dispose() {
    // stream을 사용하는 widget이
    _streamController.close();
  }

  @override
  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex == _list.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list.length - 1;
    }
    return _currentIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  // private functions

  List<SliderObject> _getSliderData() => [
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

  void _postDataToView() {
    inputSliderViewObject.add(
      SliderViewObject(_list[_currentIndex], _list.length, _currentIndex),
    );
  }
}

// inputs mean the order that our viewmodel will receive from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe right

  void goPrevious(); // when user clicks on left arrow or swipe left

  void onPageChanged(int index);

  Sink
      get inputSliderViewObject; // this is the way to add data to the stream (stream input)
}

// outputs mean data or results that will be sent from our viewmodel to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSildes;
  int currentIndex;

  SliderViewObject(
    this.sliderObject,
    this.numOfSildes,
    this.currentIndex,
  );
}

class OnBoardingProvider with ChangeNotifier {
  late List<SliderObject>? _list;
  int _currentIndex = 0;

  void start() {
    _list = _getSliderData();
    notifyListeners();
  }

  void reset() {
    _list = null;
    _currentIndex = 0;
  }

  @override
  void dispose() {
    reset();
    super.dispose();
  }

  int goNext() {
    int nextIndex = _currentIndex++;
    if (nextIndex == _list!.length) {
      _currentIndex = 0;
    }
    return _currentIndex;
  }

  int goPrevious() {
    int previousIndex = _currentIndex--;
    if (previousIndex == -1) {
      _currentIndex = _list!.length - 1;
    }
    return _currentIndex;
  }

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<SliderObject> _getSliderData() => [
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
