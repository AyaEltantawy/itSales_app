import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/constants/app_images.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/features/onboarding/onboarding_page.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/token.dart';
import '../../core/utils/transition.dart';
import '../auth/data/cubit.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    Future.delayed(const Duration(seconds: 4), () {
      bool seenOnBoarding = CacheHelper.getBool(key: 'seen') ?? false;

      if (seenOnBoarding) {
       navigateTo(context, AppRoutes.entryPoint);

      }
        else {
        token != null ? navigateTo(context, AppRoutes.entryPoint) :
        Navigator.of(context).pushAndRemoveUntil(
          loginTransition(const OnBoardingPage()), (route) => false,);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(

              height: 270.h,
            ),
            SizedBox(
              width: 220.w,
              height: 130.h,
              child: Image.asset(AppCubit.get(context).isDarkMode ?
              AppImages.finalLogoDark :  AppImages.finalLogo,


              ),
            ),

            // SvgPicture.asset(AppImages.itSales,
            //   color: AppColors.textBlack,
            //   ),
          ],
        ),
      ),
    );
  }
}
