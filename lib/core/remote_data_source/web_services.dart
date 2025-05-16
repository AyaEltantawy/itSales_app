import 'package:dio/dio.dart';
import 'package:itsale/features/auth/screens/register/models/register_model.dart'
    as register_model;
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../features/HomeEmployee/models/get_company_model.dart';
import '../../features/Tasks_Screens/data/models/get_task_model.dart'
    show AddTaskModel, AddTaskRequestModel, AllTasksModel, GetUserTaskModel;
import '../../features/Tasks_Screens/data/models/notifications_model.dart';
import '../../features/addEmployee/data/models/add_employee_model.dart';
import '../../features/auth/data/models/login_model.dart';
import '../../features/auth/screens/register/models/register_model.dart';
import '../../features/home/data/models/all_employees_model.dart';
import '../cache_helper/cache_helper.dart';

part 'web_services.g.dart';

@RestApi(baseUrl: ('https://eby-itsales.guessitt.com/public/itsales/'))
abstract class WebServices {
  factory WebServices(Dio dio, {String baseUrl}) = _WebServices;

  @POST('auth/authenticate')
  Future<LoginModel> loginSales(@Body() SalesModel sales);

  // @POST('users')
  // Future<register_model.RegisterModel> registerPublicUser(
  //     @Body() register_model.User user
  //     );


  @GET('users/me?fields=*.*')
  Future<GetUserInfo> getDataUser (@Header('Authorization') String token) ;

  @PATCH('users/{id}?fields=*.*')
  Future<GetUserInfo> editDataUser (@Header('Authorization') String token, @Path('id') String id,  @Body() EditUserRequestModel add) ;


  @POST('users')
  Future<AddUserModel> addUser (@Header('Authorization') String token, @Body() AddUserRequestModel add) ;

  @GET('users?fields=*.*')
  Future<AllUsersModel> allUsers (@Header('Authorization') String token ,  @Queries() Map<String, dynamic>? queryParams ) ;


  /// tasks
  @GET('items/tasks?fields=*.*.*')
  Future<AllTasksModel> getAllTasks (@Header('Authorization') String token ,  @Queries() Map<String, dynamic>? queryParams) ;
  // @Queries() Map<String, dynamic> queryParams
  @GET('items/tasks?fields=*.*.*&filter[assigned_to]={id}')
  Future<GetUserTaskModel> getUserTask (@Header('Authorization') String token, @Path('id') String id, @Queries() Map<String, dynamic>? queryParams) ;


  @POST('items/tasks?fields=*.*.*')
  Future<AddTaskModel> addTask (@Header('Authorization') String token, @Body() AddTaskRequestModel add) ;


  @PATCH('items/tasks/{id}?fields=*.*.*')
  Future<AddTaskModel> editTask (@Header('Authorization') String token,  @Path('id') String id,@Body() AddTaskRequestModel edit ) ;


  /// location
  @POST('items/locations')
  Future<LocationModel> addLocation (@Header('Authorization') String token, @Body() LocationRequestModel add) ;

  @PATCH('items/locations/{id}')
  Future<LocationModel> updateLocation (@Header('Authorization') String token,  @Path('id') String id,@Body() LocationRequestModel add ) ;

  @GET('items/locations?filter[task]={id}')
  Future<GetLocationModel> getOneLocation (@Header('Authorization') String token, @Path('id') String id) ;
  @GET('items/company?fields=*.*.*')
  Future<GetCompanyModel> getCompany(@Header('Authorization') String token, ) ;


  /// employees
  @POST('items/employees')
  Future<AddEmployeeModel> addEmployee (@Header('Authorization') String token, @Body() AddEmployeeRequestModel add) ;

  @GET('items/employees?fields=*.*.*')
  Future<AllEmployeeModel> getAllEmployee (@Header('Authorization') String token) ;

  @GET('items/employees?filter[user]={id}')
  Future<GetEmployeeModel> getEmployeeInfo (@Header('Authorization') String token, @Path('id') String id) ;

  @PATCH('items/employees/{id}')
  Future<AddEmployeeModel> editEmployee (@Header('Authorization') String token, @Path('id') String id,  @Body() AddEmployeeRequestModel add) ;


  /// notification
  @GET('items/notifications')
  Future<GetAllNotificationModel> getAllNotifications (@Header('Authorization') String token) ;

  @POST('items/notifications')
  Future<PostNotificationModel> postNotifications (@Header('Authorization') String token, @Body() DataNotificationUser data ) ;

  @GET('items/notifications?filter[user]={id}')
  Future<GetNotificationForUserModel> getNotificationsForOneUser (@Header('Authorization') String token, @Path('id') String id) ;

}


