import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
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
      }).catchError((onError, stackTrace) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }

        emit(GetErrorSalesState());
        debugPrint('errrrrror ${onError}');
        print("stackTrace$stackTrace");
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
    } catch (onError, stackTrace) {
      if (search != null && search.isNotEmpty) {
        emit(GetErrorSearchEmployeeFilterState());
      }

      if (await InternetConnectionChecker().hasConnection == false) {
        final context = MagicRouter.currentContext;
        if (context != null) {
          Utils.showSnackBar(
            context,
            'أنت غير متصل بالانترنت',
          );
        }
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

  Future<void> addUserFun({
    required String firstName,
    required String lastName,
    required String status,
    required String email,
    required String role,
    String? password,
    String? phone1,
    String? emailEmp,
    String? address,
    String? phone2,
    String? whatsapp,
    dynamic? avatar,
    int? companies,
    bool isEdit = false,
    String? employeeId,
  }) async {
    emit(AddLoadingUserState());
    debugPrint("🔐 tokenForAddUsers: $token");

    final request = AddUserRequestModel(
      email: email,
      first_name: firstName,
      last_name: lastName,
      password: password,
      role: role,
      companies: companyId,
      status: status,
      avatar: avatar,
    );
    print("add data${avatar}");

    if (!isEdit || (password != null && password.isNotEmpty)) {
      request.password = password;
    }

    debugPrint(
        "Password provided: ${password != null && password.isNotEmpty ? 'Yes' : 'No'}");

    try {
      final value = await repo.addUser(request);
      emit(AddSuccessUserState());

      if (password != null && password.isNotEmpty) {
        final userIdToSave = value.data?.id?.toString() ?? employeeId ?? '';

        await CacheHelper.saveData(
            key: "password_add_$userIdToSave", value: password);
        debugPrint("🔑 Password saved for user $userIdToSave");
      }

      getAllSales();
      debugPrint("🏢 companyIdForUser: $companyId");

      final context = MagicRouter.currentContext;
      if (context != null) {
        navigateTo(context, AppRoutes.entryPoint);
      }

      addEmployeeFun(
          employeeId: value.data?.id?.toString() ?? employeeId ?? '',
          status: 'published',
          email: emailEmp,
          address: address,
          phone2: phone2,
          whatsapp: whatsapp,
          phone1: phone1 ?? '');
    } catch (error, stackTrace) {
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
    }
  }

  Future<void> editUserFun({
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
    dynamic? avatar,
    int? companies,
    bool? isEdit = true,
  }) async {
    if (idUser.isEmpty || idUser == 'null') {
      debugPrint('⚠️ Invalid user ID: $idUser');
      emit(ErrorEditUserState());
      return;
    }

    emit(LoadingEditUserState());

    try {
      String? passwordToUse;

      if (idUser == userId) {
         passwordToUse = passwordLogin ?? await CacheHelper.getData(key: 'password') ?? '123456789';



        debugPrint('🔑 Using manager password from login cache');
      } else {
        passwordToUse = await CacheHelper.getData(key: "password_add_$idUser");
        debugPrint('🔑 Using password from user creation cache');

        if ((passwordToUse == null || passwordToUse.isEmpty) &&
            password != null &&
            password.isNotEmpty) {
          passwordToUse = password;
          debugPrint('🔑 Using password from request parameters');
        }
      }
      debugPrint(
          '🔐 Password available: ${passwordToUse != null ? "Yes" : "No"}');
      final value = await repo.editDataUser(
        idUser,
        EditUserRequestModel(
          id: idUser,
          password: passwordToUse,
          status: status ?? 'active',
          email: email,
          first_name: firstName,
          last_name: lastName,
          role: role,
          avatar: avatar,
          companies: companies,
        ),
      );

      emit(SuccessEditUserState());

      if (value.data != null && employeeId.isNotEmpty && employeeId != '0') {
        await editEmployeeFun(
          employeeId: employeeId,
          user: value.data!.id.toString(),
          status: empStatus ?? 'published',
          email: emailEmp,
          address: address,
          phone1: phone1,
          phone2: phone2,
          whatsapp: whatsapp,
        );
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['error']?['message'] ??
          e.message ??
          'Failed to update user';

      debugPrint('❌ Dio Error: $errorMessage');
      debugPrint('📛 Status Code: ${e.response?.statusCode}');
      debugPrint('📛 Response: ${e.response?.data}');

      emit(ErrorEditUserState());
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(
            context, 'حدث خطأ أثناء تعديل المستخدم: $errorMessage');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Unexpected error: $e');
      debugPrint('📛 StackTrace: $stackTrace');

      if (!await InternetConnectionChecker().hasConnection) {
        final context = MagicRouter.currentContext;
        if (context != null) {
          Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
        }
        emit(NoInternetState());
        return;
      }

      emit(ErrorEditUserState());
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(context, 'حدث خطأ غير متوقع أثناء تعديل المستخدم');
      }
    }
  }

  Future<void> editEmployeeFun({
    required String employeeId,
    String? status,
    String? email,
    String? address,
    String? phone1,
    String? phone2,
    String? whatsapp,
    required String user,
  }) async {
    if (employeeId.isEmpty || employeeId == 'null') {
      debugPrint("❌ employeeId is invalid: $employeeId");
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(
          context,
          'لا يمكن تعديل الموظف، المعرف غير صالح',
        );
      }
      emit(EditErrorEmployeeInfoState());
      return;
    }

    emit(EditLoadingEmployeeInfoState());

    try {
      await repo.editEmployee(
        employeeId,
        AddEmployeeRequestModel(
          user: user,
          status: status,
          email: email,
          address: address,
          phone_1: phone1,
          phone_2: phone2,
          whatsapp: whatsapp,
        ),
      );
      emit(EditSuccessEmployeeInfoState());
      getAllSales();
    } catch (onError) {
      if (!await InternetConnectionChecker().hasConnection) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالإنترنت',
        );
        emit(NoInternetState());
      } else {
        debugPrint('❌ Error editing employee: $onError');
        emit(EditErrorEmployeeInfoState());
      }
    }
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
    int? avatar,
    String? emailEmp,
    String? empStatus,
    String? address,
    String? phone2,
    String? whatsapp,
    int? companyId,
  }) async {
    emit(PostLoadingFileState());
    debugPrint(
        "📤 Starting file upload for ${edit ? "edit" : "add"} operation");

    try {
      final fileId = await _uploadFile(file);

      String? passwordToUse;

      if (idUser == userId) {
        passwordToUse =
            passwordLogin ?? await CacheHelper.getData(key: 'password');
        debugPrint('🔑 Using manager password from login cache');
      } else {
        passwordToUse = await CacheHelper.getData(key: "password_add_$idUser");
        debugPrint('🔑 Using password from user creation cache');

        if ((passwordToUse == null || passwordToUse.isEmpty) &&
            password != null &&
            password.isNotEmpty) {
          passwordToUse = password;
          debugPrint('🔑 Using password from request parameters');
        }
      }
      debugPrint(
          '🔐 Password available: ${passwordToUse != null ? "Yes" : "No"}');
      if (edit) {
        if (passwordToUse != null) {
          await editUserFun(
            idUser: idUser,
            avatar: fileId,
            phone1: phone1,
            password: passwordToUse,
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
            companies: companyId,
          );
        } else {
          await editUserFun(
            idUser: idUser,
            avatar: fileId,
            phone1: phone1,
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
            companies: companyId,
          );
        }
      } else {
        await addUserFun(
          firstName: firstName,
          avatar: fileId,
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
          companies: companyId,
        );
      }

      emit(PostSuccessFileState());
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  Future<int> _uploadFile(File file) async {
    final dio = Dio();
    final response = await dio.post(
      "https://eby-itsales.guessitt.com/public/itsales/files",
      data: FormData.fromMap({
        "data": await MultipartFile.fromFile(file.path,
            filename: basename(file.path)),
      }),
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );

    if (response.statusCode != 200) throw Exception("File upload failed");
    return response.data['data']['id'];
  }

  void _handleError(dynamic error, StackTrace stackTrace) async {
    debugPrint("❌ Error: $error");

    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(MagicRouter.currentContext!, 'No internet connection');
      emit(NoInternetState());
    } else {
      emit(PostErrorFileState());
      Utils.showSnackBar(MagicRouter.currentContext!, 'Operation failed');
    }
  }
}
