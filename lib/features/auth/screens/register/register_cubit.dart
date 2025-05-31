import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/dio_helper.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/auth/screens/login_page.dart';
import 'package:itsale/features/auth/screens/password_changed_success/success_view.dart';
import 'package:itsale/features/entrypoint/entrypoint_ui.dart';
import '../../../../core/app_storage/app_storage.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../../../core/utils/token.dart';
import '../../../addEmployee/data/models/add_employee_model.dart';
import '../../data/cubit.dart';
import '../../data/models/login_model.dart' as login_model;
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.repo) : super(RegisterStateInit());

  final Repository repo;
  final formKey = GlobalKey<FormState>();

  bool isPasswordShown = false;
  bool isPasswordShownConfirm = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final timezoneController = TextEditingController();

  String status = 'active';
  String theme = 'auto';
  String role = '1'; //admin
  String locale = 'ar-SA';

  final List<String> themes = ['auto', 'dark', 'light'];
  final Map<String, String> roles = {
    '1': 'Admin',
    '3': 'Sales',
  };
  final List<String> locales = ['ar-SA', 'en-US'];

  void onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    emit(PasswordShownState());
  }
  void onPassShowClickedConFirm() {
    isPasswordShownConfirm = !isPasswordShownConfirm;
    emit(PasswordShownConfirmState());
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final body = {
      'email': email,
      'password': password,
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      'role': role.toString() == "1" ? "1" : role.toString(),
    };

    print('Register body: $body');
    emit(LoadingRegister());

    try {
      final response = await DioHelper.post("custom/signup", false, body: body);
      print("Signup response: ${response.data}");

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        emit(LoadingFailed());
        if (context.mounted) {
          Utils.showSnackBar(context, "الاستجابة غير صالحة من الخادم");
        }
        return;
      }

      final responseData = data['data'];
      final responseError = data['error'];

      if (responseData != null && responseData['code'] == 'created') {
        final loginResponse = await repo.loginSales(
          login_model.SalesModel(email: email, password: password),
        );

        emit(LoadingSuccess());
        await CacheHelper.clearAll();
        if (context.mounted) {
          Utils.showSnackBar(
            context,
            'تم انشاء حساب جديد بنجاح',
          );


          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(
                initialPassword: passwordController,
                initialEmail: emailController,
              ),
            ),
          );
        }
      } else if (responseError != null) {
        final errorMessage = responseError['message'] ?? "حدث خطأ غير معروف";
        emit(LoadingFailed());

        if (context.mounted) {
          Utils.showSnackBar(context, errorMessage);
        }
      } else {
        emit(LoadingFailed());
        if (context.mounted) {
          Utils.showSnackBar(context, "صيغة الاستجابة غير متوقعة");
        }
      }
    } catch (e, stack) {
      emit(LoadingFailed());

      if (context.mounted) {
        Utils.showSnackBar(context, "حدث خطأ أثناء التسجيل");
      }

      print("Register error: $e");
      print("Stack trace: $stack");
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    timezoneController.dispose();
    return super.close();
  }
}
