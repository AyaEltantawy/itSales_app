import 'dart:io';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:path/path.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';
import 'package:itsale/features/Tasks_Screens/data/models/notifications_model.dart';
import 'package:itsale/features/auth/data/repo.dart';

import '../../../../core/utils/snack_bar.dart';
import '../../../../core/utils/token.dart';
import '../models/get_task_model.dart';

class TasksCubit extends Cubit<TasksStates> {
  Repository repo;

  TasksCubit(this.repo) : super(InitialTaskState());

  static TasksCubit get(context) => BlocProvider.of(context);

  List<DataUserTask>? getUserTaskList = [];
  List<DataUserTask>? getUserTaskListWithStatus = [];
  List<DataUserTask>? data;

  getUserTaskFun({
    required String userId,
    String? status,
  }) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );

      emit(NoInternetState());
    } else {
      emit(GetLoadingUserTaskState());
      Map<String, String> queryParams = {};
      if (status != null) {
        // 'filter[companies.id]':getUserTaskList?[1].companies?.,
        queryParams['filter[task_status][eq]'] = status;
      }
      await repo.getUserTask(userId, queryParams).then((value) {
        if (status != null) {
          emit(GetLoadingUserTaskStateForEmpScreens());

          getUserTaskListWithStatus = value.data;
          emit(GetSuccessUserTaskState());
        } else if (status == null) {
          getUserTaskList = value.data;

          emit(GetSuccessUserTaskState());
        }
      }).catchError((onError) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }
        emit(GetErrorUserTaskState());
        debugPrint('error get task user ${onError.toString()}');
      });
    }
  }

  addTaskFun({
    required String status,
    required String title,
    required String description,
    required String client_phone,
    required String notes,
    required String assigned_to,
    String? cancelled_date,
    required String client_name,
    String? complete_date,
    required String due_date,
    required String address,
    required String mapUrl,
    String? priority,
    String? start_date,
    required String task_status,
  }) async {
    emit(AddLoadingUserTaskState());

    await repo
        .addTask(AddTaskRequestModel(
      status: status,
      title: title,
      description: description,
      client_phone: client_phone,
      notes: notes,
      assigned_to: assigned_to,
      cancelled_date: cancelled_date,
      client_name: client_name,
      complete_date: complete_date,
      due_date: due_date,
      priority: priority,
      start_date: start_date,
      task_status: task_status,
    ))
        .then((value) {
      emit(AddSuccessUserTaskState());
      postLocationFun(
          title: title,
          description: description,
          client_phone: client_phone,
          notes: notes,
          assigned_to: assigned_to,
          client_name: client_name,
          due_date: due_date,
          priority: 'high',
          task_status: task_status,
          address: address,
          map_url: mapUrl,
          taskId: value.data!.id.toString());

      postNotificationFun(
          isRead: false,
          message: ' راجع مهماتك الواردة:  ${value.data!.title.toString()}',
          title: 'هناك مهمة جديدة',
          user: value.data!.assigned_to!.id!.toInt());
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }

      emit(AddErrorUserTaskState());
      debugPrint('errrrrror ${onError.toString()}');
    });
  }

  Future editTaskFun({
    required String taskId,
    String? status,
    String? title,
    String? description,
    String? client_phone,
    String? notes,
    String? assigned_to,
    String? cancelled_date,
    String? client_name,
    String? complete_date,
    String? due_date,
    String? priority,
    String? start_date,
    String? task_status,
    int? locationId,
    List<Files>? files,
  }) async {
    emit(EditLoadingUserTaskState());

    await repo
        .editTask(
            taskId,
            AddTaskRequestModel(
              status: status,
              title: title,
              files: files,
              description: description,
              client_phone: client_phone,
              notes: notes,
              assigned_to: assigned_to,
              cancelled_date: cancelled_date,
              client_name: client_name,
              complete_date: complete_date ?? '2024-11-18',
              due_date: due_date,
              location: locationId,
              priority: priority,
              start_date: start_date,
              task_status: task_status,
            ))
        .then((value) {
      emit(EditSuccessUserTaskState());
      getAllTasksFun();
      getUserTaskFun(userId: userId.toString());
      getUserTaskFun(userId: userId.toString(), status: 'inbox');
      if (value.data!.task_status == 'progress') {
        postNotificationFun(
            isRead: false,
            message: ' تم استلام المهمة  ${title.toString()}',
            title: 'راجع المهمات',
            user: value.data!.owner!.id!.toInt());
      } else if (value.data!.task_status == 'completed') {
        postNotificationFun(
            isRead: false,
            message: ' تم اكتمال المهمة  ${title.toString()}',
            title: 'راجع المهمات',
            user: value.data!.owner!.id!.toInt());
      }
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }
      emit(EditErrorUserTaskState());
      if (onError.toString().contains('null')) {
        emit(EditSuccessUserTaskState());
        getAllTasksFun();
      }
      debugPrint('error edit task ${onError.toString()}');
    });
  }


  List<DataAllTasks>? getLastTaskList = [];
  List<DataAllTasks>? getLastTaskListForOneUser = [];
  List<DataAllTasks>? getTaskListForOneUserSearch = [];
  List<DataAllTasks>? getAllTaskListFilter = [];
  List<DataAllTasks>? getAllTaskList = [];
  Future<void> getAllTasksFun() async {
    final hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );
      emit(NoInternetState());
      return;
    }

    emit(GetLoadingAllTaskState());

    try {
      int? companyId;

      // Optional: Try to use previously loaded tasks to get the companyId
      if (getAllTaskList != null && getAllTaskList!.isNotEmpty) {
        companyId = getAllTaskList!.first.owner?.companyId;
      }

      final filters = <String, dynamic>{
        'fields': '*.*.*',
        if (companyId != null) 'filter[companies.id]': companyId.toInt(),
      };

      final value = await repo.getAllTasks(filters);

      getAllTaskList = value.data;
      emit(GetSuccessAllTaskState());
    } catch (error) {
      final stillHasInternet = await InternetConnectionChecker().hasConnection;
      if (!stillHasInternet) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );
        emit(NoInternetState());
        return;
      }

      emit(GetErrorAllTaskState());
      debugPrint('❌ Error getting tasks: $error');
    }
  }







  getAllTasksFunWithFilter({
    String? status,
    String? date,
    String? employee,
    String? location,
    String? sort,
    String? text,
    String? textEmp,
  }) async {
    getUserTaskList = [];
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );
      emit(NoInternetState());
      return;
    } else {
      emit(GetLoadingAllTaskFilterState());

      Map<String, String> queryParams = {};

      if (status != null) {
        queryParams['filter[task_status][eq]'] = status;
      }
      if (date != null) {
        queryParams['filter[created_on][contains]'] = date;
      }
      if (employee != null) {
        queryParams['filter[assigned_to.id][eq]'] = employee;
      }
      if (location != null) {
        queryParams['filter[location.address][eq]'] = location;
      }
      if (sort != null) {
        queryParams['limit=3&sort'] = '-$sort';
      }
      if (textEmp != null) {
        queryParams['q'] = textEmp;
        emit(GetLoadingSearchTaskFilterState());
      }
      if (text != null) {
        queryParams['q'] = text;
        emit(GetLoadingSearchTaskFilterState());
      }
      await repo.getAllTasks(queryParams).then((value) {
        if (textEmp != null && employee != null) {
          getTaskListForOneUserSearch = value.data;
          emit(GetSuccessSearchTaskFilterState());
        } else if (text != null) {
          getAllTaskListFilter = value.data;
          emit(GetSuccessSearchTaskFilterState());
        } else {
          getAllTaskListFilter = value.data;
          emit(GetSuccessAllTaskFilterState());
        }
        if (sort != null) {
          getLastTaskList = value.data;
        }

        if (sort != null && employee != null) {
          getLastTaskListForOneUser = value.data;
        }
        emit(GetSuccessAllTaskFilterState());
      }).catchError((onError) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );
          emit(NoInternetState());
        } else {
          if (text != null) {
            emit(GetErrorSearchTaskFilterState());
          }
          emit(GetErrorAllTaskFilterState());
          debugPrint('Error: ${onError.toString()}');
        }
      });
    }
  }

  /// notification

  List<DataNotificationUser>? getNotificationsList = [];

  getAllNotificationFun() async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );

      emit(NoInternetState());
    } else {
      emit(GetLoadingAllNotificationState());

      await repo.getAllNotifications().then((value) {
        getNotificationsList = value.data;

        emit(GetSuccessAllNotificationState());
      }).catchError((onError) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }
        emit(GetErrorAllNotificationState());
        debugPrint('errrrrror ${onError.toString()}');
      });
    }
  }

  List<DataNotificationUser>? getNotificationsForOneUserList = [];

  getNotificationForOneUserFun() async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );

      emit(NoInternetState());
    } else {
      emit(GetLoadingUserNotificationState());

      await repo.getNotificationsForOneUser(userId.toString()).then((value) {
        getNotificationsForOneUserList = value.data;
        getNotificationsList = value.data;

        emit(GetSuccessUserNotificationState());
      }).catchError((onError) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }

        emit(GetErrorUserNotificationState());
        debugPrint('errrrrror ${onError.toString()}');
      });
    }
  }

  postNotificationFun({
    required bool isRead,
    required String message,
    required String title,
    required int user,
  }) async {
    emit(PostLoadingAllNotificationState());

    await repo
        .postNotifications(DataNotificationUser(
      status: 'published',
      is_read: isRead,
      message: message,
      title: title,
      user: user,
    ))
        .then((value) {
      emit(PostSuccessAllNotificationState());
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }
      emit(PostErrorAllNotificationState());
      debugPrint('errrrrror ${onError.toString()}');
    });
  }

  /// location
  postLocationFun({
    required String address,
    required String map_url,
    required String taskId,
    required String title,
    required String description,
    required String client_phone,
    required String notes,
    required String assigned_to,
    required String client_name,
    required String due_date,
    required String priority,
    required String task_status,
  }) async {
    emit(PostLoadingLocationState());

    await repo
        .addLocation(LocationRequestModel(
      status: 'published',
      address: address,
      latitude: '99999999',
      longitude: '88888888',
      map_url: map_url,
      task: taskId,
    ))
        .then((value) {
      emit(PostSuccessLocationState());
      editTaskFun(
        status: 'published',
        taskId: taskId,
        title: title,
        description: description,
        client_phone: client_phone,
        notes: notes,
        assigned_to: assigned_to,
        client_name: client_name,
        due_date: due_date,
        priority: priority,
        task_status: task_status,
        locationId: value.data!.id!.toInt(),
      );
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }
      emit(PostErrorLocationState());
      debugPrint('error add location ${onError.toString()}');
    });
  }

  updateLocationFun({
    required String locationId,
    String? address,
    String? map_url,
    required String? taskId,
    String? title,
    String? description,
    String? client_phone,
    String? notes,
    String? assigned_to,
    String? cancelled_date,
    String? client_name,
    String? complete_date,
    String? due_date,
    List<Files>? files,
    String? start_date,
    String? task_status,
  }) async {
    emit(UpdateLoadingLocationState());

    await repo
        .updateLocation(
            locationId,
            LocationRequestModel(
              status: 'published',
              address: address,
              longitude: '999998',
              latitude: '99999999',
              map_url: map_url,
              task: taskId,
            ))
        .then((value) {
      emit(UpdateSuccessLocationState());
      editTaskFun(
        status: 'published',
        taskId: taskId.toString(),
        title: title,
        description: description,
        client_phone: client_phone,
        notes: notes,
        assigned_to: assigned_to,
        files: files,
        client_name: client_name,
        due_date: due_date,
        priority: 'high',
        complete_date: complete_date ??
            DateFormat('yyyy-MM-dd', 'en').format(DateTime.now()),
        task_status: task_status,
        locationId: value.data!.id!.toInt(),
      );
    }).catchError((onError) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }

      emit(UpdateErrorLocationState());
      debugPrint('errrrrror ${onError.toString()}');
    });
  }

  getLocationFun({
    required String taskId,
    required String address,
    required String map_url,
    required String title,
    required String description,
    required String client_phone,
    required String notes,
    required String assigned_to,
//  required String cancelled_date,
    required String client_name,
    // required String complete_date,
    required String due_date,
    required String task_status,
  }) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      Utils.showSnackBar(
        MagicRouter.currentContext!,
        'أنت غير متصل بالانترنت',
      );

      emit(NoInternetState());
    } else {
      emit(GetLoadingLocationState());

      await repo.getOneLocation(taskId).then((value) {
        emit(GetSuccessLocationState());
        updateLocationFun(
          locationId: value.data![0].id.toString(),
          title: title,
          description: description,
          client_phone: client_phone,
          notes: notes,
          taskId: taskId,
          address: address,
          map_url: map_url,
          // complete_date: complete_date,
          //  cancelled_date: cancelled_date,
          assigned_to: assigned_to,

          client_name: client_name,

          due_date: due_date,

          task_status: task_status,
        );
      }).catchError((onError) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }
        emit(GetErrorLocationState());
        debugPrint('errrrrror ${onError.toString()}');
      });
    }
  }

  int? idFiles;

  Future<int?> uploadFileInTasks(
    File file,
  ) async {
    Dio dio = Dio();
    try {
      emit(UploadLoadingFilesState());
      String baseUrl =
          "https://eby-itsales.guessitt.com/public/itsales/"; // Replace with your base URL
      String endpoint = "files";
      String fileName = basename(file.path);

      FormData formData = FormData.fromMap({
        "data": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      Response response = await dio.post(
        "$baseUrl$endpoint",
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(UploadSuccessFilesState());
        print("File uploaded successfully!");
        idFiles = response.data['data']['id'];
        print(response.data['data']['id']);

        return idFiles;
      } else {
        emit(UploadErrorFilesState());
        print("File upload failed with status: ${response.statusCode}");
      }
      return idFiles;
    } catch (e) {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }
      emit(UploadErrorFilesState());
      print("Error during file upload: $e");
    }
    return idFiles;
  }
}
