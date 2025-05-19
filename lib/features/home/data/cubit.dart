import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/features/entrypoint/entrypoint_ui.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/home/data/models/all_employees_model.dart';

import 'package:itsale/features/home/data/states.dart';

import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/token.dart';
import '../../addEmployee/data/models/add_employee_model.dart';

class EmployeeCubit extends Cubit<EmployeeStates> {
  Repository repo;

  EmployeeCubit(this.repo) : super(InitialEmployeeState());

  static EmployeeCubit get(context) => BlocProvider.of(context);

  List<DataAllEmployee>? employee = [];

  getAllEmployee() async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );
      emit(NoInternetState());
    } else {
      emit(GetLoadingEmployeeState());

      await repo.getAllEmployee().then((value) {
        employee = value.data;

        emit(GetSuccessEmployeeState());
      }).catchError((onError) {
        emit(GetErrorEmployeeState());
        debugPrint('errrrrror ${onError.toString()}');
      });
    }
  }

  ///all users

  List<DataUser>? users = [];
  List<DataUser>? usersAdmin = [];
  List<DataUser>? usersEmployee = [];
  List<DataUser>? searchUser = [];

  getAllSales() async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );

      emit(NoInternetState());
    } else {
      emit(GetLoadingSalesState());

      await repo.allUsers({
        'fields': '*.*',
        'filter[companies.id]':
        (users != null && users!.length > 1) ? users![1].companies?.id : null,
      }).then((value) {
        users = value.data;
        print("dfghjkl ${users?[1].companies?.id}");
        print("userssssssssssssssssssssssssss");
        print(users);
        emit(GetSuccessSalesState());
      }).catchError((onError) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }

        emit(GetErrorSalesState());
        debugPrint('errrrrror ${onError}');
      });
    }
  }

  getAdmins({int? role, String? search}) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );

      emit(NoInternetState());
    } else {
      emit(GetLoadingAdminsState());
      Map<String, String> queryParams = {};
      if (role != null) {
        queryParams['filter[role.id][eq]'] = role.toString();
      }
      if (search != null) {
        queryParams['q'] = search;
        emit(GetLoadingSearchEmployeeFilterState());
      }
      await repo.allUsers(queryParams).then((value) {
        if (role != null) {
          role == 1 ? usersAdmin = value.data : usersEmployee = value.data;
        }
        emit(GetSuccessAdminsState());

        if (search != null) {
          searchUser = value.data;
          emit(GetSuccessSearchEmployeeFilterState());
        }
      }).catchError((onError) async {
        if (search != null) {
          emit(GetErrorSearchEmployeeFilterState());
        }
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }
        emit(GetErrorAdminsState());
        debugPrint('errrrrror ${onError.toString()}');
      });
    }
  }

  List<DataEmployee>? getEmployeeInfoList = [];

  getEmployeeInfoFun({
    required String employeeId,
  }) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );

      emit(NoInternetState());
    } else {
      emit(GetLoadingEmployeeInfoState());

      await repo.getEmployeeInfo(employeeId).then((value) {
        getEmployeeInfoList = value.data;

        emit(GetSuccessEmployeeInfoState());
      }).catchError((onError) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!, 'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }

        emit(GetErrorEmployeeInfoState());
        debugPrint('errrrrror ${onError.toString()}');
      });
    }
  }

  addEmployeeFun({
    required String employeeId,
    required String phone1,
    required String status,
    String? email,
    String? address,
    String? phone2,
    String? whatsapp,
  }) async {
    emit(AddLoadingEmployeeInfoState());

    await repo
        .addEmployee(AddEmployeeRequestModel(
      user: employeeId,
      status: status,
      email: email,
      address: address,
      phone_1: phone1,
      phone_2: phone2,
      whatsapp: whatsapp,
    ))
        .then((value) {
      emit(AddSuccessEmployeeInfoState());
      getAllSales();
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(MagicRouter.currentContext!,'أنت غير متصل بالانترنت', );

        emit(NoInternetState());
      }
      emit(AddErrorEmployeeInfoState());
      debugPrint('errrrrror ${onError.toString()}');
    });
  }

  adduserFun({
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

    await repo
        .addUser(AddUserRequestModel(

      email: email,
      first_name: firstName,
      last_name: lastName,

      role: role,

      password: password,


    ))
        .then((value) {

      emit(AddSuccessUserState());
      navigateTo(MagicRouter.currentContext!,AppRoutes.entryPoint);
      // MagicRouter.navigateTo(EntryPointUI());
      addEmployeeFun(

          employeeId: value.data!.id.toString(),
          status: 'published',
          email: emailEmp,
          address: address,

          phone2: phone2,
          whatsapp: whatsapp, phone1: '');
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(MagicRouter.currentContext!,'أنت غير متصل بالانترنت');

        emit(NoInternetState());
      }
      emit(AddErrorUserState());
      debugPrint('errrrrror ${onError.toString()}');
    });
  }

  editUserFun({
    required String firstName,
    required String lastName,
    required String employeeId,
    required String idUser,
    String? status,
    String? empStatus,
    required String email,
    String? password,
    required String role,
    required String phone1,
    String? emailEmp,
    String? address,
    String? phone2,
    String? whatsapp,
    int? avatar,
  }) async {
    emit(LoadingEditUserState());

    await repo
        .editDataUser(
        idUser,
        EditUserRequestModel(
          password: password,
          status: status ?? 'active',
          email: email,
          first_name: firstName,
          last_name: lastName,
          role: role,
          avatar: avatar,
        ))
        .then((value) {
      emit(SuccessEditUserState());
      employeeId != '0'
          ? editEmployeeFun(
          employeeId: employeeId,
          user: value.data!.id.toString(),
          status: empStatus ?? 'published',
          email: emailEmp,
          address: address,
          phone1: phone1,
          phone2: phone2,
          whatsapp: whatsapp)
          : Container();
      getAllSales();
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(MagicRouter.currentContext!, 'أنت غير متصل بالانترنت',);

        emit(NoInternetState());
      }
      emit(ErrorEditUserState());
      debugPrint('errrrrror ${onError.toString()}');
    });
  }

  editEmployeeFun({
    required String employeeId,
    String? status,
    String? email,
    String? address,
    String? phone1,
    String? phone2,
    String? whatsapp,
    required String user,
  }) async {
    emit(EditLoadingEmployeeInfoState());

    await repo
        .editEmployee(
        employeeId,
        AddEmployeeRequestModel(
          user: user,
          status: status,
          email: email,
          address: address,
          phone_1: phone1,
          phone_2: phone2,
          whatsapp: whatsapp,
        ))
        .then((value) {
      emit(EditSuccessEmployeeInfoState());
      getAllSales();
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(MagicRouter.currentContext!,'أنت غير متصل بالانترنت', );

        emit(NoInternetState());
      }
      emit(EditErrorEmployeeInfoState());
      debugPrint('errrrrror ${onError.toString()}');
    });
  }

  Future<void> uploadFile(
      File file, {
        required String firstName,
        required bool edit,
        required String lastName,
        required String status,
        required String email,
        required String role,
        required String password,
        required String phone1,
        required String employeeId,
        required String idUser,
        String? emailEmp,
        String? empStatus,
        String? address,
        String? phone2,
        String? whatsapp,
      }) async {
    Dio dio = Dio();
    try {
      emit(PostLoadingFileState());
      String baseUrl =
          "https://eby-itsales.guessitt.com/public/itsales/"; // Replace with your base URL
      String endpoint = "files";
      String fileName = basename(file.path);

      FormData formData = FormData.fromMap({
        "data": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await dio.post(
        "$baseUrl$endpoint",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(PostSuccessFileState());
        print("File uploaded successfully!");

        print(response.data['data']['id']);

        edit
            ? editUserFun(
            idUser: idUser,
            avatar: response.data['data']['id'],
            phone1: phone1,
            password: password,
            employeeId: employeeId,
            phone2: phone2,
            whatsapp: whatsapp,
            emailEmp: emailEmp,
            address: address,
            firstName: firstName,
            lastName: lastName,
            email: email,
            status: status,
            empStatus: empStatus,
            role: role)
            : adduserFun(
            firstName: firstName,
            avatar: response.data['data']['id'],
            lastName: lastName,
            status: status,
            email: email,
            role: role,
            password: password,
            emailEmp: emailEmp,
            address: address,
            phone1: phone1,
            phone2: phone2,
            whatsapp: whatsapp);
      } else {
        emit(PostErrorFileState());
        print("File upload failed with status: ${response.statusCode}");
      }
    } catch (e) {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(MagicRouter.currentContext!, 'أنت غير متصل بالانترنت',);

        emit(NoInternetState());
      }
      emit(PostErrorFileState());
      print("Error during file upload: $e");
    }
  }
}