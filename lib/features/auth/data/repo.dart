import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/features/HomeEmployee/models/get_company_model.dart';
import 'package:itsale/features/auth/data/models/login_model.dart' as login_model show GetUserInfo, LoginModel, SalesModel;
import 'package:retrofit/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../company/widgets/company_model.dart';
import '../screens/register/models/register_model.dart' as register_model show RegisterModel, SalesModel, User;

import '../../../core/remote_data_source/web_services.dart';
import '../../../core/utils/token.dart';
import '../../Tasks_Screens/data/models/get_task_model.dart';
import '../../Tasks_Screens/data/models/notifications_model.dart';
import '../../addEmployee/data/models/add_employee_model.dart';
import '../../home/data/models/all_employees_model.dart';

class Repository {
  final WebServices webServices;

  Repository(this.webServices);

  // LOGIN
  Future<login_model.LoginModel> loginSales(login_model.SalesModel sales) {
    return webServices.loginSales(sales);
  }

  Future<AddUserModel> addUser(AddUserRequestModel add) async {
   // await CacheHelper.getData(key: 'token', );

    if (token == null) {
      throw Exception('Authentication token not found.');
    }

    return webServices.addUser( add,'Bearer $token');

  }

  // REGISTER
  // Future<register_model.RegisterModel> registerSales(register_model.User user) {
  //   return webServices.registerPublicUser(user);
  // }
  // EMPLOYEES
  Future<AllEmployeeModel> getAllEmployee() async
  {
    return await webServices.getAllEmployee('Bearer $token');
  }


  Future<AddEmployeeModel> addEmployee(AddEmployeeRequestModel add) async
  {
    return await webServices.addEmployee('Bearer $token', add);
  }

  Future<GetEmployeeModel> getEmployeeInfo(String id) async
  {
    return await webServices.getEmployeeInfo('Bearer $token', id);
  }


  Future<AddEmployeeModel> editEmployee(String id,
      AddEmployeeRequestModel edit) async
  {
    return await webServices.editEmployee('Bearer $token', id, edit);
  }


  Future<AllTasksModel> getAllTasks([Map<String,dynamic>? queryParams]) async
  {
    return await webServices.getAllTasks('Bearer $token',queryParams);
  }




  Future<login_model.GetUserInfo> editDataUser(String id, EditUserRequestModel add) async
  {
    return await webServices.editDataUser('Bearer $token', id, add);
  }

  Future<AllUsersModel> allUsers([Map<String, dynamic>? queryParams]) async
  {
    return await webServices.allUsers('Bearer $token', queryParams);
  }

  Future<login_model.GetUserInfo> getDataUser() async
  {
    return await webServices.getDataUser('Bearer $token');
  }


  Future<GetUserTaskModel> getUserTask(String id,
      [Map<String, dynamic>? queryParams]) async
  {
    return await webServices.getUserTask('Bearer $token', id, queryParams);
  }


  Future<AddTaskModel> addTask(AddTaskRequestModel add) async
  {
    return await webServices.addTask('Bearer $token', add);
  }


  Future<AddTaskModel> editTask(String id, AddTaskRequestModel edit) async
  {
    return await webServices.editTask('Bearer $token', id, edit);
  }


  /// location
  Future<LocationModel> addLocation(LocationRequestModel add) async
  {
    return await webServices.addLocation('Bearer $token', add);
  }


  Future<LocationModel> updateLocation(String id,
      LocationRequestModel update) async
  {
    return await webServices.updateLocation('Bearer $token', id, update);
  }


  Future<GetLocationModel> getOneLocation(String id) async
  {
    return await webServices.getOneLocation('Bearer $token', id);
  }

  Future<CompanyModel> getCompany  () async
  {
    return await webServices.getCompany('Bearer $token', );
  }
  Future<GetAllNotificationModel> getAllNotifications() async
  {
    return await webServices.getAllNotifications('Bearer $token');
  }


  Future<PostNotificationModel> postNotifications(
      DataNotificationUser data) async
  {
    return await webServices.postNotifications('Bearer $token', data);
  }


  Future<GetNotificationForUserModel> getNotificationsForOneUser(
      String id) async
  {
    return await webServices.getNotificationsForOneUser('Bearer $token', id);
  }

  }

