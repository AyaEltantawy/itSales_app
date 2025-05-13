import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/styles.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> launchURL() async {
      const url = 'https://flutter.dev'; // Replace with your desired URL
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    return Container(

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(width: 1, color: Colors.black)

      ),
      child: Padding(
          padding: EdgeInsets.only(
              top: 20.h, bottom: 20.h, right: 20.w, left: 150.w),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Text("شركة السيارات",
            style: TextStyles.font20Weight500Primary,),
          SizedBox(height: 10.h,),
          Text("013456678989", style: TextStyles.font16Weight300EmeraldWithoutLine,),
          SizedBox(height: 10.h,),
          Text("car@gmail.com", style: TextStyles.font16Weight300EmeraldWithoutLine,),
              SizedBox(height: 10.h,),
          GestureDetector(
            onTap: launchURL, // Opens the URL when tapped
            child: Text(
              'https://flutter.dev',
              style:  TextStyles.font16Weight300EmeraldWithoutLine.copyWith(
                decoration: TextDecoration.underline,),

              // Optional: Adds an underline
            ),

          )],


    ),)
    ,

    );
  }
}
