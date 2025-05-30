import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/components/app_buttons.dart';
import 'package:itsale/core/components/app_text_form_field.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/auth/screens/forget_password/forget_password_view.dart';
import 'package:itsale/features/auth/screens/reset_password/reset_password_view.dart';
import 'package:itsale/features/home/data/cubit.dart';
import 'package:itsale/features/profile/widgets/color_of_the_app/color_of_the_app_view.dart';
import 'package:itsale/features/profile/widgets/language_show_dialog/language_show_dialog_view.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/utils/validators.dart';
import '../../../generated/l10n.dart';
import '../../auth/data/cubit.dart';
import '../widgets/change_password_page/change_password_page_view.dart';
import '../widgets/custom_row_in_settings.dart';

class MainSettingsPage extends StatefulWidget {
  const MainSettingsPage({super.key});

  @override
  State<MainSettingsPage> createState() => _MainSettingsPageState();
}

class _MainSettingsPageState extends State<MainSettingsPage> {
  Future<void> _refreshData() async {
    AppCubit.get(context).getInfoLogin?.avatar?.data?.full_url.toString();
    setState(() {});
  }

  final key = GlobalKey<FormState>();

  bool isPasswordShown = false;

  onPassShowClicked() {
    setState(() {
      isPasswordShown = !isPasswordShown;
    });
  }

  var passController = TextEditingController();
  var verifyPassController = TextEditingController();
  bool click = true;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    var fName = TextEditingController();
    var lName = TextEditingController();
    var email = TextEditingController();
    //  var phone = TextEditingController();

    fName.text = cubit.getInfoLogin?.first_name.toString() ?? '';
    lName.text = cubit.getInfoLogin?.last_name.toString() ?? '';
    email.text = cubit.getInfoLogin?.email.toString() ?? '';
    // phone.text  = '${cubit.getInfo!.first_name.toString()} ${cubit.getInfo!.last_name.toString()}' ?? '';
    final user = AppCubit.get(context).getInfoLogin;
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        children: [
          const CustomAppBar(back: true, title: 'الاعدادات'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: .25,
                child: SizedBox(
                  height: 90.h,
                  width: 90.w, // wider width for image container
                  child: NetworkImageWithLoader(
                      fit: BoxFit.fill,
                      AppCubit.get(context)
                              .getInfoLogin
                              ?.avatar
                              ?.data
                              ?.full_url
                              ?.toString() ??
                          ""),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${user?.first_name ?? ''} ${user?.last_name ?? ''}',
                style: AppFonts.style16Normal,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                role == "1"
                    ? AppLocalizations.of(context)!.translate("manager")
                    : AppLocalizations.of(context)!.translate("employee"),
                style: AppFonts.style12light,
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomRowInSettings(
            text: "تعديل بيانات الحساب",
            onTap: () {
              navigateTo(context, AppRoutes.editDataPage);
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomRowInSettings(
            text: "تعديل كلمة السر",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgetPasswordPage()));
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomRowInSettings(
            text: "اللغة",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LanguageShowDialogPage()));
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          CustomRowInSettings(
            text: "لون التطبيق",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Color_of_the_appPage()));
            },
          )
        ],
      )),
    );
  }
}
