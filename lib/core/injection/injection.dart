

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/home/data/cubit.dart';

import '../../features/auth/data/cubit.dart';
import '../../features/auth/data/repo.dart';
import '../remote_data_source/web_services.dart';


final getIt = GetIt.instance;

void getInit() {
  getIt.registerLazySingleton<WebServices> (() => WebServices(createSetupDio()));
  getIt.registerLazySingleton<AppCubit> (() => AppCubit(getIt()));
  getIt.registerLazySingleton<Repository> (() => Repository(getIt()));
  getIt.registerLazySingleton<EmployeeCubit> (() => EmployeeCubit(getIt()));
  getIt.registerLazySingleton<TasksCubit> (() => TasksCubit(getIt()));
  //
  // getIt.registerLazySingleton<TasksCubit> (() => TasksCubit(getIt()));
  // getIt.registerLazySingleton<TasksRepository> (() => TasksRepository(getIt()));


}
Dio createSetupDio()
{
  Dio dio = Dio () ;

  dio.interceptors.add(LogInterceptor(
    error: true ,
    request: true,
    requestHeader: false ,
    responseBody: true,
    requestBody: true,
    responseHeader: false,


  ));
  dio.options.followRedirects = false;
  dio.options.validateStatus =
      (status) => status != null &&  status < 400;
  dio.options.maxRedirects = 0;



  return dio;
}