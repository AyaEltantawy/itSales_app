import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/cache_helper/cache_helper.dart';
import '../../core/components/app_buttons.dart';
import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';
import '../auth/screens/choose_login_or_sign_up/choose_login_or_sign_up_view.dart';
import 'components/onboarding_view.dart';
import 'data/onboarding_data.dart';
import 'data/onboarding_model.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  late PageController controller;
  List<OnboardingModel> items = OnboardingData.items;

  onPageChange(int value) {
    currentPage = value;
    setState(() {});
  }

  _gotoNextPage() {
    if (currentPage < items.length - 1) {
      controller.nextPage(
        duration: AppDefaults.duration,
        curve: Curves.ease,
      );
    } else {
      CacheHelper.saveData(key: 'seen', value: true);

      _gotoLoginSignUp();
    }
  }

  _gotoPreviousPage() {
    if (currentPage > 0) {
      controller.previousPage(
        duration: AppDefaults.duration,
        curve: Curves.ease,
      );
    }
  }

  _gotoLoginSignUp() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        const Spacer(),
        SmoothPageIndicator(
          controller: controller,
          effect: const ExpandingDotsEffect(
            dotColor: Colors.grey,
            activeDotColor: AppColors.primary,
            expansionFactor: 3,
            spacing: 5.0,
            dotHeight: 10.0,
            dotWidth: 10.0,
          ),
          count: items.length,
        ),
        Expanded(
          flex: 8,
          child: PageView.builder(
            onPageChanged: onPageChange,
            itemCount: items.length,
            controller: controller,
            itemBuilder: (context, index) {
              return OnboardingView(
                data: items[index],
              );
            },
          ),
        ),
        const Spacer(),

        if (currentPage == 0)
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 120.w),
              child: defaultButton(
                  width: 160.w,
                  height: 56.h,
                  text: "ابدء الآن",
                  isColor: true,
                  textSize: 15.sp,
                  toPage: _gotoNextPage,
                  context: context),
            ),
          ),
        SizedBox(height: AppDefaults.padding.h),
        if (currentPage == 1)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    defaultButton(
                      width: 160.w,
                      height: 56.h,
                      text: "التالي",
                      isColor: true,
                      textSize: 15.sp,
                      toPage: _gotoNextPage,
                      context: context,
                    ),
                    defaultButton(
                      width: 160.w,
                      height: 56.h,
                      text: "عودة",
                      isColor: false,
                      textSize: 15.sp,
                      toPage: _gotoPreviousPage,
                      context: context,
                    ),
                  ],
                ),
                SizedBox(height: AppDefaults.padding.h),
              ],
            ),
          ),

        if (currentPage == 2)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultButton(
                  width: 160.w,
                  height: 56.h,
                  text: "تسجيل الدخول",
                  isColor: true,
                  textSize: 15.sp,
                  toPage: () {
                    navigateTo(context,AppRoutes.chooseLoginOrSignUpPage);
                  },
                  context: context,
                ),
                defaultButton(
                  width: 160.w,
                  height: 56.h,
                  text: "عودة",
                  isColor: false,
                  textSize: 15.sp,
                  toPage: _gotoPreviousPage,
                  context: context,
                ),
              ],
            ),
          ),
        SizedBox(height: AppDefaults.padding.h),
      ]),
    ));
  }
}
