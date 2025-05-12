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

import '../../../core/constants/app_animation.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/token.dart';
import '../../../core/utils/transition.dart';
import '../../../generated/l10n.dart';
import '../../detailed_employee_screen/screens/detailed_employee_screens.dart';
import '../components/list_of_employees.dart';
import '../components/widgets_for_tasks_screen.dart';

class AllEmployeeScreen extends StatefulWidget {
  const AllEmployeeScreen({super.key, required this.admin});

  final bool admin;

  @override
  State<AllEmployeeScreen> createState() => _AllEmployeeScreenState();
}

class _AllEmployeeScreenState extends State<AllEmployeeScreen> {
  @override
  void initState() {
    EmployeeCubit.get(context).getAllSales();
    theRole = 0;
    // TODO: implement initState
    super.initState();
  }

  toggleViewMode() {}

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
                      widget.admin
                          ? IconButton(
                              padding: EdgeInsets.zero,
                              icon: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 11.w),
                                  margin: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.scaffoldWithBoxBackground,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 22,
                                  )),
                              onPressed: () {
                                Navigator.pop(context);
                                // ClinicCubit.get(context).clearData();
                              },
                            )
                          : Container(),
                      widget.admin
                          ? SizedBox(
                              width: 10.w,
                            )
                          : const SizedBox(),
                      Text(
                        widget.admin ? 'المسؤولين' : 'المستخدمين',
                        style: AppFonts.style18medium,
                      ),
                    ],
                  ),
                  widget.admin
                      ? Container()
                      : InkWell(
                          onTap: () {
                            navigateTo(context, AppRoutes.addEmployee);
                          },
                          child: addEmployee('موظف', AppFonts.style12colored,
                              AppColors.borderColorDark)),
                ],
              ),
              SizedBox(height: 16.h),
              BuildSearchFilter(
                  emp: true,
                  isGrid: false,
                  toggleViewMode: toggleViewMode,
                  task: false,
                  admin: widget.admin),
              SizedBox(height: 24.h),

              widget.admin
                  ? BlocConsumer<EmployeeCubit, EmployeeStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is NoInternetState) {
                          return const NoInternet();
                        }
                        if (state is GetLoadingSearchEmployeeFilterState) {
                          return const LinearProgressIndicator();
                        }
                        if (state is GetSuccessSearchEmployeeFilterState) {
                          return EmployeeCubit.get(context)
                                  .searchUser!
                                  .isNotEmpty
                              ? Expanded(child: buildEmployeeList(4))
                              : nothing(context,
                                  button: widget.admin ? 'مسؤولين' : 'مستخدمين',
                                  text: widget.admin ? 'لا يوجد' : 'لا يوجد',
                                  route: AppRoutes.addEmployee);
                        }

                        if (state is GetErrorAdminsState) {
                          return Center(
                              child: Text(S.of(context).sorry_error_occurred));
                        }
                        if (state is GetLoadingAdminsState) {
                          return AppLottie.loader;
                        }
                        return EmployeeCubit.get(context).usersAdmin!.isNotEmpty
                            ? Expanded(child: buildEmployeeList(1))
                            : nothing(context,
                                button: widget.admin ? 'مسؤولين' : 'مستخدمين',
                                text: widget.admin
                                    ? 'لا يوجد مسؤولين'
                                    : 'لا يوجد مستخدمين',
                                route: AppRoutes.addEmployee);
                      })
                  : BlocConsumer<EmployeeCubit, EmployeeStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is GetErrorSalesState) {
                          return Center(child: Text(S.of(context).sorry_error));
                        }

                        if (state is GetLoadingSearchEmployeeFilterState) {
                          return const LinearProgressIndicator();
                        }
                        if (state is GetSuccessSearchEmployeeFilterState) {
                          return EmployeeCubit.get(context)
                                  .searchUser!
                                  .isNotEmpty
                              ? Expanded(child: buildEmployeeList(4))
                              : nothing(context,
                                  button: widget.admin ? 'مسؤولين' : 'مستخدمين',
                                  text: widget.admin ? 'لا يوجد' : 'لا يوجد',
                                  route: AppRoutes.addEmployee);
                        }
                        if (state is GetLoadingSalesState) {
                          return AppLottie.loader;
                        }
                        return EmployeeCubit.get(context).users!.isNotEmpty
                            ? Expanded(child: buildEmployeeList(theRole))
                            : nothing(context,
                                button: 'مستخدمين',
                                text: 'لا يوجد مستخدمين',
                                route: AppRoutes.addEmployee);
                      }),
              // Expanded(child: buildTaskList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmployeeList(int roleChoose) {
    log('the role :$roleChoose');
    var cubit = EmployeeCubit.get(context);
    switch (roleChoose) {
      case 0:
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.users!.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(
                        avatar: cubit.users![index].avatar != null
                            ? cubit.users![index].avatar!.data!.full_url
                                .toString()
                            : 'لا يوجد',
                        phone1: cubit.users![index].employee_info![0].phone_1 ??
                            'لا يوجد',
                        phone2: cubit.users![index].employee_info![0].phone_2 ??
                            'لا يوجد',
                        empEmail: cubit.users![index].employee_info![0].email ??
                            'لا يوجد',
                        whatsapp:
                            cubit.users![index].employee_info![0].whatsapp ??
                                'لا يوجد',
                        passwordToken:
                            cubit.users![index].passwordResetToken.toString(),
                        id: cubit.users![index].id.toString(),
                        email: cubit.users![index].email ?? 'لا يوجد',
                        address:
                            cubit.users![index].employee_info![0].address ??
                                'لا يوجد',
                        name:
                            '${cubit.users![index].first_name} ${cubit.users![index].last_name}',
                        role:
                            cubit.users![index].role!.id == 1 ? 'مدير' : 'موظف',
                      ),
                    ));
              },
              child: buildEmployeeListItem(cubit.users![index]),
            );
          },
        );
      case 1:
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.usersAdmin!.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                role == '1'
                    ? Navigator.push(
                        context,
                        animatedNavigation(
                          screen: EmployeeDetailsScreen(
                            name:
                                '${cubit.usersAdmin![index].first_name} ${cubit.usersAdmin![index].last_name}',
                            role: cubit.usersAdmin![index].role!.id == 1
                                ? 'مدير'
                                : 'موظف',
                            avatar: cubit.usersAdmin![index].avatar != null
                                ? cubit
                                    .usersAdmin![index].avatar!.data!.full_url
                                    .toString()
                                : 'لا يوجد',
                            phone1: cubit.usersAdmin![index].employee_info![0]
                                    .phone_1 ??
                                'لا يوجد',
                            phone2: cubit.usersAdmin![index].employee_info![0]
                                    .phone_2 ??
                                'لا يوجد',
                            empEmail: cubit.usersAdmin![index].employee_info![0]
                                    .email ??
                                'لا يوجد',
                            whatsapp: cubit.usersAdmin![index].employee_info![0]
                                    .whatsapp ??
                                'لا يوجد',
                            passwordToken: cubit
                                .usersAdmin![index].passwordResetToken
                                .toString(),
                            id: cubit.usersAdmin![index].id.toString(),
                            email: cubit.usersAdmin![index].email ?? 'لا يوجد',
                            address: cubit.usersAdmin![index].employee_info![0]
                                    .address ??
                                'لا يوجد',
                          ),
                        ))
                    : Container();
              },
              child: buildEmployeeListItem(cubit.usersAdmin![index]),
            );
          },
        );
      case 3:
        return EmployeeCubit.get(context).usersEmployee!.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.usersEmployee!.length,
                separatorBuilder: (context, index) => SizedBox(height: 8.h),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeDetailsScreen(
                              name:
                                  '${cubit.usersEmployee![index].first_name} ${cubit.usersEmployee![index].last_name}',
                              role: cubit.usersEmployee![index].role!.id == 1
                                  ? 'مدير'
                                  : 'موظف',
                              avatar: cubit.usersEmployee![index].avatar != null
                                  ? cubit.usersEmployee![index].avatar!.data!
                                      .full_url
                                      .toString()
                                  : 'لا يوجد',
                              phone1: cubit.usersEmployee![index]
                                      .employee_info![0].phone_1 ??
                                  'لا يوجد',
                              phone2: cubit.usersEmployee![index]
                                      .employee_info![0].phone_2 ??
                                  'لا يوجد',
                              empEmail: cubit.usersEmployee![index]
                                      .employee_info![0].email ??
                                  'لا يوجد',
                              whatsapp: cubit.usersEmployee![index]
                                      .employee_info![0].whatsapp ??
                                  'لا يوجد',
                              passwordToken: cubit
                                  .usersEmployee![index].passwordResetToken
                                  .toString(),
                              id: cubit.usersEmployee![index].id.toString(),
                              email: cubit.usersEmployee![index].email ??
                                  'لا يوجد',
                              address: cubit.usersEmployee![index]
                                      .employee_info![0].address ??
                                  'لا يوجد',
                            ),
                          ));
                    },
                    child: buildEmployeeListItem(cubit.usersEmployee![index]),
                  );
                },
              )
            : nothing(context,
                button: 'موظفين',
                text: 'لا يوجد موظفين',
                route: AppRoutes.addEmployee);
      case 4:
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.searchUser!.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(
                        name:
                            '${cubit.searchUser![index].first_name} ${cubit.searchUser![index].last_name}',
                        role: cubit.searchUser![index].role!.id == 1
                            ? 'مدير'
                            : 'موظف',
                        avatar: cubit.searchUser![index].avatar != null
                            ? cubit.searchUser![index].avatar!.data!.full_url
                                .toString()
                            : 'لا يوجد',
                        phone1: cubit
                                .searchUser![index].employee_info![0].phone_1 ??
                            'لا يوجد',
                        phone2: cubit
                                .searchUser![index].employee_info![0].phone_2 ??
                            'لا يوجد',
                        empEmail:
                            cubit.searchUser![index].employee_info![0].email ??
                                'لا يوجد',
                        whatsapp: cubit.searchUser![index].employee_info![0]
                                .whatsapp ??
                            'لا يوجد',
                        passwordToken: cubit
                            .searchUser![index].passwordResetToken
                            .toString(),
                        id: cubit.searchUser![index].id.toString(),
                        email: cubit.searchUser![index].email ?? 'لا يوجد',
                        address: cubit
                                .searchUser![index].employee_info![0].address ??
                            'لا يوجد',
                      ),
                    ));
              },
              child: buildEmployeeListItem(cubit.searchUser![index]),
            );
          },
        );

      default:
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: cubit.users!.length,
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EmployeeDetailsScreen(
                        avatar: cubit.users![index].avatar != null
                            ? cubit.users![index].avatar!.data!.full_url
                                .toString()
                            : 'لا يوجد',
                        phone1: cubit.users![index].employee_info![0].phone_1 ??
                            'لا يوجد',
                        phone2: cubit.users![index].employee_info![0].phone_2 ??
                            'لا يوجد',
                        empEmail: cubit.users![index].employee_info![0].email ??
                            'لا يوجد',
                        whatsapp:
                            cubit.users![index].employee_info![0].whatsapp ??
                                'لا يوجد',
                        passwordToken:
                            cubit.users![index].passwordResetToken.toString(),
                        id: cubit.users![index].id.toString(),
                        email: cubit.users![index].email ?? 'لا يوجد',
                        address:
                            cubit.users![index].employee_info![0].address ??
                                'لا يوجد',
                        name:
                            '${cubit.users![index].first_name} ${cubit.users![index].last_name}',
                        role:
                            cubit.users![index].role!.id == 1 ? 'مدير' : 'موظف',
                      ),
                    ));
              },
              child: buildEmployeeListItem(cubit.users![index]),
            );
          },
        );
    }
  }
}
