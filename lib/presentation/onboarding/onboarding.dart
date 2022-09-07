import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvvm/domain/model/model.dart';
import 'package:flutter_mvvm/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:flutter_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_mvvm/presentation/resources/value_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    Provider.of<OnBoardingViewModel>(context, listen: false).start();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<OnBoardingViewModel>(context, listen: false).dispose();
    super.dispose();
  }

  Widget _getContentWidget(OnBoardingViewModel onBoardingProvider) {
    return Scaffold(
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
        itemCount: onBoardingProvider.length,
        onPageChanged: (idx) => onBoardingProvider.onPageChanged(idx),
        itemBuilder: (ctx, idx) {
          return OnBoardingPage(onBoardingProvider.list[idx]);
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
            _getBottomSheetWidget(onBoardingProvider)
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(OnBoardingViewModel onBoardingProvider) {
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
                _pageController.animateToPage(onBoardingProvider.goPrevious(),
                    duration: const Duration(
                      milliseconds: DurationConstant.d300,
                    ),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
          // circles indicator
          Consumer<OnBoardingViewModel>(
            builder: (_, __, ___) {
              return Row(
                children: List.generate(
                  onBoardingProvider.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(
                      AppPadding.p8,
                    ),
                    child: _getProperCircle(
                        index, onBoardingProvider.currentIndex),
                  ),
                ),
              );
            },
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
                _pageController.animateToPage(onBoardingProvider.goNext(),
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
    final viewModel = Provider.of<OnBoardingViewModel>(context, listen: false);
    return _getContentWidget(viewModel);
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _silderObject;

  const OnBoardingPage(this._silderObject, {Key? key}) : super(key: key);

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
