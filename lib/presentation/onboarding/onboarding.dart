import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/domain/model.dart';
import 'package:flutter_mvvm/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);

  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    return sliderViewObject == null
        ? Container()
        : Scaffold(
            backgroundColor: ColorManager.white,
            appBar: AppBar(
              backgroundColor: ColorManager.white,
              elevation: AppSize.s0,
              // 상단바 디자인
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorManager.white,
                statusBarBrightness: Brightness.dark,
              ),
            ),
            body: PageView.builder(
              controller: _pageController,
              itemCount: sliderViewObject.numOfSildes,
              onPageChanged: (idx) => _viewModel.onPageChanged(idx),
              itemBuilder: (ctx, idx) {
                return OnBoardingPage(sliderViewObject.sliderObject);
              },
            ),
            bottomSheet: Container(
              color: ColorManager.white,
              height: AppSize.s100,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.skip,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                  _getBottomSheetWidget(sliderViewObject)
                ],
              ),
            ),
          );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIcon),
              ),
              onTap: () {
                // go to previous slide
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                      milliseconds: DurationConstant.d300,
                    ),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
          // circles indicator
          Row(
            children: List.generate(
              sliderViewObject.numOfSildes,
              (index) => Padding(
                padding: const EdgeInsets.all(
                  AppPadding.p8,
                ),
                child: _getProperCircle(index, sliderViewObject.currentIndex),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIcon),
              ),
              onTap: () {
                // go to next slide
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                      milliseconds: DurationConstant.d300,
                    ),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    return index == currentIndex
        ? SvgPicture.asset(ImageAssets.solidCircleIcon)
        : SvgPicture.asset(ImageAssets.hollowCircleIcon);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  SliderObject _silderObject;

  OnBoardingPage(this._silderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _silderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _silderObject.subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(_silderObject.image)
      ],
    );
  }
}