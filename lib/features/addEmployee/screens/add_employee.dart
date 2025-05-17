import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/home/data/models/all_employees_model.dart';
import 'package:itsale/features/home/data/states.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/token.dart';
import '../../addEmployee/data/models/add_employee_model.dart';

class EmployeeCubit extends Cubit<EmployeeStates> {
  final Repository repo;

  EmployeeCubit(this.repo) : super(InitialEmployeeState());

  static EmployeeCubit get(BuildContext context) => BlocProvider.of(context);

  // ========== State Variables ==========
  List<AllEmployeeModel>? employee = [];
  List<DataUser>? users = [];
  List<DataUser>? usersAdmin = [];
  List<DataUser>? usersEmployee = [];
  List<DataUser>? searchUser = [];
  List<DataEmployee>? getEmployeeInfoList = [];

  // ========== Get All Employees ==========
  Future<void> getAllEmployee() async {
    if (!await InternetConnectionChecker().hasConnection) {
      Utils.showSnackBar(MagicRouter.currentContext!, 'أنت غير متصل بالانترنت');
      emit(NoInternetState());
      return;
    }

    emit(GetLoadingEmployeeState());

    try {
      final value = await repo.getAllEmployee();
      employee = value.data?.cast<AllEmployeeModel>();
      emit(GetSuccessEmployeeState());
    } catch (e) {
      emit(GetErrorEmployeeState());
      debugPrint('Error in getAllEmployee: $e');
    }
  }

  // ========== Get All Users ==========
  Future<void> getAllSales() async {
    if (!await InternetConnectionChecker().hasConnection) {
      Utils.showSnackBar(MagicRouter.currentContext!, 'أنت غير متصل بالانترنت');
      emit(NoInternetState());
      return;
    }

    emit(GetLoadingSalesState());

    try {
      final value = await repo.allUsers();
      users = value.data;
      emit(GetSuccessSalesState());
    } catch (e) {
      emit(GetErrorSalesState());
      debugPrint('Error in getAllSales: $e');
    }
  }

  // ========== Get Admins/Employees with Filter/Search ==========
  Future<void> getAdmins({int? role, String? search}) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Utils.showSnackBar(MagicRouter.currentContext!, 'أنت غير متصل بالانترنت');
      emit(NoInternetState());
      return;
    }

    emit(GetLoadingAdminsState());

    Map<String, String> queryParams = {};
    if (role != null) queryParams['filter[role.id][eq]'] = role.toString();
    if (search != null) {
      queryParams['q'] = search;
      emit(GetLoadingSearchEmployeeFilterState());
    }

    try {
      final result = await repo.allUsers(queryParams);
      if (role != null) {
        if (role == 1) {
          usersAdmin = result.data;
        } else {
          usersEmployee = result.data;
        }
      }
      if (search != null) {
        searchUser = result.data;
        emit(GetSuccessSearchEmployeeFilterState());
      }
      emit(GetSuccessAdminsState());
    } catch (e) {
      if (search != null) emit(GetErrorSearchEmployeeFilterState());
      emit(GetErrorAdminsState());
      debugPrint('Error in getAdmins: $e');
    }
  }

  // ========== Add New User ==========
  Future<void> adduserFun({
    required String firstName,
    required String lastName,
    required String status,
    required String email,
    required String role,
    required String password,
    String? phone1,
    String? emailEmp,
    String? address,
    String? phone2,
    String? whatsapp,
    int? avatar,
  }) async {
    emit(AddLoadingUserState());

    try {
      final value = await repo.addUser(
        AddUserRequestModel(

          email: email,
          first_name: firstName,
          last_name: lastName,

          role: role,

          password: password,


      ));

      emit(AddSuccessUserState());
      navigateTo(MagicRouter.currentContext!, AppRoutes.entryPoint);

      await addEmployeeFun(
        employeeId: value.data!.id.toString(),
        status: 'published',
        email: emailEmp,
        address: address,
        phone2: phone2,
        whatsapp: whatsapp,
        phone1: phone1 ?? '',
      );
    } catch (e) {
      emit(AddErrorUserState());
      debugPrint('Error in adduserFun: $e');
    }
  }

  // ========== Add Employee ==========
  Future<void> addEmployeeFun({
    required String employeeId,
    required String phone1,
    required String status,
    String? email,
    String? address,
    String? phone2,
    String? whatsapp,
  }) async {
    emit(AddLoadingEmployeeInfoState());

    try {
      await repo.addEmployee(
        AddEmployeeRequestModel(
          user: employeeId,
          status: status,
          email: email,
          address: address,
          phone_1: phone1,
          phone_2: phone2,
          whatsapp: whatsapp,
        ),
      );
      emit(AddSuccessEmployeeInfoState());
      await getAllSales();
    } catch (e) {
      emit(AddErrorEmployeeInfoState());
      debugPrint('Error in addEmployeeFun: $e');
    }
  }

// Other methods like editUserFun, uploadFile etc. go here...
}
