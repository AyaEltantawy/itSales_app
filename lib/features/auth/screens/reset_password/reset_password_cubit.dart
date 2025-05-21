import 'package:bloc/bloc.dart';

import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordState().init());
  // confirmPassword() async {
  //   final body = {
  //     'email': email,
  //     'code': otpCode,
  //     'password': passwordController.text.toString()
  //   };
  //   print('email $email');
  //
  //   print('body ${body}');
  //   emit(LoadingConfirm());
  //   DioHelper.post("auth/forget/reset", false, body: body).then((response) {
  //     final data = response.data as Map<String, dynamic>;
  //
  //     print("dataaa $data");
  //     // print(data['message']);
  //     if (data['status'] == true) {
  //       emit(LoadingSuccess());
  //       showDialog(
  //           context: MagicRouter.currentContext,
  //           builder: (context) => ResetPasswordDialog(
  //             defaultText: 'Congratulations',
  //             mainText: "Reset Code has been sent to your Email at ",
  //           ));
  //       MagicRouter.navigateTo(LoginPage());
  //       print('data ${data['data']}');
  //       //Utils.showSnackBar(MagicRouter.currentContext,data['data']as bool,);
  //     } else {
  //       emit(LoadingError());
  //       Utils.showSnackBar(
  //         MagicRouter.currentContext,
  //         data['message'],
  //       );
  //     }
  //   });
  // }
  //
  //

}
