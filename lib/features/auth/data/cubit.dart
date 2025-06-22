import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/auth/data/models/login_model.dart'
    as login_model;

import '../../../core/cache_helper/cache_helper.dart';
import '../../../core/constants/navigation.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/routes/magic_router.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/token.dart';
import '../../HomeEmployee/models/get_company_model.dart';
import '../../auth/data/states.dart';
import '../../auth/data/repo.dart';
import '../screens/register/models/register_model.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository repo;

  AppCubit(this.repo) : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  String? loginPassword;
  bool isChecked = false;

  void toggleCheckbox() {
    isChecked = !isChecked;
    emit(CheckBoxUpdate());
  }

  bool isDarkMode = CacheHelper.getData(key: 'isDark') ?? false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    CacheHelper.saveData(key: 'isDark', value: isDarkMode);
    emit(ThemeState(isDarkMode));
  }

  Future<void> postLoginSales(
      BuildContext context, {
        required String email,
        required String password,
      }) async {
    emit(PostLoadingLoginSalesState());

    try {
      final loginResponse = await repo.loginSales(
        login_model.SalesModel(email: email, password: password),
      );

      final loginData = loginResponse.data;
      final user = loginData?.user;
      final tokenValue = loginData?.token;

      if (tokenValue != null && user != null) {

        await CacheHelper.saveData(key: 'token', value: tokenValue);

        await CacheHelper.saveData(key: 'role', value: user.role ?? '');

        await CacheHelper.saveData(key: 'fName', value: user.first_name ?? '');
        await CacheHelper.saveData(key: 'lName', value: user.last_name ?? '');
        await CacheHelper.saveData(key: 'email', value: user.email ?? '');
        await CacheHelper.saveData(key: 'userId', value: user.id ?? 0);
        await CacheHelper.saveData(key: 'password', value: user.password ?? "");

        // تحديث القيم العامة
        token = tokenValue;
        role = user.role ?? '';
        userId = (user.id ?? 0) as String?;

        debugPrint('✅ Login successful with data: ${loginResponse.data}');
        getUserDataFun(context);
        emit(PostSuccessLoginSalesState());

      } else {
       Utils.showSnackBar(context, 'عفوا البيانات غير صحيحة');
        emit(PostErrorLoginSalesState());
      }
    } catch (error) {
     Utils.showSnackBar(context, 'عفوا البيانات غير صحيحة');
      debugPrint('❌ Login error: ${error.toString()}');
      emit(PostErrorLoginSalesState());
    }
  }


//   Future<void> postRegisterSales(BuildContext context, {
//     required TextEditingController firstNameController,
//     required TextEditingController lastNameController,
//     required TextEditingController emailController,
//     required TextEditingController passwordController,
//
//     required String status,
//     required String theme,
//     required String role,
//     required String locale,
//     //File? avatar,
//   }) async {
//     emit(PostLoadingRegisterState());
//
//     try {
//       final registerModel = User(
//         first_name: firstNameController.text,
//         last_name: lastNameController.text,
//         email: emailController.text,
//    password: passwordController.text,
//        //time_zone: timezoneController.text,
//         status: status,
//         theme: theme,
//         role: role,
//         locale: locale,
//
//       );
//
//       // final result = await repo.registerSales(registerModel ) ;
//     //  final data = result.data;
//
//       if (data?.token != null) {
//         final user = data!.user!;
// await  CacheHelper.saveData(key:"token", value: data.token);
//         await CacheHelper.saveData(key: 'role', value: user.role);
//         await CacheHelper.saveData(key: 'fName', value: user.first_name);
//         await CacheHelper.saveData(key: 'lName', value: user.last_name);
//         await CacheHelper.saveData(key: 'email', value: user.email);
//         await CacheHelper.saveData(key: 'userId', value: user.id);
//
//         token = data.token;
//         role = user.role!;
//         userId = user.id;
//
//         debugPrint('Registration success' );
//         getUserDataFun(context);
//         emit(PostSuccessRegisterState());
//       } else {
//         Utils.showSnackBar(context, 'عفواً، البيانات غير صحيحة');
//         emit(PostErrorRegisterState());
//       }
//     } catch (error) {
//       debugPrint('Register error: ${error.toString()}');
//       Utils.showSnackBar(context, 'حدث خطأ أثناء عملية إنشاء الحساب');
//       emit(PostErrorRegisterState());
//     }
//   }

  login_model.DataInfoLogin? getInfoLogin;

  Future<void> getUserDataFun(BuildContext context) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
      emit(NoInternetAppState());
      return;
    }

    emit(GetLoadingInfoState());

    try {
      final userData = await repo.getDataUser();
      getInfoLogin = userData.data as login_model.DataInfoLogin;
      emit(GetSuccessInfoState());


      final companyId = getInfoLogin?.companies?.id;
      print("companyIId$companyId");
      if (companyId != null) {
        await CacheHelper.saveData(key: 'company_id', value: companyId);
        debugPrint('✅ Cached company ID from user info: $companyId');
      }
    } catch (error) {
      if (!await InternetConnectionChecker().hasConnection) {
        Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
        emit(NoInternetAppState());
      } else {
        checkTokenAndShowLoginDialog(context);
        debugPrint('Error fetching user data: ${error.toString()}');
        emit(GetErrorInfoState());
      }
    }

}
  markNotificationAsRead({
    required int notificationId,
  }) async {
    emit(PostLoadingAllNotificationState());

    try {
      await TasksCubit.get(MagicRouter.currentContext).postNotificationFun();
      emit(PostSuccessAllNotificationState());
    } catch (e) {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );
        emit(NoInternetAppState());
      }
      emit(PostErrorAllNotificationState());
      debugPrint('Error marking notification as read: $e');
    }
  }

}

