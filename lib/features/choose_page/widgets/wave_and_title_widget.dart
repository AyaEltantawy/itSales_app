import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_images.dart';
import 'package:svg_flutter/svg.dart';

class WaveSphereAndTitle extends StatelessWidget {
  const WaveSphereAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Image.asset(AppImages.stackLogo),
        SizedBox(height: 10.h,),
        SvgPicture.asset(
          AppImages.itSales,

        ),

      ],
    );
  }
}
