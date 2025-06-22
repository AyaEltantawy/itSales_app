import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';
import 'package:itsale/features/Tasks_Screens/data/models/notifications_model.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:path/path.dart';

import '../../../../core/dio_helper.dart';
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
  int newNotificationCount = 0;

  getUserTaskFun({
    required String userId,
    String? status,
  }) async {
    if (await InternetConnectionChecker().hasConnection == false) {
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
      } else {
        print("Unable to show snackbar: context is null");
      }

      emit(NoInternetState());
    } else {
      emit(GetLoadingUserTaskState());
      Map<String, String> queryParams = {};
      if (status != null) {
        queryParams['filter[task_status][eq]'] = status;
      }

      await repo.getUserTask(userId, queryParams).then((value) {
        if (status != null) {
          emit(GetLoadingUserTaskStateForEmpScreens());
          getUserTaskListWithStatus = value.data;
          emit(GetSuccessUserTaskState());
        } else {
          getUserTaskList = value.data;
          emit(GetSuccessUserTaskState());
        }
      }).catchError((error, stackTrace) async {
        debugPrint('Error in getUserTaskFun: $error');
        debugPrint('Stack trace:\n$stackTrace');

        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );
          emit(NoInternetState());
        }
        emit(GetErrorUserTaskState());
      });
    }
  }

  var value;
  final AudioPlayer _player = AudioPlayer();

  Future<void> addTaskFun({
    required String status,
    required String title,
    required String description,
    required String client_phone,
    required String notes,
    required dynamic assigned_to,
    String? cancelled_date,
    required String client_name,
    String? complete_date,
    required String due_date,
    required String address,
    required String mapUrl,
    String? priority,
    String? start_date,
    required String task_status,
    required int company,
    String? location,
  }) async {
    emit(AddLoadingUserTaskState());

    try {
      final taskRequest = AddTaskRequestModel(
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
          company: company,
          location: location);

      value = await repo.addTask(taskRequest);

      emit(AddSuccessUserTaskState());

      await postLocationFun(
        title: title,
        description: description,
        client_phone: client_phone,
        notes: notes,
        assigned_to: assigned_to.toString(),
        // send as string if needed
        client_name: client_name,
        due_date: due_date,
        priority: priority ?? 'high',
        task_status: task_status,
        address: address,
        map_url: mapUrl,
        taskId: value.data!.id.toString(),
      );

      await postNotificationFun(
        isRead: false,
        message: 'راجع مهماتك الواردة: ${value.data!.title}',
        title: 'هناك مهمة جديدة',
        user: assigned_to.toString(),
      );
      getNotificationForOneUserFun();

      final context = MagicRouter.currentContext;
      if (context != null) {
        navigateTo(context, AppRoutes.tasks_screen_for_employee);
      }
    } catch (e, stackTrace) {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );
        emit(NoInternetState());
      }

      emit(AddErrorUserTaskState());

      debugPrint('🔴 ERROR: $e');
      debugPrint('📍 SOURCE: $stackTrace');
    }
  }

  Future editTaskFun(
      {required String taskId,
      String? status,
      String? title,
      String? description,
      String? client_phone,
      String? notes,
      int? assigned_to,
      String? cancelled_date,
      String? client_name,
      String? complete_date,
      String? due_date,
      String? priority,
      String? start_date,
      String? task_status,
      int? locationId,
      List<Files>? files,
      int? company}) async {
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
                complete_date: complete_date,
                due_date: due_date,
                location: locationId,
                priority: priority,
                start_date: start_date,
                task_status: task_status,
                company: company))
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
            user: value.data!.owner!);
      } else if (value.data!.task_status == 'completed') {
        postNotificationFun(
            isRead: false,
            message: ' تم اكتمال المهمة  ${title.toString()}',
            title: 'راجع المهمات',
            user: value.data!.owner!);
      }
    }).catchError((onError, stackTrace) async {
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
      print("stackTrace$stackTrace");
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
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
      } else {
        print("Unable to show snackbar: context is null");
      }

      emit(NoInternetState());
      return;
    }

    emit(GetLoadingAllTaskState());

    try {
      final filters = {'fields': '*.*', 'filter[company]': companyId};
      print("CompanyId: $companyId");

      final value = await repo.getAllTasks(filters);

      getAllTaskList = value.data;

      print("getAllTaskList length: ${getAllTaskList?.length}");

      // Loop through each task to find problematic assigned_to field

      emit(GetSuccessAllTaskState());
    } catch (error, stackTrace) {
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

      print('❌ Error getting tasks: $error');
      print(stackTrace);
    }
  }

  Future<void> getUserTasksWithSearchFilter({
    required String userId,
    String? status,
    String? date,
    String? location,
    String? sort,
    String? searchText,
  }) async {
    getTaskListForOneUserSearch = [];

    final hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
      }
      emit(NoInternetState());
      return;
    }

    emit(GetLoadingSearchTaskFilterState());

    Map<String, dynamic> queryParams = {
      'filter[company]': companyId,
      'filter[assigned_to.id][eq]': userId,
      'fields': '*.*',
    };

    if (status != null) {
      queryParams['filter[task_status][eq]'] = status;
    }

    if (date != null) {
      queryParams['filter[created_on][contains]'] = date;
    }

    if (location != null) {
      queryParams['filter[loc.address][eq]'] = location;
    }

    if (sort != null) {
      queryParams['sort'] = '-$sort';
    }

    if (searchText != null && searchText.isNotEmpty) {
      queryParams['q'] = searchText;
    }

    try {
      final value = await repo.getAllTasks(queryParams);
      getTaskListForOneUserSearch = value.data;
      emit(GetSuccessSearchTaskFilterState());
    } catch (onError, stackTrace) {
      if (!await InternetConnectionChecker().hasConnection) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );
        emit(NoInternetState());
      } else {
        emit(GetErrorSearchTaskFilterState());
        debugPrint('Error: ${onError.toString()}');
        print("stackTrace$stackTrace");
      }
    }
  }

  Future<void> getAllTasksFunWithFilter(
      {String? status,
      String? date,
      String? employee,
      String? location,
      String? sort,
      String? text,
      String? textEmp,
      String? search}) async {
    getUserTaskList = [];

    final hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(context, 'أنت غير متصل بالانترنت');
      } else {
        print("Unable to show snackbar: context is null");
      }

      emit(NoInternetState());
      return;
    }

    emit(GetLoadingAllTaskFilterState());

    Map<String, dynamic> queryParams = {
      'filter[company]': companyId,
      'fields': '*.*',
    };

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
      queryParams['filter[loc.address][eq]'] = location;
    }
    if (sort != null) {
      queryParams['sort'] = '-$sort';
      queryParams['limit'] = 3;
    }
    if (textEmp != null) {
      queryParams['q'] = textEmp;
      emit(GetLoadingSearchTaskFilterState());
    }
    if (text != null) {
      queryParams['q'] = text;
      emit(GetLoadingSearchTaskFilterState());
    }

    try {
      final value = await repo.getAllTasks(queryParams);

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
    } catch (onError, stackTrace) {
      if (!await InternetConnectionChecker().hasConnection) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );
        emit(NoInternetState());
      } else {
        if (text != null || textEmp != null) {
          emit(GetErrorSearchTaskFilterState());
        } else {
          emit(GetErrorAllTaskFilterState());
        }
        debugPrint('Error: ${onError.toString()}');
        print("stackTrace$stackTrace");
      }
    }
  }

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
        newNotificationCount = getNotificationsForOneUserList
                ?.where((notification) => notification.is_read == false)
                .length ??
            0;

        emit(GetSuccessAllNotificationState());
      }).catchError((onError, stackTrace) async {
        if (await InternetConnectionChecker().hasConnection == false) {
          Utils.showSnackBar(
            MagicRouter.currentContext!,
            'أنت غير متصل بالانترنت',
          );

          emit(NoInternetState());
        }
        emit(GetErrorAllNotificationState());
        debugPrint('errrrrror ${onError.toString()}');
        print(stackTrace);
      });
    }
  }

  void updateNotificationCount(getNotificationsList) {
    print("🔍 updateNotificationCount called");

    try {
      final currentUserIdInt = int.parse(userId.toString());
      final previousCount = newNotificationCount;
      print("📦 previousCount = $previousCount");

      newNotificationCount = getNotificationsForOneUserList!.where((n) {
        print(
            '🔔 Checking notification: user=${n.user.runtimeType}=${n.user}, is_read=${n.is_read}');
        return n.is_read != true && n.user == currentUserIdInt;
      }).length;
      print('📢 Unread notifications count: $newNotificationCount');
      print("📦 newNotificationCount = $newNotificationCount");
      if (newNotificationCount > previousCount - 1 &&
          newNotificationCount != 0 &&
          previousCount != 0) {
        try {
          _player.play(AssetSource('sounds/bell-notification-337658.mp3'));

          print("🔊 Sound played successfully");
        } catch (e) {
          print("🔴 Failed to play sound: $e");
        }
      }

      emit(NewNotificationState());
    } catch (e, stacktrace) {
      print("❌ updateNotificationCount failed: $e");
      print(stacktrace);
    }
  }

  void markAllNotificationsAsReadLocally() {
    if (getNotificationsList == null || getNotificationsList!.isEmpty) {
      print('No notifications to mark as read.');

      emit(GetSuccessUserNotificationState());
      return;
    }

    bool anyChanged = false;
    for (var notification in getNotificationsList!) {
      if (notification.is_read == false) {
        notification.is_read = true;
        anyChanged = true;
      }
    }

    if (!anyChanged) {
      print('All notifications were already marked as read.');
      emit(GetSuccessUserNotificationState());
      return;
    }

    newNotificationCount = 0;
    emit(GetSuccessUserNotificationState());

    print('All notifications marked as read locally, UI updated.');
  }

  List<DataNotificationUser>? getNotificationsForOneUserList = [];

  getNotificationForOneUserFun() async {
    if (await InternetConnectionChecker().hasConnection == false) {
      final context = MagicRouter.currentContext;
      if (context != null) {
        Utils.showSnackBar(
          context,
          'أنت غير متصل بالانترنت',
        );
      }

      emit(NoInternetState());
    } else {
      emit(GetLoadingUserNotificationState());

      await repo.getNotificationsForOneUser(userId.toString()).then((value) {
        getNotificationsForOneUserList = value.data;
        getNotificationsList = value.data;
        newNotificationCount = getNotificationsList
                ?.where((notification) => notification.is_read == false)
                .length ??
            0;

        emit(GetSuccessUserNotificationState());

        updateNotificationCount(getNotificationsList);
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

  void notifyNew() {
    newNotificationCount = 1;
    emit(NewNotificationState());
  }

  void clearNotificationBadge() {
    newNotificationCount = 0;
    emit(ClearNotificationState());
  }

  postNotificationFun({
    bool? isRead,
    String? message,
    String? title,
    dynamic? user,
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

      getNotificationForOneUserFun();
    }).catchError((onError, stackTrace) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }
      emit(PostErrorAllNotificationState());
      debugPrint('errrrrror ${onError.toString()}');
      print("stackTrace:$StackTrace");
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
    required dynamic? assigned_to,
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
    }).catchError((onError, stackTrace) async {
      if (await InternetConnectionChecker().hasConnection == false) {
        Utils.showSnackBar(
          MagicRouter.currentContext!,
          'أنت غير متصل بالانترنت',
        );

        emit(NoInternetState());
      }
      emit(PostErrorLocationState());
      debugPrint('error add location ${onError.toString()}');

      debugPrint('Stack trace: $stackTrace');
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
    int? assigned_to,
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
        company: companyId,
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
    required int assigned_to,
    required String client_name,
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
          locationId: value.location_data![0].id.toString(),
          title: title,
          description: description,
          client_phone: client_phone,
          notes: notes,
          taskId: taskId,
          address: address,
          map_url: map_url,
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

  Future<void> updateNotifications() async {
    emit(UpdateNotificationsLoading());

    try {
      for (var notification in getNotificationsForOneUserList ?? []) {
        if (notification.is_read == false || notification.is_read == null) {
          final body = {"is_read": true};

          final response = await DioHelper.patch(
            "items/notifications/${notification.id}",
            true,
            body: body,
          );

          print("Marked as read: ${notification.id} => ${response.data}");
        }
      }

      newNotificationCount = 0;
      emit(UpdateNotificationsSuccess());

      print('Update notifications completed successfully.');
    } catch (e, stacktrace) {
      print('Error updating notifications: $e');
      print(stacktrace);
      emit(UpdateNotificationsError());
    }
  }
}
