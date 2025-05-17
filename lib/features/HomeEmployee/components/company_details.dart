import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/themes/styles.dart';

class CompanyDetails extends StatelessWidget {
  final String companyName;
  final String number;
  final String email;
  final String link;

  const CompanyDetails({
    super.key,
    required this.companyName,
    required this.number,
    required this.email,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> launchURL() async {
      final Uri uri = Uri.parse(link);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $link';
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 20.h,
          bottom: 20.h,
          right: 20.w,
          left: 150.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              companyName,
              style: TextStyles.font20Weight500Primary,
            ),
            SizedBox(height: 10.h),
            Text(
              number,
              style: TextStyles.font16Weight300EmeraldWithoutLine,
            ),
            SizedBox(height: 10.h),
            Text(
              email,
              style: TextStyles.font16Weight300EmeraldWithoutLine,
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: launchURL,
              child: Text(
                link,
                style: TextStyles.font16Weight300EmeraldWithoutLine.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
