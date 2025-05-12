

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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
      }   }
    return Container(

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.sp),
      border: Border.all(width: 1,color: Colors.black)

      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("شركه تاجير السيارات"),
            SizedBox(height: 10.h,),
              Text("013456678989"),
            SizedBox(height: 10.h,),
            Text("car@gmail.com"),
            GestureDetector(
                onTap: launchURL, // Opens the URL when tapped
                child: const Text(
                  'https://flutter.dev',
                  style: TextStyle(
                    color: Colors.black,
                    decoration: TextDecoration.underline, // Optional: Adds an underline
                  ),

                ))],



        ),
      ),

    );
  }
}
