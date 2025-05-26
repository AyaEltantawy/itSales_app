import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/addEmployee/components/no_data_screen.dart';
import 'package:itsale/features/home/data/cubit.dart';
import 'package:itsale/features/home/data/states.dart';
import 'package:itsale/features/home/dialogs/product_filters_dialog.dart';
import 'package:svg_flutter/svg.dart';

import '../../../core/app/app.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/token.dart';
import '../../../core/utils/transition.dart';
import '../../../generated/l10n.dart';
import '../../Tasks_Screens/data/cubit/cubit.dart';
import '../../detailed_employee_screen/screens/detailed_employee_screens.dart';
import '../components/list_of_employees.dart';
import '../components/widgets_for_tasks_screen.dart';

class AllEmployeeScreen extends StatefulWidget {
  const AllEmployeeScreen({super.key, required this.admin, required this.task});

  final bool admin;
  final bool task;

  @override
  State<AllEmployeeScreen> createState() => _AllEmployeeScreenState();
}

class _AllEmployeeScreenState extends State<AllEmployeeScreen> {
  bool showSearch = false;

  @override
  void initState() {
    super.initState();
    EmployeeCubit.get(context).getAllSales();
    theRole = 0;
  }

  void toggleViewMode() {
    setState(() {
      showSearch = !showSearch;
    });
  }

  void _handleSearch(String value) {
    if (widget.task) {
      role == '1'
          ? TasksCubit.get(context).getAllTasksFunWithFilter(text: value)
          : TasksCubit.get(context).getAllTasksFunWithFilter(
              textEmp: value,
              employee: userId,
            );
    } else {
      EmployeeCubit.get(context).getAdmins(search: value);
    }
  }

  Future<void> _refreshData() async {
    if (widget.admin) {
      await EmployeeCubit.get(context).getAdmins();
    } else {
      await EmployeeCubit.get(context).getAllSales();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (widget.admin)
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Container(
                            height: 40.h,
                            width: 40.w,
                            padding: EdgeInsets.symmetric(horizontal: 11.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.scaffoldWithBoxBackground,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      if (widget.admin) SizedBox(width: 10.w),
                      Text(
                        widget.admin
                            ? AppLocalizations.of(context)!
                                .translate("managers")
                            : AppLocalizations.of(context)!.translate("users"),
                        style: AppFonts.style18medium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        child: BuildSearchFilter(
                          onTap: () {
                            setState(() {
                              showSearch = !showSearch;
                            });
                          },
                          emp: true,
                          isGrid: false,
                          toggleViewMode: toggleViewMode,
                          task: widget.task,
                          admin: widget.admin,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      if (!widget.admin)
                        GestureDetector(
                          onTap: () =>
                              navigateTo(context, AppRoutes.addEmployee),
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.h),
                            child: Icon(Icons.add,
                                color: Colors.white, size: 30.sp),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (showSearch) ...[
                SizedBox(height: 30.h),
                Container(
                    height: 40.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: globalDark
                          ? AppColors.cardColorDark
                          : AppColors.cardColor,
                      border: Border.all(
                        color: globalDark
                            ? AppColors.borderColorDark
                            : AppColors.borderColor,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(8.0.r),
                    ),
                    child: TextFormField(
                        textDirection: TextDirection.rtl,
                        onFieldSubmitted: (value) {
                          widget.task!
                              ? (role == '1'
                                  ? TasksCubit.get(context)
                                      .getAllTasksFunWithFilter(text: value)
                                  : TasksCubit.get(context)
                                      .getAllTasksFunWithFilter(
                                          textEmp: value, employee: userId))
                              : EmployeeCubit.get(context)
                                  .getAdmins(search: value.toString());
                        },
                        onChanged: (value) {
                          widget.task!
                              ? (role == '1'
                                  ? TasksCubit.get(context)
                                      .getAllTasksFunWithFilter(text: value)
                                  : TasksCubit.get(context)
                                      .getAllTasksFunWithFilter(
                                          textEmp: value, employee: userId))
                              : EmployeeCubit.get(context)
                                  .getAdmins(search: value.toString());
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(AppIcons.searchIcon),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 20.w),
                          prefixIconConstraints:
                              const BoxConstraints(minWidth: 20, minHeight: 20),
                          labelText: 'ابحث هنا',
                          labelStyle: AppFonts.style14normal,
                        )))
              ],
              SizedBox(height: 20.h),
              Expanded(
                child: widget.admin ? _buildAdminBloc() : _buildEmployeeBloc(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdminBloc() {
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = EmployeeCubit.get(context);

        if (state is NoInternetState) return const NoInternet();
        if (state is GetLoadingSearchEmployeeFilterState)
          return const LinearProgressIndicator();
        if (state is GetSuccessSearchEmployeeFilterState) {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: (cubit.searchUser?.isNotEmpty ?? false)
                ? buildEmployeeList(4)
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: nothing(context,
                          button: 'مسؤولين',
                          text: 'لا يوجد',
                          route: AppRoutes.addEmployee),
                    ),
                  ),
          );
        }
        if (state is GetErrorAdminsState)
          return Center(child: Text("للاسف حدث خطا"));
        if (state is GetLoadingAdminsState) return AppLottie.loader;

        return RefreshIndicator(
          onRefresh: _refreshData,
          child: (cubit.usersAdmin?.isNotEmpty ?? false)
              ? buildEmployeeList(1)
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: nothing(context,
                        button: 'مسؤولين',
                        text: 'لا يوجد مسؤولين',
                        route: AppRoutes.addEmployee),
                  ),
                ),
        );
      },
    );
  }

