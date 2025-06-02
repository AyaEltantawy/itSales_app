import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/utils/transition.dart';
import 'package:itsale/features/Tasks_Screens/components/task_list.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';
import 'package:itsale/features/Tasks_Screens/screens/task_details.dart';
import 'package:itsale/features/addEmployee/components/no_data_screen.dart';
import '../../../core/app/app.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/constants/app_fonts.dart';
import '../../../core/utils/token.dart';
import '../../addEmployee/screens/add_employee.dart';
import '../../home/components/widgets_for_tasks_screen.dart';
import '../../home/data/cubit.dart';
import '../components/widget_of_tasks_grid.dart';
import '../data/models/get_task_model.dart' show AssignedTo;

class TasksScreenForEmployee extends StatefulWidget {
  TasksScreenForEmployee({super.key, required this.back, this.task});

  final bool back;
  final bool? task;

  @override
  State<TasksScreenForEmployee> createState() => _TasksScreenForEmployeeState();
}

class _TasksScreenForEmployeeState extends State<TasksScreenForEmployee> {
  bool isGrid = false;
  bool showSearch = false;

  void toggleViewMode() {
    setState(() {
      isGrid = !isGrid;
    });
  }

  @override
  void initState() {
    TasksCubit.get(context).data;
    role == "3"
        ? TasksCubit.get(context).getUserTaskFun(userId: userId.toString())
        : TasksCubit.get(context).getAllTasksFun();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshData() async {
      if (role == '3') {
        await TasksCubit.get(context).getUserTaskFun(userId: userId.toString());
      } else {
        await TasksCubit.get(context).getAllTasksFun();
      }
    }

    return Scaffold(
        body: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 50.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_back),
                              //CustomAppBar(back: widget.back, title: ),
                              Text(AppLocalizations.of(context)!
                                  .translate("tasks")),
                            ],
                          ),
                          BuildSearchFilter(
                            onTap: () {
                              setState(() {
                                showSearch = !showSearch;
                              });
                            },
                            isGrid: false,
                            emp: false,
                            task: true,
                            admin: false,
                            toggleViewMode: toggleViewMode,
                          )
                        ],
                      ),
                      if (showSearch) ...[
                        SizedBox(height: 30.h),
                        Container(
                            height: 40.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: globalDark
                                  ? AppColors.cardColorDark
                                  : AppColors.cardColor,
                              border: Border.all(
                                color: globalDark
                                    ? AppColors.borderColorDark
                                    : AppColors.borderColor,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),
                            child: TextFormField(
                                textDirection: TextDirection.rtl,
                                onFieldSubmitted: (value) {
                                  (widget.task == true)
                                      ? (role == '1'
                                          ? TasksCubit.get(context)
                                              .getAllTasksFunWithFilter(
                                                  text: value)
                                          : TasksCubit.get(context)
                                              .getAllTasksFunWithFilter(
                                                  textEmp: value,
                                                  employee: userId))
                                      : EmployeeCubit.get(context)
                                          .getAdmins(search: value.toString());
                                },
                                onChanged: (value) {
                                  (widget.task == true)
                                      ? (role == '1'
                                          ? TasksCubit.get(context)
                                              .getAllTasksFunWithFilter(
                                                  text: value)
                                          : TasksCubit.get(context)
                                              .getAllTasksFunWithFilter(
                                                  textEmp: value,
                                                  employee: userId))
                                      : EmployeeCubit.get(context)
                                          .getAdmins(search: value.toString());
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        SvgPicture.asset(AppIcons.searchIcon),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20.w),
                                  prefixIconConstraints: const BoxConstraints(
                                      minWidth: 20, minHeight: 20),
                                  labelText: 'ابحث هنا',
                                  labelStyle: AppFonts.style14normal,
                                )))
                      ],
                      BlocConsumer<TasksCubit, TasksStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is NoInternetState) {
                              return const NoInternet();
                            }
                            if (state is GetLoadingSearchTaskFilterState) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  const LinearProgressIndicator(),
                                ],
                              );
                            }

                            if (state is GetSuccessSearchTaskFilterState) {
                              return role == '1'
                                  ? (TasksCubit.get(context)
                                          .getAllTaskListFilter!
                                          .isNotEmpty
                                      ? TaskListFilter(isGrid: isGrid)
                                      : nothing(context,
                                          route: AppRoutes.addTask,
                                          button: 'مهمة',
                                          text: 'لا يوجد'))
                                  : (TasksCubit.get(context)
                                          .getTaskListForOneUserSearch!
                                          .isNotEmpty
                                      ? TaskListFilter(isGrid: isGrid)
                                      : nothing(context,
                                          route: AppRoutes.addTask,
                                          button: 'مهمة   ',
                                          text: 'لا يوجد'));
                            }
                            if (state is GetLoadingUserTaskState ||
                                state is GetLoadingAllTaskState ||
                                state is GetLoadingAllTaskFilterState) {
                              return AppLottie.loader;
                            }
                            if (state is GetSuccessAllTaskFilterState) {
                              return TasksCubit.get(context)
                                      .getAllTaskListFilter!
                                      .isNotEmpty
                                  ? TaskListFilter(isGrid: isGrid)
                                  : nothing(context,
                                      route: AppRoutes.addTask,
                                      button: 'مهمة',
                                      text: 'لا يوجد');
                            }

                            return (TasksCubit.get(context)
                                        .getUserTaskList!
                                        .isNotEmpty ||
                                    TasksCubit.get(context)
                                        .getAllTaskList!
                                        .isNotEmpty)
                                ? TaskList(isGrid: isGrid)
                                : nothing(context,
                                    route: AppRoutes.addTask,
                                    button: 'مهمة',
                                    text: 'لا يوجد مهام الى الان');
                          }),
                    ],
                  ),
                ),
              ),
            )));
  }
}

