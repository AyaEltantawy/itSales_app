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

  Future<void> _launchURL(BuildContext context) async {
    // Ensure link starts with http:// or https://
    final String fixedLink = link.startsWith('http://') || link.startsWith('https://')
        ? link
        : 'https://$link';

    final Uri uri = Uri.parse(fixedLink);

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch URL: $fixedLink')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error launching URL: $fixedLink')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
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
              onTap: () => _launchURL(context),
              child: Text(
                link,
                style: TextStyles.font16Weight300EmeraldWithoutLine.copyWith(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
