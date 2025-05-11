import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/navigation.dart';
import 'package:itsale/features/auth/data/cubit.dart';
import 'package:itsale/features/auth/data/states.dart';


import '../../../core/constants/app_defaults.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/toast.dart';
import '../components/login_header.dart';
import '../components/login_page_form.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    return   BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {
        if(state is PostErrorLoginSalesState)
        {
          errorMotionToast(context,text: 'عفوا البيانات غير صحيحة');

        }

        if(state is PostSuccessLoginSalesState)
        {
          successMotionToast(context,text: 'تم تسجيل الدخول بنجاح');

          navigateFinish(context, AppRoutes.entryPoint);
          print ('success');
        }
      },
      builder: (context, state)
      {
        if(state is PostLoadingLoginSalesState)
        {
         return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                          Text(
                            'يرجى الانتظار...',
                            style: AppFonts.style20medium,
                          ),


                      loaderAddition(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

          return    Scaffold(
                body: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: AppDefaults.padding,
                              ),
                              Text(
                                'تسجيل الدخول',
                                style: AppFonts.style20medium,
                              ),
                            ],
                          ),
                          const LoginPageHeader(),
                          const LoginPageForm(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
