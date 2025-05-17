import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/dio_helper.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/entrypoint/entrypoint_ui.dart';
import '../../../../core/app_storage/app_storage.dart';
import '../../../../core/cache_helper/cache_helper.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/utils/snack_bar.dart';
import '../../../../core/utils/token.dart';
import '../../../addEmployee/data/models/add_employee_model.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.repo) : super(RegisterStateInit());

  final Repository repo;
  final formKey = GlobalKey<FormState>();

  bool isPasswordShown = false;

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

  Future<void> addUser(BuildContext context) async {
    final isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      Utils.showSnackBar(context, 'يرجى تعبئة كافة الحقول بشكل صحيح');
      return;
    }

    emit(RegisterLoadingState());

    final addUserRequest = AddUserRequestModel(
      email: emailController.text,
      password: passwordController.text,
      first_name: firstNameController.text,
      last_name: lastNameController.text,
    );

    try {
      final result = await repo.addUser(addUserRequest);
      await CacheHelper.saveData(key: 'token', value: token);
      emit(RegisterSuccessState(result));
      Utils.showSnackBar(context, 'تمت إضافة المستخدم بنجاح');
      MagicRouter.navigateTo(EntryPointUI());
    } catch (error) {
      Utils.showSnackBar(context, 'فشل في إضافة المستخدم');
      emit(RegisterErrorState(error.toString()));
    }
  }

  Future<void> register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    // print("TOKEN: ${CacheHelper.getData(key: "token")}");
    final body = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
      'first_name': firstNameController.text.toString(),
      'last_name': lastNameController.text.toString(),
      'role': '1',
      'companies': 1
    };

    print('body $body');
    emit(LoadingRegister());

    try {
      print("TOKEN: ${CacheHelper.getData(key: "token")}");
      final response = await DioHelper.post("custom/signup", false, body: body);
      final data = response.data as Map<String, dynamic>;
      print("dataaa $data");

      final message = data['message'] ??"";

      if (data['code'] == 'created') {
        Utils.showSnackBar(context, data["message"]);
navigateTo(context, AppRoutes.homeEmployee);
        AppStorage.cacheUserInfo(UserModel.fromJson(data));

        emit(LoadingSuccess());
      } else {
        emit(LoadingFailed());
        Utils.showSnackBar(context, message);
      }
    } catch (e) {
      emit(LoadingFailed());
      Utils.showSnackBar(context, "حدث خطأ أثناء التسجيل");
      print("Register error: $e");
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
