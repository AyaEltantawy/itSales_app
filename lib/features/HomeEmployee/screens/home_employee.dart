import 'dart:developer';
import 'package:badges/badges.dart' as badges;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/states.dart';
import 'package:itsale/features/addEmployee/components/report_chart.dart';
import 'package:itsale/features/auth/data/states.dart';
import 'package:svg_flutter/svg.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../../../core/app/app.dart';
import '../../../core/cache_helper/cache_helper.dart';
import '../../../core/components/default_app_bar.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/styles.dart';
import '../../../core/utils/token.dart';
import '../../../core/utils/transition.dart';
import '../../../generated/l10n.dart';
import '../../Tasks_Screens/data/models/get_task_model.dart';
import '../../Tasks_Screens/data/models/notifications_model.dart';
import '../../Tasks_Screens/screens/task_details.dart';
import '../../auth/data/cubit.dart';
import '../../home/components/widgets_for_tasks_screen.dart';
import '../components/company_details.dart';

class HomeEmployeeScreen extends StatefulWidget {
  const HomeEmployeeScreen({super.key, required this.back});

  final bool back;

  @override
  State<HomeEmployeeScreen> createState() => _HomeEmployeeScreenState();
}

class _HomeEmployeeScreenState extends State<HomeEmployeeScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    TasksCubit.get(context).clearNotificationBadge();
    // also fetch actual notifications list
    TasksCubit.get(context).getNotificationForOneUserFun();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final id = CacheHelper.getData(key: 'company_id');
      final role = CacheHelper.getData(
          key: 'role'); // make sure you get it from cache if needed

      debugPrint('Fetched companyId: $id (type: ${id.runtimeType})');
      debugPrint('Fetched role: $role (type: ${role.runtimeType})');

      if ((id == null || id == '' || id == 'null') && role.toString() == '1') {
        debugPrint('❌ companyId is null. Navigating to company page...');
        navigateTo(context, AppRoutes.companyPage);
        return;
      }

      companyId = id;

      if (role.toString() == '1') {
        await TasksCubit.get(context).getAllTasksFun();
      } else {
        await TasksCubit.get(context).getUserTaskFun(userId: userId.toString());
      }

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final notificationsList =
        TasksCubit.get(context).getNotificationsForOneUserList ?? [];
    Future<void> _refreshData() async {
      if (role == '1') {
        await TasksCubit.get(context).getAllTasksFun();
      } else {
        await TasksCubit.get(context).getUserTaskFun(userId: userId.toString());
      }
    }

    if (isLoading)
      return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding.w),
              child: BlocConsumer<AppCubit, AppStates>(
                listener: (context, state) {
                  if (state is ThemeState) {
                    globalDark = state.isDarkMode;
                    setState(() {});
                  } else {
                    globalDark = context.read<AppCubit>().isDarkMode;
                    setState(() {});
                  }
                },
                builder: (context, state) {
                  final loginInfo = AppCubit.get(context).getInfoLogin;

                  if (state is NoInternetState || loginInfo == null) {
                    return const NoInternet();
                  }

                  if (state is GetLoadingInfoState || loginInfo == null) {
                    return AppLottie.loader;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      CustomAppBar(
                        back: widget.back,
                        title: '',
                        actions: [
                          Row(
                            children: [
                              Text(AppLocalizations.of(context)!
                                  .translate("main_page")),
                              BlocBuilder<TasksCubit, TasksStates>(
                                buildWhen: (previous, current) =>
                                    current is NewNotificationState ||
                                    current is ClearNotificationState,
                                builder: (context, state) {
                                  final count = TasksCubit.get(context)
                                      .newNotificationCount;

                                  return InkWell(
                                    onTap: () {
                                      navigateTo(
                                              context, AppRoutes.notifications)
                                          .then((_) {
                                        // Clear badge when page is opened
                                        TasksCubit.get(context)
                                            .clearNotificationBadge();
                                      });
                                    },
                                    child: badges.Badge(
                                      position: badges.BadgePosition.topEnd(
                                          top: -25, end: 10),
                                      showBadge: count > 0,
                                      badgeContent: Text(
                                        "$count",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      child:
                                          Image.asset("assets/images/bell.png"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GreetingSection(),
                          SizedBox(height: 16.h),
                          CompanyDetails(
                            number: loginInfo.companies?.whatsapp ?? "",
                            link: loginInfo.companies?.website ?? '',
                            companyName: loginInfo.companies?.name ?? '',
                            email: loginInfo.companies?.email ?? '',
                          ),
                          SizedBox(height: 20.h),
                          BlocConsumer<TasksCubit, TasksStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              final allTasks =
                                  TasksCubit.get(context).getAllTaskList ?? [];
                              final userTasks =
                                  TasksCubit.get(context).getUserTaskList ?? [];

                              final completedTasks = allTasks
                                  .where((e) => e.task_status == 'completed')
                                  .toList();
                              final uncompletedTasks = allTasks
                                  .where((e) => e.task_status != 'completed')
                                  .toList();

                              final completedTasksForUser = userTasks
                                  .where((e) => e.task_status == 'completed')
                                  .toList();
                              final uncompletedTasksForUser = userTasks
                                  .where((e) => e.task_status != 'completed')
                                  .toList();

                              if (state is GetLoadingAllTaskState ||
                                  state is GetLoadingUserTaskState) {
                                return AppLottie.loader;
                              }

                              final hasTasks =
                                  allTasks.isNotEmpty || userTasks.isNotEmpty;

                              return hasTasks
                                  ? TaskSummarySection(
                                      completedTasks: completedTasks,
                                      completedTasksForUser:
                                          completedTasksForUser,
                                      uncompletedTasks: uncompletedTasks,
                                      uncompletedTasksForUser:
                                          uncompletedTasksForUser,
                                    )
                                  : const Center(child: Text("لا يوجد مهمة"));
                            },
                          ),
                          SizedBox(height: 20.h),
                          const ChartsSection(),
                          SizedBox(height: 16.h),
                          BlocConsumer<TasksCubit, TasksStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              if (state is GetErrorAllTaskState) {
                                return const Center(
                                    child: Text("مع الاسف حدث خطأ"));
                              }

                              final data = role == '1'
                                  ? TasksCubit.get(context).getLastTaskList
                                  : TasksCubit.get(context)
                                      .getLastTaskListForOneUser;

                              return CompletedTasksSection(data: data);
                            },
                          ),
                          SizedBox(height: 32.h),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate("hello"),
            style: AppFonts.style20Bold,
          ),
          Text(
            '${AppCubit.get(context).getInfoLogin!.first_name.toString()} ${AppCubit.get(context).getInfoLogin!.last_name.toString()}',
            style: AppFonts.style20Light,
          ),
        ],
      ),
    );
  }
}

class TaskSummarySection extends StatefulWidget {
  TaskSummarySection(
      {super.key,
      required this.completedTasks,
      required this.uncompletedTasks,
      required this.completedTasksForUser,
      required this.uncompletedTasksForUser});

  List<DataAllTasks>? completedTasks;
  List<DataAllTasks>? uncompletedTasks;
  List<DataUserTask>? completedTasksForUser;
  List<DataUserTask>? uncompletedTasksForUser;

  @override
  State<TaskSummarySection> createState() => _TaskSummarySectionState();
}

class _TaskSummarySectionState extends State<TaskSummarySection> {
  @override
  void didChangeDependencies() {
    widget.completedTasks = TasksCubit.get(context)
        .getAllTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    widget.uncompletedTasks = TasksCubit.get(context)
        .getAllTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();
    widget.completedTasksForUser = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    widget.uncompletedTasksForUser = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TaskSummaryCard(
          title: AppLocalizations.of(context)!.translate("all"),
          count: role == '1'
              ? TasksCubit.get(context).getAllTaskList!.length.toString()
              : TasksCubit.get(context).getUserTaskList!.length.toString(),
          color: AppColors.primary,
        ),
        TaskSummaryCard(
          title: AppLocalizations.of(context)!.translate("completed"),
          count: role == '1'
              ? widget.completedTasks!.length.toString()
              : widget.completedTasksForUser!.length.toString(),
          color: Colors.green,
        ),
        TaskSummaryCard(
          title: AppLocalizations.of(context)!.translate("unCompleted"),
          count: role == '1'
              ? widget.uncompletedTasks!.length.toString()
              : widget.uncompletedTasksForUser!.length.toString(),
          color: Colors.red,
        ),
      ],
    );
  }
}

class TaskSummaryCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const TaskSummaryCard(
      {super.key,
      required this.title,
      required this.count,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        // color: color.withOpacity(0.1),
        color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
        border: Border.all(
            color:
                globalDark ? AppColors.borderColorDark : AppColors.borderColor,
            width: 0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 34.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppFonts.style12light,
          ),
        ],
      ),
    );
  }
}

