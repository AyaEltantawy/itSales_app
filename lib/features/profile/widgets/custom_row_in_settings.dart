
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_fonts.dart';

class CustomRowInSettings extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const CustomRowInSettings({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return InkWell(onTap: onTap,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(text, style: AppFonts.style16Normal,),
        Icon(Icons.arrow_forward_ios_outlined,size: 20.sp,)

      ],
      ),
    );


  }
}