class TaskList extends StatelessWidget {
  final bool isGrid;

  const TaskList({super.key, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          isGrid
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2 / 3.3,
                  ),
                  itemCount: role == "3"
                      ? cubit.getUserTaskList!.length
                      : cubit.getAllTaskList!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          animatedNavigation(
                              screen: TaskDetailsScreen(
                            file: role == "3"
                                ? (cubit.getUserTaskList![index].files!
                                            .isNotEmpty ||
                                        cubit.getUserTaskList![index].files !=
                                            null
                                    ? cubit.getUserTaskList![index].files
                                    : [])
                                : (cubit.getAllTaskList![index].files!
                                            .isNotEmpty ||
                                        cubit.getAllTaskList![index].files !=
                                            null
                                    ? cubit.getAllTaskList![index].files
                                    : []),
                            task_status: role == "3"
                                ? cubit.getUserTaskList![index].task_status
                                    .toString()
                                : cubit.getAllTaskList![index].task_status
                                    .toString(),
                            locationId: role == "3"
                                ? (cubit.getUserTaskList![index].loc != null
                                    ? cubit
                                        .getUserTaskList![index].loc![index].id
                                        .toString()
                                    : '10')
                                : '',
                            id: role == "3"
                                ? cubit.getUserTaskList![index].id!.toInt()
                                : cubit.getAllTaskList![index].id!.toInt(),
                            nameTask: role == "3"
                                ? cubit.getUserTaskList![index].title.toString()
                                : cubit.getAllTaskList![index].title.toString(),
                            nameEmployee: role != "3"
                                ? '${TasksCubit.get(context).getAllTaskList![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getAllTaskList![index].assigned_to!.last_name.toString()}'
                                : '${TasksCubit.get(context).getUserTaskList![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getUserTaskList![index].assigned_to!.last_name.toString()}',
                            nameClient: role == "3"
                                ? cubit.getUserTaskList![index].client_name
                                    .toString()
                                : cubit.getAllTaskList![index].client_name
                                    .toString(),
                            phoneClient: role == "3"
                                ? cubit.getUserTaskList![index].client_phone
                                    .toString()
                                : cubit.getAllTaskList![index].client_phone
                                    .toString(),
                            notes: role == "3"
                                ? cubit.getUserTaskList![index].notes.toString()
                                : cubit.getAllTaskList![index].notes.toString(),
                            // Address
                            address: role != '3'
                                ? (cubit.getAllTaskList![index].loc?[index]
                                        .address ??
                                    'لا يوجد')
                                : (cubit.getUserTaskList![index].location
                                        ?.address ??
                                    'لا يوجد'),

// Map URL
                            link: role != '3'
                                ? (cubit.getAllTaskList![index].loc?[index]
                                        ?.mapUrl ??
                                    '')
                                : (cubit.getUserTaskList![index].loc?[index]
                                        ?.mapUrl ??
                                    'لا يوجد'),

                            deadline: role == "3"
                                ? cubit.getUserTaskList![index].due_date
                                    .toString()
                                : cubit.getAllTaskList![index].due_date
                                    .toString(),
                            description: role == "3"
                                ? cubit.getUserTaskList![index].description
                                    .toString()
                                : cubit.getAllTaskList![index].description
                                    .toString(),
                          )));
                    },
                    child: TaskCardGrid(
                      detailsUser: role == '3' ? true : null,
                      cancelDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .cancelled_date
                              .toString()
                          : '',
                      completeDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .complete_date
                              .toString()
                          : '',
                      createDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .created_on
                              .toString()
                          : '',
                      progressDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .modified_on
                              .toString()
                          : '',
                      avatar: role == "3"
                          ? (TasksCubit.get(context)
                                      .getUserTaskList![index]
                                      .assigned_to!
                                      .avatar !=
                                  null
                              ? TasksCubit.get(context)
                                  .getUserTaskList![index]
                                  .assigned_to!
                                  .avatar!
                                  .location_data!
                                  .full_url
                                  .toString()
                              : 'null')
                          : (TasksCubit.get(context)
                                      .getAllTaskList![index]
                                      .assigned_to!
                                      .avatar !=
                                  null
                              ? TasksCubit.get(context)
                                  .getAllTaskList![index]
                                  .assigned_to!
                                  .avatar!
                                  .location_data!
                                  .full_url
                                  .toString()
                              : 'null'),
                      names: role == '3'
                          ? '${TasksCubit.get(context).getUserTaskList![index].assigned_to?.first_name ?? ''} ${TasksCubit.get(context).getUserTaskList![index].assigned_to?.last_name ?? ''}'
                          : '${TasksCubit.get(context).getAllTaskList![index].assigned_to?.first_name ?? ''} ${TasksCubit.get(context).getAllTaskList![index].assigned_to?.last_name ?? ''}',
                      statusColor: AppColors.inbox,
                      statusText: role == "3"
                          ? cubit.getUserTaskList![index].task_status.toString()
                          : cubit.getAllTaskList![index].task_status.toString(),
                      taskName: role == "3"
                          ? cubit.getUserTaskList![index].title.toString()
                          : cubit.getAllTaskList![index].title.toString(),
                      taskNotes: role == "3"
                          ? cubit.getUserTaskList![index].notes.toString()
                          : cubit.getAllTaskList![index].notes.toString(),
                      index: index,
                      location: role != '3'
                          ? (cubit.getAllTaskList![index].loc != null
                              ? cubit.getAllTaskList![index].loc![index].address
                                  .toString()
                              : 'لا يوجد')
                          : (cubit.getUserTaskList![index].loc != null
                              ? cubit
                                  .getUserTaskList![index].loc![index].address
                                  .toString()
                              : 'لا يوجد'),
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: role == "3"
                      ? cubit.getUserTaskList!.length
                      : cubit.getAllTaskList!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          animatedNavigation(
                              screen: TaskDetailsScreen(
                            file: role == "3"
                                ? (cubit.getUserTaskList![index].files!
                                            .isNotEmpty ||
                                        cubit.getUserTaskList![index].files !=
                                            null
                                    ? cubit.getUserTaskList![index].files
                                    : [])
                                : (cubit.getAllTaskList![index].files!
                                            .isNotEmpty ||
                                        cubit.getAllTaskList![index].files !=
                                            null
                                    ? cubit.getAllTaskList![index].files
                                    : []),
                            task_status: role == "3"
                                ? cubit.getUserTaskList![index].task_status
                                    .toString()
                                : cubit.getAllTaskList![index].task_status
                                    .toString(),
                            locationId: role == "3"
                                ? (cubit.getUserTaskList![index].loc != null &&
                                        cubit.getUserTaskList![index].loc!
                                            .isNotEmpty
                                    ? cubit.getUserTaskList![index].loc![0].id
                                        .toString()
                                    : '10')
                                : '',
                            id: role == "3"
                                ? cubit.getUserTaskList![index].id!.toInt()
                                : cubit.getAllTaskList![index].id!.toInt(),
                            nameTask: role == "3"
                                ? cubit.getUserTaskList![index].title.toString()
                                : cubit.getAllTaskList![index].title.toString(),
                            nameEmployee: role != "3"
                                ? '${TasksCubit.get(context).getAllTaskList![index].assigned_to?.first_name ?? ''} ${TasksCubit.get(context).getAllTaskList![index].assigned_to?.last_name ?? ''}'
                                : '${TasksCubit.get(context).getUserTaskList![index].assigned_to?['first_name'] ?? ''} ${TasksCubit.get(context).getUserTaskList![index].assigned_to?['last_name'] ?? ''}',
                            nameClient: role == "3"
                                ? cubit.getUserTaskList![index].client_name
                                    .toString()
                                : cubit.getAllTaskList![index].client_name
                                    .toString(),
                            phoneClient: role == "3"
                                ? cubit.getUserTaskList![index].client_phone
                                    .toString()
                                : cubit.getAllTaskList![index].client_phone
                                    .toString(),
                            notes: role == "3"
                                ? cubit.getUserTaskList![index].notes.toString()
                                : cubit.getAllTaskList![index].notes.toString(),
                            address: role != '3'
                                ? (cubit.getAllTaskList![index].loc != null &&
                                        cubit.getAllTaskList![index].loc!
                                            .isNotEmpty
                                    ? cubit
                                        .getAllTaskList![index].loc![0].address
                                        .toString()
                                    : 'لا يوجد')
                                : (cubit.getUserTaskList![index].loc != null &&
                                        cubit.getUserTaskList![index].loc!
                                            .isNotEmpty
                                    ? cubit
                                        .getUserTaskList![index].loc![0].address
                                        .toString()
                                    : 'لا يوجد'),
                            link: role != '3'
                                ? (cubit.getAllTaskList![index].loc != null &&
                                        cubit.getAllTaskList![index].loc!
                                            .isNotEmpty
                                    ? cubit
                                        .getAllTaskList![index].loc![0].mapUrl
                                        .toString()
                                    : 'لا يوجد')
                                : (cubit.getUserTaskList![index].loc != null &&
                                        cubit.getUserTaskList![index].loc!
                                            .isNotEmpty
                                    ? cubit
                                        .getUserTaskList![index].loc![0].mapUrl
                                        .toString()
                                    : 'لا يوجد'),
                            deadline: role == "3"
                                ? cubit.getUserTaskList![index].due_date
                                    .toString()
                                : cubit.getAllTaskList![index].due_date
                                    .toString(),
                            description: role == "3"
                                ? cubit.getUserTaskList![index].description
                                    .toString()
                                : cubit.getAllTaskList![index].description
                                    .toString(),
                          )));
                    },
                    child: TaskCardList(
                      detailsUser: role == '3' ? true : null,
                      cancelDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .cancelled_date
                              .toString()
                          : '',
                      completeDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .complete_date
                              .toString()
                          : '',
                      createDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .created_on
                              .toString()
                          : '',
                      progressDate: role == '3'
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .modified_on
                              .toString()
                          : '',
                      avatar: role == "3"
                          ? (TasksCubit.get(context)
                                  .getUserTaskList![index]
                                  .assigned_to is AssignedTo
                              ? TasksCubit.get(context)
                                      .getUserTaskList![index]
                                      .assigned_to
                                      ?.avatar
                                      ?.location_data
                                      ?.full_url
                                      ?.toString() ??
                                  'null'
                              : 'null')
                          : (TasksCubit.get(context)
                                  .getAllTaskList![index]
                                  .assigned_to is AssignedTo
                              ? TasksCubit.get(context)
                                      .getAllTaskList![index]
                                      .assigned_to
                                      ?.avatar
                                      ?.location_data
                                      ?.full_url
                                      ?.toString() ??
                                  'null'
                              : 'null'),
                      names: role == '3'
                          ? '${TasksCubit.get(context).getUserTaskList![index].assigned_to!['first_name']} ${TasksCubit.get(context).getUserTaskList![index].assigned_to!['last_name']}'
                          : '${TasksCubit.get(context).getAllTaskList![index].assigned_to?.first_name ?? ''} ${TasksCubit.get(context)};}',
                      statusColor: Colors.green,
                      statusText: role == "3"
                          ? cubit.getUserTaskList![index].task_status.toString()
                          : cubit.getAllTaskList![index].task_status.toString(),
                      taskName: role == "3"
                          ? cubit.getUserTaskList![index].title.toString()
                          : cubit.getAllTaskList![index].title.toString(),
                      taskNotes: role == "3"
                          ? cubit.getUserTaskList![index].notes.toString()
                          : cubit.getAllTaskList![index].notes.toString(),
                      index: index,
                      textDate: 'مهلة المهمة',
                      location: role != '3'
                          ? (cubit.getAllTaskList != null &&
                                  cubit.getAllTaskList!.isNotEmpty &&
                                  cubit.getAllTaskList![index].loc != null &&
                                  cubit
                                      .getAllTaskList![index].loc!.isNotEmpty &&
                                  cubit.getAllTaskList![index].loc![0]
                                          .address !=
                                      null
                              ? cubit.getAllTaskList![index].loc![0].address
                                  .toString()
                              : 'لا يوجد')
                          : (cubit.getUserTaskList != null &&
                                  cubit.getUserTaskList!.isNotEmpty &&
                                  cubit.getUserTaskList![index].loc != null &&
                                  cubit.getUserTaskList![index].loc!
                                      .isNotEmpty && // check list is not empty
                                  cubit.getUserTaskList![index].loc![0]
                                          .address !=
                                      null
                              ? cubit.getUserTaskList![index].loc![0].address
                                  .toString()
                              : 'لا يوجد'),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class TaskListForAdminToShowUserTasks extends StatelessWidget {
  final bool isGrid;

  const TaskListForAdminToShowUserTasks({super.key, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          isGrid
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2 / 3.3,
                  ),
                  itemCount: cubit.getUserTaskList!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          animatedNavigation(
                              screen: TaskDetailsScreen(
                            file: cubit.getUserTaskList![index].files!
                                        .isNotEmpty ||
                                    cubit.getUserTaskList![index].files != null
                                ? cubit.getUserTaskList![index].files
                                : [],
                            task_status: cubit
                                .getUserTaskList![index].task_status
                                .toString(),
                            locationId: (cubit.getUserTaskList![index].loc !=
                                    null
                                ? cubit.getUserTaskList![index].loc![index].id
                                    .toString()
                                : '10'),
                            id: cubit.getUserTaskList![index].id!.toInt(),
                            nameTask:
                                cubit.getUserTaskList![index].title.toString(),
                            nameEmployee:
                                '${TasksCubit.get(context).getUserTaskList![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getUserTaskList![index].assigned_to!.last_name.toString()}',
                            nameClient: cubit
                                .getUserTaskList![index].client_name
                                .toString(),
                            phoneClient: cubit
                                .getUserTaskList![index].client_phone
                                .toString(),
                            notes:
                                cubit.getUserTaskList![index].notes.toString(),
                            address: (cubit.getUserTaskList![index].loc != null
                                ? cubit
                                    .getUserTaskList![index].loc![index].address
                                    .toString()
                                : 'لا يوجد'),
                            link: (cubit.getUserTaskList![index].loc != null
                                ? cubit
                                    .getUserTaskList![index].loc![index].mapUrl!
                                    .toString()
                                : 'لا يوجد'),
                            deadline: cubit.getUserTaskList![index].due_date
                                .toString(),
                            description: cubit
                                .getUserTaskList![index].description
                                .toString(),
                          )));
                    },
                    child: TaskCardGrid(
                      detailsUser: true,
                      cancelDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .cancelled_date
                          .toString(),
                      completeDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .complete_date
                          .toString(),
                      createDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .created_on
                          .toString(),
                      progressDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .modified_on
                          .toString(),
                      avatar: TasksCubit.get(context)
                                  .getUserTaskList![index]
                                  .assigned_to!
                                  .avatar !=
                              null
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .assigned_to!
                              .avatar!
                              .location_data!
                              .full_url
                              .toString()
                          : 'null',
                      names:
                          '${TasksCubit.get(context).getUserTaskList![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getUserTaskList![index].assigned_to!.last_name.toString()}',
                      statusColor: AppColors.inbox,
                      statusText:
                          cubit.getUserTaskList![index].task_status.toString(),
                      taskName: cubit.getUserTaskList![index].title.toString(),
                      taskNotes: cubit.getUserTaskList![index].notes.toString(),
                      index: index,
                      location: (cubit.getUserTaskList![index].loc != null
                          ? cubit.getUserTaskList![index].loc![index].address
                              .toString()
                          : 'لا يوجد'),
                    ),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cubit.getUserTaskList!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      log(TasksCubit.get(context)
                          .getUserTaskList![index]
                          .complete_date
                          .toString());

                      Navigator.push(
                          context,
                          animatedNavigation(
                              screen: TaskDetailsScreen(
                            file: cubit.getUserTaskList![index].files!
                                        .isNotEmpty ||
                                    cubit.getUserTaskList![index].files != null
                                ? cubit.getUserTaskList![index].files
                                : [],
                            task_status: cubit
                                .getUserTaskList![index].task_status
                                .toString(),
                            locationId:
                                (cubit.getUserTaskList![index].loc != null
                                    ? cubit.getUserTaskList![index].loc![0].id
                                        .toString()
                                    : '10'),
                            id: cubit.getUserTaskList![index].id!.toInt(),
                            nameTask:
                                cubit.getUserTaskList![index].title.toString(),
                            nameEmployee:
                                '${TasksCubit.get(context).getUserTaskList![index].assigned_to!['first_name'].toString()} ${TasksCubit.get(context).getUserTaskList![index].assigned_to!['last_name'].toString()}',
                            nameClient: cubit
                                .getUserTaskList![index].client_name
                                .toString(),
                            phoneClient: cubit
                                .getUserTaskList![index].client_phone
                                .toString(),
                            notes:
                                cubit.getUserTaskList![index].notes.toString(),
                            address: (cubit.getUserTaskList![index].loc != null
                                ? cubit.getUserTaskList![index].loc![0].address
                                    .toString()
                                : 'لا يوجد'),
                            link: (cubit.getUserTaskList![index].loc != null
                                ? cubit.getUserTaskList![index].loc![0].mapUrl
                                    .toString()
                                : 'لا يوجد'),
                            deadline: cubit.getUserTaskList![index].due_date
                                .toString(),
                            description: cubit
                                .getUserTaskList![index].description
                                .toString(),
                          )));
                    },
                    child: TaskCardList(
                      detailsUser: true,
                      cancelDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .cancelled_date
                          .toString(),
                      completeDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .complete_date
                          .toString(),
                      createDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .created_on
                          .toString(),
                      progressDate: TasksCubit.get(context)
                          .getUserTaskList![index]
                          .modified_on
                          .toString(),
                      avatar: TasksCubit.get(context)
                                  .getUserTaskList![index]
                                  .assigned_to!['avatar'] !=
                              null
                          ? TasksCubit.get(context)
                              .getUserTaskList![index]
                              .assigned_to!
                              .avatar!
                              .location_data!
                              .full_url
                              .toString()
                          : 'null',
                      names:
                          '${TasksCubit.get(context).getUserTaskList![index].assigned_to!['first_name'].toString()} ${TasksCubit.get(context).getUserTaskList![index].assigned_to!['last_name'].toString()}',
                      statusColor: Colors.green,
                      statusText:
                          cubit.getUserTaskList![index].task_status.toString(),
                      taskName: cubit.getUserTaskList![index].title.toString(),
                      taskNotes: cubit.getUserTaskList![index].notes.toString(),
                      index: index,
                      textDate: 'مهلة المهمة',
                      location: (cubit.getUserTaskList![index].loc != null &&
                              cubit.getUserTaskList![index].loc!.isNotEmpty)
                          ? cubit.getUserTaskList![index].loc![0].address
                              .toString()
                          : 'لا يوجد',
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class TaskListFilter extends StatelessWidget {
  final bool isGrid;

  const TaskListFilter({super.key, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    var cubit = TasksCubit.get(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          isGrid
              ? GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    childAspectRatio: 2 / 3.3,
                  ),
                  itemCount: role == '3'
                      ? cubit.getTaskListForOneUserSearch!.length
                      : cubit.getAllTaskListFilter!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          animatedNavigation(
                              screen: role == '1'
                                  ? TaskDetailsScreen(
                                      task_status: cubit
                                          .getAllTaskListFilter![index]
                                          .task_status
                                          .toString(),
                                      locationId: role == "3"
                                          ? (cubit.getUserTaskList![index]
                                                      .loc !=
                                                  null
                                              ? cubit.getUserTaskList![index]
                                                  .loc![index].id
                                                  .toString()
                                              : '10')
                                          : '',
                                      file: cubit.getAllTaskListFilter![index]
                                                  .files!.isNotEmpty ||
                                              cubit.getAllTaskListFilter![index]
                                                      .files !=
                                                  null
                                          ? cubit.getAllTaskListFilter![index]
                                              .files
                                          : [],
                                      id: cubit.getAllTaskListFilter![index].id!
                                          .toInt(),
                                      nameTask: cubit
                                          .getAllTaskListFilter![index].title
                                          .toString(),
                                      nameEmployee:
                                          '${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.last_name.toString()}',
                                      nameClient: cubit
                                          .getAllTaskListFilter![index]
                                          .client_name
                                          .toString(),
                                      phoneClient: cubit
                                          .getAllTaskListFilter![index]
                                          .client_phone
                                          .toString(),
                                      notes: cubit
                                          .getAllTaskListFilter![index].notes
                                          .toString(),
                                      address: cubit
                                                  .getAllTaskListFilter![index]
                                                  .loc !=
                                              null
                                          ? cubit.getAllTaskListFilter![index]
                                              .loc![index].address
                                              .toString()
                                          : 'لا يوجد',
                                      link: cubit.getAllTaskListFilter![index]
                                                  .loc !=
                                              null
                                          ? cubit.getAllTaskListFilter![index]
                                              .loc![index].mapUrl
                                              .toString()
                                          : 'لا يوجد',
                                      deadline: cubit
                                          .getAllTaskListFilter![index].due_date
                                          .toString(),
                                      description: cubit
                                          .getAllTaskListFilter![index]
                                          .description
                                          .toString(),
                                    )
                                  : TaskDetailsScreen(
                                      file: cubit
                                                  .getTaskListForOneUserSearch![
                                                      index]
                                                  .files!
                                                  .isNotEmpty ||
                                              cubit
                                                      .getTaskListForOneUserSearch![
                                                          index]
                                                      .files !=
                                                  null
                                          ? cubit
                                              .getTaskListForOneUserSearch![
                                                  index]
                                              .files
                                          : [],
                                      task_status: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .task_status
                                          .toString(),
                                      locationId: role == "3"
                                          ? (cubit.getUserTaskList![index]
                                                      .loc !=
                                                  null
                                              ? cubit.getUserTaskList![index]
                                                  .loc![index].id
                                                  .toString()
                                              : '10')
                                          : '',
                                      id: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .id!
                                          .toInt(),
                                      nameTask: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .title
                                          .toString(),
                                      nameEmployee:
                                          '${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.last_name.toString()}',
                                      nameClient: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .client_name
                                          .toString(),
                                      phoneClient: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .client_phone
                                          .toString(),
                                      notes: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .notes
                                          .toString(),
                                      address: cubit
                                                  .getTaskListForOneUserSearch![
                                                      index]
                                                  .loc !=
                                              null
                                          ? cubit
                                              .getTaskListForOneUserSearch![
                                                  index]
                                              .loc![index]
                                              .address
                                              .toString()
                                          : 'لا يوجد',
                                      link: cubit
                                                  .getTaskListForOneUserSearch![
                                                      index]
                                                  .loc !=
                                              null
                                          ? cubit
                                              .getTaskListForOneUserSearch![
                                                  index]
                                              .loc![index]
                                              .mapUrl
                                              .toString()
                                          : 'لا يوجد',
                                      deadline: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .due_date
                                          .toString(),
                                      description: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .description
                                          .toString(),
                                    )));
                    },
                    child: role == '1'
                        ? TaskCardGrid(
                            avatar: TasksCubit.get(context)
                                        .getAllTaskListFilter![index]
                                        .assigned_to!
                                        .avatar !=
                                    null
                                ? TasksCubit.get(context)
                                    .getAllTaskListFilter![index]
                                    .assigned_to!
                                    .avatar!
                                    .location_data!
                                    .full_url
                                    .toString()
                                : 'null',
                            names:
                                '${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.last_name.toString()}',
                            statusColor: AppColors.inbox,
                            statusText: cubit
                                .getAllTaskListFilter![index].task_status
                                .toString(),
                            taskName: cubit.getAllTaskListFilter![index].title
                                .toString(),
                            taskNotes: cubit.getAllTaskListFilter![index].notes
                                .toString(),
                            index: index,
                            location:
                                cubit.getAllTaskListFilter![index].loc != null
                                    ? cubit.getAllTaskListFilter![index]
                                        .loc![index].address
                                        .toString()
                                    : 'لا يوجد',
                          )
                        : TaskCardGrid(
                            search: true,
                            avatar: TasksCubit.get(context)
                                        .getTaskListForOneUserSearch![index]
                                        .assigned_to!
                                        .avatar !=
                                    null
                                ? TasksCubit.get(context)
                                    .getTaskListForOneUserSearch![index]
                                    .assigned_to!
                                    .avatar!
                                    .location_data!
                                    .full_url
                                    .toString()
                                : 'null',
                            names:
                                '${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.last_name.toString()}',
                            statusColor: AppColors.inbox,
                            statusText: cubit
                                .getTaskListForOneUserSearch![index].task_status
                                .toString(),
                            taskName: cubit
                                .getTaskListForOneUserSearch![index].title
                                .toString(),
                            taskNotes: cubit
                                .getTaskListForOneUserSearch![index].notes
                                .toString(),
                            index: index,
                            location:
                                cubit.getTaskListForOneUserSearch![index].loc !=
                                        null
                                    ? cubit.getTaskListForOneUserSearch![index]
                                        .loc![index].address
                                        .toString()
                                    : 'لا يوجد',
                          ),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: role == '3'
                      ? cubit.getTaskListForOneUserSearch!.length
                      : cubit.getAllTaskListFilter!.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          animatedNavigation(
                              screen: role == '1'
                                  ? TaskDetailsScreen(
                                      file: cubit.getAllTaskListFilter![index]
                                                  .files!.isNotEmpty ||
                                              cubit.getAllTaskListFilter![index]
                                                      .files !=
                                                  null
                                          ? cubit.getAllTaskListFilter![index]
                                              .files
                                          : [],
                                      task_status: cubit
                                          .getAllTaskListFilter![index]
                                          .task_status
                                          .toString(),
                                      locationId: role == "3"
                                          ? (cubit.getUserTaskList![index]
                                                      .loc !=
                                                  null
                                              ? cubit.getUserTaskList![index]
                                                  .loc![index].id
                                                  .toString()
                                              : '10')
                                          : '',
                                      id: cubit.getAllTaskListFilter![index].id!
                                          .toInt(),
                                      nameTask: cubit
                                          .getAllTaskListFilter![index].title
                                          .toString(),
                                      nameEmployee:
                                          '${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.last_name.toString()}',
                                      nameClient: cubit
                                          .getAllTaskListFilter![index]
                                          .client_name
                                          .toString(),
                                      phoneClient: cubit
                                          .getAllTaskListFilter![index]
                                          .client_phone
                                          .toString(),
                                      notes: cubit
                                          .getAllTaskListFilter![index].notes
                                          .toString(),
                                      address: cubit
                                                  .getAllTaskListFilter![index]
                                                  .loc !=
                                              null
                                          ? cubit.getAllTaskListFilter![index]
                                              .loc![index].address
                                              .toString()
                                          : 'لا يوجد',
                                      link: cubit.getAllTaskListFilter![index]
                                                  .loc !=
                                              null
                                          ? cubit.getAllTaskListFilter![index]
                                              .loc![index].mapUrl
                                              .toString()
                                          : 'لا يوجد',
                                      deadline: cubit
                                          .getAllTaskListFilter![index].due_date
                                          .toString(),
                                      description: cubit
                                          .getAllTaskListFilter![index]
                                          .description
                                          .toString(),
                                    )
                                  : TaskDetailsScreen(
                                      file: cubit
                                                  .getTaskListForOneUserSearch![
                                                      index]
                                                  .files!
                                                  .isNotEmpty ||
                                              cubit
                                                      .getTaskListForOneUserSearch![
                                                          index]
                                                      .files !=
                                                  null
                                          ? cubit
                                              .getTaskListForOneUserSearch![
                                                  index]
                                              .files
                                          : [],
                                      task_status: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .task_status
                                          .toString(),
                                      locationId: role == "3"
                                          ? (cubit
                                                      .getTaskListForOneUserSearch![
                                                          index]
                                                      .loc !=
                                                  null
                                              ? cubit
                                                  .getTaskListForOneUserSearch![
                                                      index]
                                                  .loc![index]
                                                  .id
                                                  .toString()
                                              : '10')
                                          : '',
                                      id: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .id!
                                          .toInt(),
                                      nameTask: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .title
                                          .toString(),
                                      nameEmployee:
                                          '${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.last_name.toString()}',
                                      nameClient: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .client_name
                                          .toString(),
                                      phoneClient: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .client_phone
                                          .toString(),
                                      notes: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .notes
                                          .toString(),
                                      address: cubit
                                                  .getTaskListForOneUserSearch![
                                                      index]
                                                  .loc !=
                                              null
                                          ? cubit
                                              .getTaskListForOneUserSearch![
                                                  index]
                                              .loc![index]
                                              .address
                                              .toString()
                                          : 'لا يوجد',
                                      link: cubit
                                                  .getTaskListForOneUserSearch![
                                                      index]
                                                  .loc !=
                                              null
                                          ? cubit
                                              .getTaskListForOneUserSearch![
                                                  index]
                                              .loc![index]
                                              .mapUrl
                                              .toString()
                                          : 'لا يوجد',
                                      deadline: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .due_date
                                          .toString(),
                                      description: cubit
                                          .getTaskListForOneUserSearch![index]
                                          .description
                                          .toString(),
                                    )));
                    },
                    child: role == '1' &&
                            TasksCubit.get(context).getAllTaskListFilter !=
                                null &&
                            index <
                                TasksCubit.get(context)
                                    .getAllTaskListFilter!
                                    .length
                        ? TaskCardList(
                            avatar: TasksCubit.get(context).getAllTaskListFilter![index].assigned_to?.avatar?.location_data?.full_url?.toString() ??
                                'null',

                            // or any fallback widget

                            names:
                                '${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getAllTaskListFilter![index].assigned_to!.last_name.toString()}',
                            statusColor: Colors.green,
                            statusText: cubit.getAllTaskListFilter![index].task_status
                                .toString(),
                            taskName: cubit.getAllTaskListFilter![index].title
                                .toString(),
                            taskNotes: cubit.getAllTaskListFilter![index].notes
                                .toString(),
                            index: index,
                            textDate: 'مهلة المهمة',
                            location: cubit.getAllTaskListFilter![index].loc != null
                                ? cubit.getAllTaskListFilter![index].loc![index].address
                                    .toString()
                                : 'لا يوجد')
                        : TaskCardList(
                            search: true,
                            avatar: TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.avatar != null
                                ? TasksCubit.get(context)
                                    .getTaskListForOneUserSearch![index]
                                    .assigned_to!
                                    .avatar!
                                    .location_data!
                                    .full_url
                                    .toString()
                                : 'null',
                            names: '${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.first_name.toString()} ${TasksCubit.get(context).getTaskListForOneUserSearch![index].assigned_to!.last_name.toString()}',
                            statusColor: Colors.green,
                            statusText: cubit.getTaskListForOneUserSearch![index].task_status.toString(),
                            taskName: cubit.getTaskListForOneUserSearch![index].title.toString(),
                            taskNotes: cubit.getTaskListForOneUserSearch![index].notes.toString(),
                            index: index,
                            textDate: 'مهلة المهمة',
                            location: cubit.getTaskListForOneUserSearch![index].loc != null ? cubit.getTaskListForOneUserSearch![index].loc![index].address.toString() : 'لا يوجد'),
                  ),
                ),
        ],
      ),
    );
  }
}