  Widget _buildEmployeeBloc() {
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = EmployeeCubit.get(context);

        if (state is GetErrorSalesState)
          return Center(child: Text("للاسف حدث خطأ"));
        if (state is GetLoadingSearchEmployeeFilterState)
          return const LinearProgressIndicator();
        if (state is GetSuccessSearchEmployeeFilterState) {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: (cubit.searchUser?.isNotEmpty ?? false)
                ? buildEmployeeList(4)
                : SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: nothing(context,
                          button: 'مستخدمين',
                          text: 'لا يوجد',
                          route: AppRoutes.addEmployee),
                    ),
                  ),
          );
        }
        if (state is GetLoadingSalesState) return AppLottie.loader;

        return RefreshIndicator(
          onRefresh: _refreshData,
          child: (cubit.users?.isNotEmpty ?? false)
              ? buildEmployeeList(theRole)
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: nothing(context,
                        button: 'مستخدمين',
                        text: 'لا يوجد مستخدمين',
                        route: AppRoutes.addEmployee),
                  ),
                ),
        );
      },
    );
  }

  Widget buildEmployeeList(int roleChoose) {
    log('Role chosen: $roleChoose');
    final cubit = EmployeeCubit.get(context);
    final usersList = switch (roleChoose) {
      0 => cubit.users,
      1 => cubit.usersAdmin,
      3 => cubit.usersEmployee,
      4 => cubit.searchUser,
      _ => cubit.users,
    };

    if (usersList == null || usersList.isEmpty) {
      return nothing(
        context,
        button: widget.admin ? 'مسؤولين' : 'مستخدمين',
        text: widget.admin ? 'لا يوجد مسؤولين' : 'لا يوجد مستخدمين',
        route: AppRoutes.addEmployee,
      );
    }

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: usersList.length,
        separatorBuilder: (_, __) => SizedBox(height: 8.h),
        itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (_) {
                    final employeeInfo = usersList[index].employee_info;
                    final info =
                        (employeeInfo != null && employeeInfo.isNotEmpty)
                            ? employeeInfo[0]
                            : null;

                    return EmployeeDetailsScreen(
                      name:
                          '${usersList[index].first_name} ${usersList[index].last_name}',
                      role: usersList[index].role?.id == 1 ? 'مدير' : 'موظف',
                      avatar:
                          usersList[index].avatar?.data?.full_url ?? 'لا يوجد',
                      phone1: info?.phone_1 ?? 'لا يوجد',
                      phone2: info?.phone_2 ?? 'لا يوجد',
                      empEmail: info?.email ?? 'لا يوجد',
                      whatsapp: info?.whatsapp ?? 'لا يوجد',
                      passwordToken:
                          usersList[index].passwordResetToken?.toString() ?? '',
                      id: usersList[index].id?.toString() ?? '',
                      email: usersList[index].email ?? 'لا يوجد',
                      address: info?.address ?? 'لا يوجد',
                    );
                  },
                )),
            child: buildEmployeeListItem(usersList[index])));
  }
}
