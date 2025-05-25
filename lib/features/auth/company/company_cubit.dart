import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/auth/company/widgets/company_model.dart';
import 'package:itsale/features/auth/screens/forget_password/forget_password_state.dart';

import '../../../core/app_storage/app_storage.dart';
import '../../../core/cache_helper/cache_helper.dart';
import '../../../core/dio_helper.dart';
import '../../../core/utils/snack_bar.dart';
import '../../../core/utils/token.dart';
import '../data/cubit.dart';
import 'company_state.dart';
import 'package:itsale/main.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyStateInit());
  final TextEditingController companyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  CompanyModel? companyModel;

  Future<void> postCompany(BuildContext context) async {
    final body = {
      "name": companyController.text.trim(),
      "email": emailController.text.trim(),
      "whatsapp": whatsappController.text.trim(),
      "website": websiteController.text.trim(),
    };

    print('Register body: $body');

    if (!isClosed) emit(LoadingCompany());

    try {
      print("Final token used: $token");

      final response = await DioHelper.post(
        "items/company?fields=*.*",
        true,
        body: body,
      );

      print("Company response: ${response.data}");

      if (response.statusCode == 200 && response.data['data'] != null) {

        companyModel = CompanyModel.fromJson(response.data);
        final dataCompany = companyModel?.data;

        updateUserCompany(context,dataCompany?.id?? 1);

        if (dataCompany != null && dataCompany.id != null) {
          await CacheHelper.saveData(key: 'company_id', value: dataCompany.id);
          print('✅ Cached company ID: ${dataCompany.id}');

          if (!isClosed) emit(SuccessCompany());

          if (context.mounted) {
            Utils.showSnackBar(context, "تم تسجيل الشركة بنجاح");
            navigateTo(context, AppRoutes.entryPoint);
          }
        } else {
          if (!isClosed) emit(ErrorCompany());

          if (context.mounted) {
            Utils.showSnackBar(context, "فشل في معالجة بيانات الشركة");
          }
        }
      } else {
        if (!isClosed) emit(ErrorCompany());

        if (context.mounted) {
          final errorMessage = response.data['error']?['message'] ?? "فشل في تسجيل الشركة";
          Utils.showSnackBar(context, errorMessage);
        }
      }
    } catch (e) {
      if (!isClosed) emit(ErrorCompany());

      if (context.mounted) {
        Utils.showSnackBar(context, "حدث خطأ أثناء تسجيل الشركة");
      }
      print("❌ Error during company registration: $e");
    }
  }


  Future<void> updateUserCompany(BuildContext context, int? company_id) async {

    if (company_id == null) {
      if (!isClosed) emit(UpdateUserCompanyError());
      if (context.mounted) {
        Utils.showSnackBar(context, "لم يتم العثور على معرف الشركة");
      }
      return;
    }

    print("companyId: $company_id");

    final body = {
      "companies": company_id,
    };

    print('updateUserCompany body: $body');

    if (!isClosed) emit(UpdateUserCompanyLoading());

    try {
      print("Final token used: $token");

      final response = await DioHelper.patch(
        "users/$userId",
        true,
        body: body,
      );

      print("UpdateUserCompany response: ${response.data}");

      if (response.statusCode == 200 && response.data['data'] != null) {
        if (!isClosed) emit(UpdateUserCompanySuccess());

        if (context.mounted) {
          Utils.showSnackBar(context, "تم تحديث بيانات المستخدم بنجاح");
          navigateTo(context, AppRoutes.entryPoint);
        }
      } else {
        if (!isClosed) emit(UpdateUserCompanyError());

        if (context.mounted) {
          final errorMessage = response.data['error']?['message'] ?? "فشل في تحديث بيانات المستخدم";
          Utils.showSnackBar(context, errorMessage);
        }
      }
    } catch (e) {
      if (!isClosed) emit(UpdateUserCompanyError());

      if (context.mounted) {
        Utils.showSnackBar(context, "حدث خطأ أثناء تحديث بيانات المستخدم");
      }
      print("❌ Error during user company update: $e");
    }
  }




}