class ChartsSection extends StatelessWidget {
  const ChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
        border: Border.all(
            color:
                globalDark ? AppColors.borderColorDark : AppColors.borderColor,
            width: 0.5),
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate("weekly_statistics"),
            style: AppFonts.style16semiBold,
            textAlign: TextAlign.right,
          ),
          // TasksCubit.get(context).getAllTaskListFilter!.isNotEmpty
          ReportChart()
          //   : Column(
          // children: [
          //   SizedBox(height: 20.h),
          //   Center(
          //       child: Text(S.of(context).no_data,
          //           style: AppFonts.style12light)),
          //   SizedBox(height: 20.h),
          // ],

          //),
        ],
      ),
    );
  }
}

class SimpleBarChart extends StatelessWidget {
  const SimpleBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 230,
      child: BarChart(
        BarChartData(
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(toY: 5, color: Colors.blue),
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(toY: 7, color: Colors.red),
            ]),
          ],
          borderData: FlBorderData(show: false),
          titlesData: const FlTitlesData(show: true),
        ),
      ),
    );
  }
}

class CompletedTasksSection extends StatelessWidget {
  const CompletedTasksSection({super.key, required this.data});

  final List<DataAllTasks>? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
        border: Border.all(
            color:
                globalDark ? AppColors.borderColorDark : AppColors.borderColor,
            width: 0.5),
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.translate("completed_tasks"),
            textAlign: TextAlign.right,
            style: AppFonts.style16semiBold,
          ),
          data!.isNotEmpty
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              animatedNavigation(
                                  screen: TaskDetailsScreen(
                                file: data![index].files!.isNotEmpty ||
                                        data![index].files != null
                                    ? data![index].files
                                    : [],
                                task_status:
                                    data![index].task_status.toString(),
                                id: data![index].id!.toInt(),
                                locationId: data![index].location != null
                                    ? data![index].location!.id.toString()
                                    : '10',
                                nameTask: data![index].title.toString(),
                                nameEmployee:
                                    '${data![index].assigned_to!.first_name.toString()} ${data![index].assigned_to!.last_name.toString()}',
                                nameClient: data![index].client_name.toString(),
                                phoneClient:
                                    data![index].client_phone.toString(),
                                notes: data![index].notes.toString(),
                                address: data![index].location != null
                                    ? data![index].location!.address.toString()
                                    : 'لا يوجد',
                                link: data![index].location != null
                                    ? data![index].location!.map_url.toString()
                                    : 'لا يوجد',
                                deadline: data![index].due_date.toString(),
                                description:
                                    data![index].description.toString(),
                              )));
                        },
                        child: TaskListItem(
                            index: index + 1,
                            taskName: data![index].title.toString(),
                            location: data![index].location != null
                                ? data![index].location!.address.toString()
                                : 'لا يوجد',
                            time: data![index].complete_date!.toString()),
                      ),
                  separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Divider(
                          color: globalDark
                              ? AppColors.borderColorDark
                              : AppColors.borderColor,
                        ),
                      ),
                  itemCount: data!.length)
              : Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                        child: Text("لا يوجد بيانات",
                            style: AppFonts.style12light)),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  final int index;
  final String taskName;
  final String location;
  final String time;

  const TaskListItem(
      {super.key,
      required this.index,
      required this.taskName,
      required this.location,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
      child: Row(
        children: [
          Text(
            index.toString(),
            style: AppFonts.style16Light.copyWith(color: AppColors.primary),
          ),
          SizedBox(width: 20.w),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskName,
                  style: TextStyles.font18Weight500Black,
                ),
                Text(
                  location,
                  style: TextStyles.font16Weight300EmeraldWithoutLine,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              time,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: globalDark ? AppColors.textWhite : AppColors.textBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
