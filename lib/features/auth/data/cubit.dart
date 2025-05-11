import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/auth/data/states.dart';

import '../../../core/utils/toast.dart';
import '../../../core/utils/token.dart';
import 'models/login_model.dart';

class AppCubit extends Cubit<AppStates> {
  Repository repo;
  AppCubit(this.repo) : super(InitialState());


  static AppCubit get(context) => BlocProvider.of(context);





bool isDarkMode = CacheHelper.getData(key: 'isDark') ?? false ;
  void toggleTheme() {
   isDarkMode = ! isDarkMode;

     emit(ThemeState(isDarkMode));
   CacheHelper.saveData(key: 'isDark' ,value: isDarkMode) ;

  }


  postLoginSales(context,{

    required String email,
    required String password,
}) async
{
  emit(PostLoadingLoginSalesState());

  await repo.loginSales(SalesModel(

    email: email,
    password:password

  )).then((value) {



if(value.data!.token != null ) {

  CacheHelper.saveData(key: 'token', value: value.data!.token);
  CacheHelper.saveData(key: 'role', value: value.data!.user!.role);
  CacheHelper.saveData(key: 'fName', value: value.data!.user!.first_name);
  CacheHelper.saveData(key: 'lName', value: value.data!.user!.last_name);
  CacheHelper.saveData(key: 'email', value: value.data!.user!.email);
  CacheHelper.saveData(key: 'userId', value: value.data!.user!.id);
  token =  CacheHelper.getData(key: 'token');
  role =  CacheHelper.getData(key: 'role');
  userId =  CacheHelper.getData(key: 'userId');
  debugPrint(' data ${value.data}');
  getUserDataFun(context);
  print(token);
  emit(PostSuccessLoginSalesState());
} else
{
 // showToast(text: 'عفوا البيانات غير صحيحة', state: ToastStates.error);
  debugPrint('er ');
  emit(PostErrorLoginSalesState());
}
  }).catchError((onError)
  {
   // showToast(text: 'عفوا البيانات غير صحيحة', state: ToastStates.error);

    emit(PostErrorLoginSalesState());
    debugPrint('errrrrror ${onError.toString()}');

  });

}


  DataInfo? getInfo ;
  getUserDataFun(context) async
  {



    if ( await InternetConnectionChecker().hasConnection == false) {
      showToast(text: 'أنت غير متصل بالانترنت', state: ToastStates.error);

      emit(NoInternetAppState());


    } else
    {
    emit(GetLoadingInfoState());

    await repo.getDataUser().then((value) {
       getInfo = value.data;

      emit(GetSuccessInfoState());


    }).catchError((onError) async
    {
      if ( await InternetConnectionChecker().hasConnection == false) {
        showToast(text: 'أنت غير متصل بالانترنت', state: ToastStates.error);

        emit(NoInternetAppState());


      } else {
        checkTokenAndShowLoginDialog(context);

        emit(GetErrorInfoState());
        debugPrint('errrrrror ${onError.toString()}');
      } });

  }}






}