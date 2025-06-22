import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_fonts.dart' show AppFonts;
import '../../../../core/localization/app_localizations.dart';
import '../../../addEmployee/components/report_chart.dart' show ReportChart;
import 'help_cubit.dart';
import 'help_state.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => HelpCubit(),
        child: Scaffold(
            body: SafeArea(
                child: BlocBuilder<HelpCubit, HelpState>(
                  builder: (context, state) {
                    final controller=BlocProvider.of<HelpCubit>(context);
                    return ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate("help")
                          ,
                          style: AppFonts.style16semiBold,
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                            onTap: controller.launchURL, // Opens the URL when tapped
                            child: const Text(
                            'https://flutter.dev',
                            style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline, // Optional: Adds an underline
                        ),

                    ))],

                    );
                  },
                ))));
  }
}
