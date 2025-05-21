import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/auth/screens/forget_password/forget_password_state.dart';

import '../../../core/app_storage/app_storage.dart';
import '../../../core/dio_helper.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/token.dart';
import 'company_state.dart';
import 'package:itsale/main.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyStateInit());
  final TextEditingController companyController = TextEditingController();

  Future<void> postCompany(BuildContext context) async {
    final body = {"name": companyController.text.trim()};

    print('Register body: $body');
    emit(LoadingCompany());

    try {
      print("Final token used: ${token}");
      final response = await DioHelper.post(
        "items/company?fields=*.*",
        true,
        body: body,
      );
      print("Company response: ${response.data}");
      print("tooooooooooken$token");
      final data = response.data;

      if (data is! Map<String, dynamic>) {
        emit(ErrorCompany());
        if (context.mounted) {
          Utils.showSnackBar(context, "الاستجابة غير صالحة من الخادم");
        }
        return;
      }

      final responseData = data['data'];
      final responseError = data['error'];

      if (responseData != null && response.statusCode ==200) {
        emit(SuccessCompany());

        if (context.mounted) {
          Utils.showSnackBar(
            context,
            responseData['message'] ?? 'تم تسجيل الشركة بنجاح',
          );
          navigateTo(context,  AppRoutes.entryPoint);
        }
      } else {
        emit(ErrorCompany());
        if (context.mounted) {
          Utils.showSnackBar(
            context,
            responseError?['message'] ?? "فشل في تسجيل الشركة",
          );
        }
      }
    } catch (e) {
      emit(ErrorCompany());
      if (context.mounted) {
        Utils.showSnackBar(context, "حدث خطأ أثناء تسجيل الشركة");
      }
      print("Error during company registration: $e");
    }
  }
}
