import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/features/auth/screens/login_page.dart';
import '../../../core/utils/transition.dart';
import '../widgets/account_type_card_widget.dart';
import '../widgets/wave_and_title_widget.dart';

class ChoosePage extends StatefulWidget {
  const ChoosePage({super.key});

  @override
  State<ChoosePage> createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  bool isEmployeeSelected = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [

                Positioned(

                  child: Image.asset(
                    AppImages.choosePageBanner,
                    height: 360.h,
                    width: double.infinity,
                    fit: BoxFit.cover,

                  ),
                ),
                Positioned(
                  right: 0.0,
                  left: 0.0,
                  bottom: 0.0,
                  child: Container(
                    height: 30.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.textWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        topRight:  Radius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  top:  isEmployeeSelected ? 55.h : 40.h,
                  right: isEmployeeSelected ? 75.h : 10.h,
                  child: const WaveSphereAndTitle(),
                ),

              ],
            ),

            Text(
              'اختر نوع الحساب',
              style: AppFonts.style20Bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: ()
                  {
                    Navigator.of(context).push(loginTransition(const LoginPage()));
                  },
                  child:   AccountTypeCard(
                    icon: AppImages.employee,
                    text: 'موظف',
                    backgroundColor: AppColors.coloredBackground,
                    borderColor: AppColors.primary,
                  ),
                ),

                InkWell(
                  onTap: ()
                  {
                    Navigator.of(context).push(loginTransition(const LoginPage()));
                  },
                  child:  AccountTypeCard(
                    icon: AppImages.manager,
                    text: 'مدير',
                    backgroundColor: AppColors.coloredBackground,
                    borderColor: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  AppDefaults.padding),
              child: defaultButton(context: context,
                  text: 'التالي', width: 343.w, height: 56.h, isColor: true, textSize: 20.sp, toPage: ()
                  {
                   // navigateTo(context, AppRoutes.login);
setState(() {
  isEmployeeSelected = false;
});
                  }),
            ),

          ],
        ),
      ),
    );
  }
}



