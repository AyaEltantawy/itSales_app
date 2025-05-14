import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
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

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => widget.task ? const FilterDialog() : RoleDialog(),
    );
  }

  void toggleViewMode() {
    setState(() {
      showSearch = !showSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshData() async {
      if (role == '1') {
        await TasksCubit.get(context).getAllTasksFun();
      } else {
        await TasksCubit.get(context).getUserTaskFun(userId: userId.toString());
      }
      // Optional: call setState if needed
    }

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
                        widget.admin ? 'المسؤولين' : 'المستخدمين',
                        style: AppFonts.style18medium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50.h,
                        width: 100,
                        child: BuildSearchFilter(
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
                            child: const Icon(Icons.add),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (showSearch) ...[
                SizedBox(height: 80.h),
                Container(
                  width: double.infinity,
                  height: 40.h,
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
                    onChanged: _handleSearch,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AppIcons.searchIcon),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      labelText: 'ابحث هنا',
                      labelStyle: AppFonts.style14normal,
                    ),
                  ),
                ),
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

  void _handleSearch(String value) {
    if (widget.task) {
      role == '1'
          ? TasksCubit.get(context).getAllTasksFunWithFilter(text: value)
          : TasksCubit.get(context)
              .getAllTasksFunWithFilter(textEmp: value, employee: userId);
    } else {
      EmployeeCubit.get(context).getAdmins(search: value);
    }
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
          return cubit.searchUser?.isNotEmpty ?? false
              ? buildEmployeeList(4)
              : nothing(context,
                  button: 'مسؤولين',
                  text: 'لا يوجد',
                  route: AppRoutes.addEmployee);
        }
        if (state is GetErrorAdminsState)
          return Center(child: Text(S.of(context).sorry_error_occurred));
        if (state is GetLoadingAdminsState) return AppLottie.loader;

        return cubit.usersAdmin?.isNotEmpty ?? false
            ? buildEmployeeList(1)
            : nothing(context,
                button: 'مسؤولين',
                text: 'لا يوجد مسؤولين',
                route: AppRoutes.addEmployee);
      },
    );
  }

  Widget _buildEmployeeBloc() {
    return BlocConsumer<EmployeeCubit, EmployeeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = EmployeeCubit.get(context);

        if (state is GetErrorSalesState)
          return Center(child: Text(S.of(context).sorry_error));
        if (state is GetLoadingSearchEmployeeFilterState)
          return const LinearProgressIndicator();
        if (state is GetSuccessSearchEmployeeFilterState) {
          return cubit.searchUser?.isNotEmpty ?? false
              ? buildEmployeeList(4)
              : nothing(context,
                  button: 'مستخدمين',
                  text: 'لا يوجد',
                  route: AppRoutes.addEmployee);
        }
        if (state is GetLoadingSalesState) return AppLottie.loader;

        return cubit.users?.isNotEmpty ?? false
            ? buildEmployeeList(theRole)
            : nothing(context,
                button: 'مستخدمين',
                text: 'لا يوجد مستخدمين',
                route: AppRoutes.addEmployee);
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
      physics: const BouncingScrollPhysics(),
      itemCount: usersList.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EmployeeDetailsScreen(
              name:
                  '${usersList[index].first_name} ${usersList[index].last_name}',
              role: usersList[index].role?.id == 1 ? 'مدير' : 'موظف',
              avatar: usersList[index].avatar?.data?.full_url ?? 'لا يوجد',
              phone1: usersList[index].employee_info?[0].phone_1 ?? 'لا يوجد',
              phone2: usersList[index].employee_info?[0].phone_2 ?? 'لا يوجد',
              empEmail: usersList[index].employee_info?[0].email ?? 'لا يوجد',
              whatsapp:
                  usersList[index].employee_info?[0].whatsapp ?? 'لا يوجد',
              passwordToken:
                  usersList[index].passwordResetToken?.toString() ?? '',
              id: usersList[index].id?.toString() ?? '',
              email: usersList[index].email ?? 'لا يوجد',
              address: usersList[index].employee_info?[0].address ?? 'لا يوجد',
            ),
          ),
        ),
        child: buildEmployeeListItem(usersList[index]),
      ),
    );
  }
}
