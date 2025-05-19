import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/components/network_image.dart';
import 'package:itsale/core/constants/app_animation.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/features/HomeEmployee/screens/home_employee.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import 'package:itsale/features/auth/data/states.dart';
import 'package:itsale/features/home/screens/employee_screen.dart';
import 'package:itsale/features/profile/widgets/change_password_page/change_password_page_view.dart';
import 'package:itsale/features/profile/widgets/help/help_view.dart';
import 'package:itsale/features/profile/widgets/language_show_dialog/language_show_dialog_cubit.dart';
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
import '../widgets/language_show_dialog/language_show_dialog_view.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _refreshData() async {
    AppCubit.get(context).getInfoLogin?.avatar?.data?.full_url.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:
            globalDark ? AppColors.cardColorDark : AppColors.cardColor,
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is ThemeState) {
                  globalDark = state.isDarkMode;
                } else {
                  globalDark = context.read<AppCubit>().isDarkMode;
                }
                if (state is NoInternetAppState) {
                  return const NoInternet();
                }

                final user = AppCubit.get(context).getInfoLogin;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppDefaults.padding,
                          vertical: AppDefaults.padding / 2),
                      child: Text(
                          AppLocalizations.of(context)!.translate("menu"),
                          style: AppFonts.style20medium),
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
                          user?.avatar?.data == null
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      right: 8.0.w, left: 10.0.w),
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
                                  padding: EdgeInsets.only(
                                      right: 8.0.w, left: 10.0.w),
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: NetworkImageWithLoader(
                                      user!.avatar!.data!.full_url.toString(),
                                    ),
                                  ),
                                ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${user?.first_name ?? ''} ${user?.last_name ?? ''}',
                                style: AppFonts.style16Normal,
                              ),
                              Text(
                                role == "1"
                                    ? AppLocalizations.of(context)!
                                        .translate("manager")
                                    : AppLocalizations.of(context)!
                                        .translate("employee"),
                                style: AppFonts.style12light,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
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
                          if (role == '1')
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AllEmployeeScreen(
                                            task: false, admin: true),
                                  ),
                                );
                              },
                              child: AppSettingsListTile(
                                style: AppFonts.style16semiBold,
                                widget: Icon(AppIcons.persons,
                                    color: globalDark
                                        ? AppColors.textWhite
                                        : AppColors.textBlack),
                                label: AppLocalizations.of(context)!
                                    .translate("managers"),
                              ),
                            ),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.tasks,
                                color: globalDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack),
                            label: AppLocalizations.of(context)!
                                .translate("tasks"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TasksScreenForEmployee(back: true),
                                ),
                              );
                            },
                          ),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppLottie.report,
                                color: globalDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack),
                            label: AppLocalizations.of(context)!
                                .translate("reports"),
                            onTap: () =>
                                navigateTo(context, AppRoutes.reportsPge),
                          ),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.notifications,
                                color: globalDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack),
                            label: AppLocalizations.of(context)!
                                .translate("notifications"),
                            onTap: () =>
                                navigateTo(context, AppRoutes.notifications),
                          ),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.settings,
                                color: globalDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack),
                            label: AppLocalizations.of(context)!
                                .translate("settings"),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainSettingsPage())),
                          ),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.password,
                                color: globalDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack),
                            label: AppLocalizations.of(context)!
                                .translate("change_password"),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordPage())),
                          ),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.help,
                                color: globalDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack),
                            label:
                                AppLocalizations.of(context)!.translate("help"),
                            onTap: () => navigateTo(context, AppRoutes.helpPge),
                          ),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBold,
                            widget: Icon(AppIcons.language,
                                color: globalDark
                                    ? AppColors.textWhite
                                    : AppColors.textBlack),
                            label: AppLocalizations.of(context)!
                                .translate("language"),
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) => LanguageShowDialogPage()),
                          ),
                          BlocBuilder<AppCubit, AppStates>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  Icon(Icons.dark_mode_outlined,
                                      color: globalDark
                                          ? AppColors.textWhite
                                          : AppColors.textBlack),
                                  SizedBox(width: 10.w),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .translate("dark_mode"),
                                      style: AppFonts.style16semiBold),
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
                          SizedBox(height: 20.h),
                          AppSettingsListTile(
                            style: AppFonts.style16semiBoldError,
                            widget: const Icon(AppIcons.logOut,
                                color: AppColors.errorColor),
                            label: AppLocalizations.of(context)!
                                .translate("sign_out"),
                            onTap: () async {
                              await CacheHelper.clearAll().then((value) {
                                if (value) navigateTo(context, AppRoutes.login);
                              });
                            },
                          ),
                          SizedBox(height: 30.h),
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
      ),
    );
  }
}
