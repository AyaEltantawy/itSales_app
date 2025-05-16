import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/entrypoint/entrypoint_ui.dart';
import '../../../../core/remote_data_source/web_services.dart';
import '../../../../core/utils/snack_bar.dart';
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
  String role = '3'; // Sales
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
      first_name: firstNameController.text,
      last_name: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
      status: status,
      theme: theme,
      role: role,
      // timezone: timezoneController.text,
      locale: locale,
      avatar: null,
    );

    try {
      final result = await repo.addUser(addUserRequest);
      Utils.showSnackBar(context, 'تمت إضافة المستخدم بنجاح');
      emit(RegisterSuccessState(result));
      MagicRouter.navigateTo(EntryPointUI());
    } catch (error) {
      Utils.showSnackBar(context, 'فشل في إضافة المستخدم');
      emit(RegisterErrorState(error.toString()));
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
