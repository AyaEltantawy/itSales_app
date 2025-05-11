import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/cache_helper/cache_helper.dart';
import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';
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
   CacheHelper.saveData(key: 'seen',value: true) ;

      _gotoLoginSignUp();
    }
  }

  _gotoLoginSignUp() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login,(route) => false,);
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
        child: Column(
          children: [
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
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                TweenAnimationBuilder(
                  duration: AppDefaults.duration,
                  tween: Tween<double>(
                      begin: 0, end: (1 / items.length) * (currentPage + 1)),
                  curve: Curves.easeInOutBack,
                  builder: (context, double value, _) => SizedBox(
                    height: 70.h,
                    width: 75.w,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 5,
                      backgroundColor: AppColors.cardColor,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                InkWell(
                  onTap: _gotoNextPage,
                  child: Container(

                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    margin: EdgeInsets.symmetric(horizontal: 10.w),
                    height: 60.h,
                    width: 60.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary
                    ),
                    child: const Center(
                      child:  Padding(
                        padding:  EdgeInsets.all(8.0),
                        child:  Icon(
                          AppIcons.arrowBackward,

                          color:
                            Colors.white,


                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: AppDefaults.padding.h),
          ],
        ),
      ),
    );
  }
}
