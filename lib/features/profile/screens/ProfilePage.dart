import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/core/constants/app_animation.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/features/HomeEmployee/screens/home_employee.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import 'package:itsale/features/auth/data/states.dart';
import 'package:itsale/features/home/screens/employee_screen.dart';
import 'package:itsale/features/profile/widgets/change_password_page/change_password_page_view.dart';
import 'package:itsale/features/profile/widgets/help/help_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/app/app.dart';
import '../../../core/cache_helper/cache_helper.dart';
import '../../../core/components/app_settings_tile.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/token.dart';
import '../../../generated/l10n.dart';
import '../../Tasks_Screens/screens/tasks.dart';
import '../../home/dialogs/not_work.dart';
import '../settings/MainSettingPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    //log(AppCubit.get(context).getInfo!.avatar!.data!.full_url.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            globalDark ? AppColors.cardColorDark : AppColors.cardColor,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              // if (state is ThemeState) {
              //   globalDark = state.isDarkMode;
              // } else {
              //   globalDark = context
              //       .read<AppCubit>()
              //       .isDarkMode;
              // }
            },
            builder: (context, state) {
              if (state is ThemeState) {
                globalDark = state.isDarkMode;
              } else {
                globalDark = context.read<AppCubit>().isDarkMode;
              }
              if (state is NoInternetAppState) {
                return const NoInternet();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding,
                        vertical: AppDefaults.padding / 2),
                    child: Text(
                      S.of(context).menu,
                      style: AppFonts.style20medium,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppDefaults.padding),
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: globalDark
                          ? AppColors.cardColorDark
                          : AppColors.cardColor,
                      borderRadius: AppDefaults.borderRadius,
                    ),
                    child: Row(
                      children: [
                        AppCubit.get(context).getInfo!.avatar?.data == null
                            ? Padding(
                                padding:
                                    EdgeInsets.only(right: 8.0.w, left: 10.0.w),
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.gray,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.only(right: 8.0.w, left: 10.0.w),
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    // color: AppColors.gray,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: NetworkImageWithLoader(
                                      AppCubit.get(context)
                                          .getInfo!
                                          .avatar!
                                          .data!
                                          .full_url
                                          .toString()),
                                ),
                              ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppCubit.get(context).getInfo!.first_name.toString()} ${AppCubit.get(context).getInfo!.last_name.toString()}',
                              style: AppFonts.style16Normal,
                            ),
                            Text(
                              role == "1" ? 'مدير' : 'موظف',
                              style: AppFonts.style12light,
                            ),
                          ],
                        ),
                        // const  Spacer(),
                        // Padding(
                        //   padding:  EdgeInsets.only(left: 8.w),
                        //   child: const Icon(Icons.arrow_forward_ios_outlined),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    //  margin: const EdgeInsets.all(AppDefaults.padding ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding,
                      vertical: AppDefaults.padding * 2,
                    ),
                    decoration: BoxDecoration(
                      color: globalDark
                          ? AppColors.cardColorDark
                          : AppColors.cardColor,
                      borderRadius: AppDefaults.borderRadius,
                    ),
                    child: Column(
                      children: [
                        //  AppSettingsListTile(
                        // widget: SvgPicture.asset(AppIcons.grid),
                        //    label: 'الرئيسية',
                        //    style: AppFonts.style16MediumColor,
                        //
                        //  ),
                        role == '1'
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AllEmployeeScreen(
                                                admin: true),
                                      ));
                                },
                                child: AppSettingsListTile(
                                  style: AppFonts.style16semiBold,
                                  widget: Icon(AppIcons.persons,
                                    color: AppCubit.get(context).isDarkMode
                                        ? AppColors.textWhite
                                        : AppColors.textBlack,
                                  ),
                                  label: 'المسؤولين',
                                ),
                              )
                            : Container(),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.tasks,
                              color: AppCubit.get(context).isDarkMode
                                  ? AppColors.textWhite
                                  : AppColors.textBlack,
                            ),
                            label: 'المهام',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TasksScreenForEmployee(
                                            back: true),
                                  ));
                            }
                            //  Navigator.pushNamed(context, AppRoutes.changePassword),
                            ),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget:

                               Icon( AppLottie.report,
                                color: AppCubit.get(context).isDarkMode
                                    ? AppColors.textWhite
                                    : AppColors.textBlack,

                            ),
                            label: 'التقارير',
                            onTap: () {
                              navigateTo(context, AppRoutes.reportsPge);
                            }
                            // Navigator.pushNamed(context, AppRoutes.changePhoneNumber),
                            ),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget:
                           Icon( AppIcons.notifications,
                                color: AppCubit.get(context).isDarkMode
                                    ? AppColors.textWhite
                                    : AppColors.textBlack,

                            ),
                            label: 'الاشعارات',
                            onTap: () {
                              navigateTo(context, AppRoutes.notifications);
                            }
                            //  Navigator.pushNamed(context, AppRoutes.notifications),
                            ),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.settings,
                              color: AppCubit.get(context).isDarkMode
                                  ? AppColors.textWhite
                                  : AppColors.textBlack,
                            ),
                            label: 'الاعدادات',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainSettingsPage(),
                                  ));
                            }
                            //  Navigator.pushNamed(context, AppRoutes.profileEdit),
                            ),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.settings,
                              color: AppCubit.get(context).isDarkMode
                                  ? AppColors.textWhite
                                  : AppColors.textBlack,
                            ),
                            label: 'تغيير كلمة المرور',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChangePasswordPage(),
                                  ));
                            }
                          //  Navigator.pushNamed(context, AppRoutes.profileEdit),
                        ),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(
                              AppIcons.help,
                              color: AppCubit.get(context).isDarkMode
                                  ? AppColors.textWhite
                                  : AppColors.textBlack,
                            ),
                            label: 'المساعدة',
                            onTap: () {
                              navigateTo(context, AppRoutes.helpPge);
                            }
                            //  Navigator.pushNamed(context, AppRoutes.profileEdit),
                            ),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(
                              AppIcons.help,
                              color: AppCubit.get(context).isDarkMode
                                  ? AppColors.textWhite
                                  : AppColors.textBlack,
                            ),
                            label: 'اللغة',
                            onTap: () {
                              navigateTo(context, AppRoutes.helpPge);
                            }
                          //  Navigator.pushNamed(context, AppRoutes.profileEdit),
                        ),
                        BlocBuilder<AppCubit, AppStates>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Icon(
                                  Icons.dark_mode_outlined,
                                  color: globalDark
                                      ? AppColors.textWhite
                                      : AppColors.textBlack,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'الوضع الليلي',
                                  style: AppFonts.style16semiBold,
                                ),
                                const Spacer(),
                                Switch(
                                  value: AppCubit.get(context).isDarkMode,
                                  onChanged: (value) {
                                    context.read<AppCubit>().toggleTheme();

                                    setState(() {});
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AppSettingsListTile(
                            style: AppFonts.style16semiBoldError,
                            widget: const Icon(
                              AppIcons.logOut,
                              color: AppColors.errorColor,
                            ),
                            label: 'تسجيل الخروج',
                            onTap: () async {
                              await CacheHelper.clearAll().then((value) {
                                value = true;
                                if (value) {
                                  navigateTo(context, AppRoutes.login);
                                }
                              });
                            }
                            //   Navigator.pushNamed(context, AppRoutes.login),
                            ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Image.asset(AppImages.company),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
