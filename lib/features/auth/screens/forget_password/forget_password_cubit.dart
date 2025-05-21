import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../core/dio_helper.dart';
import '../../../../core/utils/snack_bar.dart';
import '../otp/otp_view.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordStateInit());

  var emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> forgetPassword(BuildContext context) async {
    final body = {
      'email': emailController.text.trim(),
      'reset_url': "com.guessit.geotask://ForgetPasswordPage"
    ,
    };

    print('Request Body: $body');
    emit(LoadingForgetPassword());

    try {
      final response =
          await DioHelper.post("auth/password/request", true, body: body);
      final data = response.data as Map<String, dynamic>;
      print("Response Data: $data");
print("ssssssssss${data["public"]}");
      final isSuccess = data['public'] == true;
      final message =
          data['data'] ?? data['message'] ?? 'Password reset initiated.';

      if (isSuccess) {
        emit(LoadingSuccess());
        Utils.showSnackBar(context, message.toString());

        if (RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
            .hasMatch(emailController.text.trim())) {
          Navigator.push(
            context,
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
      print("ForgetPassword error: $e");
    }
  }
}
