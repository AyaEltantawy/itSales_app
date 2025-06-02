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
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
      } else {
        print("Unable to show snackbar: context is null");
      }

      emit(NoInternetState());
    } else {
      emit(GetLoadingSalesState());

      await repo.allUsers(
          {'fields': '*.*', 'filter[companies]': companyId}).then((value) {
        users = value.data;
        print("dfghjkl ${companyId}");
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

  Future<void> getAdmins({int? role, String? search}) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
      } else {
        print("Unable to show snackbar: context is null");
      }
      emit(NoInternetState());
      return;
    }

    emit(GetLoadingAdminsState());

    Map<String, dynamic> queryParams = {};

    // Add role filter if provided
    if (role != null) {
      queryParams['filter[role]'] = role.toString();
    }

    if (companyId != null) {
      queryParams['filter[companies]'] = companyId;
    }

    if (search != null && search.isNotEmpty) {
      queryParams['q'] = search;
      emit(GetLoadingSearchEmployeeFilterState());
    }

    try {
      final value = await repo.allUsers(queryParams);

      if (role != null) {
        if (role == 1) {
          usersAdmin = value.data;
        } else {
          usersEmployee = value.data;
        }
      }

      emit(GetSuccessAdminsState());

      if (search != null && search.isNotEmpty) {
        searchUser = value.data;
        emit(GetSuccessSearchEmployeeFilterState());
      }
    } catch (onError,stackTrace) {
      if (search != null && search.isNotEmpty) {
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
      debugPrint('Error in getAdmins: ${onError.toString()}');
      debugPrint('Stack trace:\n$stackTrace');
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
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
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
        .addEmployee(
      AddEmployeeRequestModel(
        user: employeeId,
        status: status,
        email: email,
        address: address,
        phone_1: phone1,
        phone_2: phone2,
        whatsapp: whatsapp,
      ),
    )
        .then((value) {
      emit(AddSuccessEmployeeInfoState());

      getAllSales();
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

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
    int? companies,
  }) async {
    emit(AddLoadingUserState());
    print("🔐 tokenForAddUsers: $token");

    await repo
        .addUser(
      AddUserRequestModel(
        email: email,
        first_name: firstName,
        last_name: lastName,
        role: role,
        password: password,
        companies: companyId,
        status: status
      ),
    )
        .then((value) {
      emit(AddSuccessUserState());
print("statussssssss:$status");
      getAllSales();

      print("🏢 companyIdForUser: $companyId");

      final context = MagicRouter.currentContext;
      if (context != null) {
        navigateTo(context, AppRoutes.entryPoint);
      }

      addEmployeeFun(
        employeeId: value.data?.id?.toString() ?? '',
        status: 'published',
        email: emailEmp,
        address: address,
        phone2: phone2,
        whatsapp: whatsapp,
        phone1: '',
      );
    }).catchError((error, stackTrace) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        final context = MagicRouter.currentContext;
        if (context != null) {
          Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
        }
        emit(NoInternetState());
        return;
      }
      emit(AddErrorUserState());
      debugPrint('🔴 ERROR: $error');
      debugPrint('📍 STACK TRACE:\n$stackTrace');
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
    int? companies,
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
              companies: companies
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
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

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
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

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
    int? companyId,
  }) async {
    Dio dio = Dio();
    try {
      emit(PostLoadingFileState());
      String baseUrl = "https://eby-itsales.guessitt.com/public/itsales/";
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
        print("statusssssssssss$status");
        print("File uploaded successfully!");
        print(response.data['data']['id']);

        if (edit) {
          editUserFun(
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
            role: role,
            companies: companyId
          );
        } else {
          adduserFun(
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
              whatsapp: whatsapp,
              companies: companyId);
        }
      } else {
        emit(PostErrorFileState());
        print("File upload failed with status: ${response.statusCode}");
      }
    } catch (e) {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );
        emit(NoInternetState());
      }
      emit(PostErrorFileState());
      print("Error during file upload: $e");
    }
  }
}
