import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/dio_helper.dart';
import '../../../../core/utils/snack_bar.dart';
import '../otp/otp_view.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordStateInit());

  final emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static final _emailRegex =
  RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"); // Email pattern

  Future<void> forgetPassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();

    final body = {
      'email': email,
      'reset_url': 'geotask.com://reset_password',
    };

    debugPrint('Sending forget password request: $body');
    emit(LoadingForgetPassword());

    try {
      final response = await DioHelper.post(
        "auth/password/request",
        true,
        body: body,
      );

      final data = response.data as Map<String, dynamic>;
      debugPrint("Forget password response: $data");

      final isSuccess = data['public'] == true;
      final message = data['data'] ?? data['message'] ?? 'Password reset initiated.';

      if (isSuccess) {
        emit(LoadingSuccess());
        Utils.showSnackBar(context, message.toString());

        if (_emailRegex.hasMatch(email)) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => OtpPage()),
          );
        }
      } else {
        emit(LoadingError());
        Utils.showSnackBar(context, message.toString());
      }
    } catch (e) {
      emit(LoadingError());
      Utils.showSnackBar(context, "حدث خطأ أثناء إعادة تعيين كلمة المرور");
      debugPrint("ForgetPasswordCubit error: $e");
    }
  }
}
