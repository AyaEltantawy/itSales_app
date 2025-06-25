import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/constants/app_defaults.dart';
import 'package:itsale/core/constants/app_fonts.dart';
import 'package:itsale/core/localization/app_localizations.dart';
import '../../../core/constants/app_animation.dart';
import '../../../core/constants/app_icons.dart';
import '../../../core/constants/navigation.dart';
import '../../../core/localization/localization_service.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/token.dart' show role, userId;
import '../../../core/utils/transition.dart';
import '../../../generated/l10n.dart';
import '../../HomeEmployee/components/card_contacts_widget.dart';
import '../../HomeEmployee/components/prfile_header.dart';
import '../../HomeEmployee/screens/home_employee.dart';
import '../../Tasks_Screens/data/cubit/cubit.dart';
import '../../Tasks_Screens/data/cubit/states.dart';
import '../../Tasks_Screens/data/models/get_task_model.dart';
import '../../Tasks_Screens/screens/task_details.dart';
import '../../Tasks_Screens/screens/tasks.dart';
import '../../addEmployee/components/no_data_screen.dart';
import '../../auth/data/cubit.dart';
import '../../auth/data/states.dart';
import '../../home/components/widgets_for_tasks_screen.dart';
import '../../home/data/cubit.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final String name;
  final String role;
  final dynamic avatar;
  final String email;
  final String phone1;
  final String phone2;
  final String address;
  final String passwordToken;
  final String empEmail;
  final String whatsapp;
  final String id;
  bool? task;

  EmployeeDetailsScreen({
    super.key,
    required this.name,
    required this.id,
    required this.address,
    required this.email,
    required this.whatsapp,
    required this.avatar,
    required this.empEmail,
    required this.phone2,
    required this.phone1,
    required this.passwordToken,
    required this.role,
  });

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  int selectedTab = 0;

  @override
  void initState() {
    TasksCubit.get(context).getUserTaskFun(userId: widget.id);
    final loginInfo = AppCubit.get(context).getInfoLogin;
    super.initState();
  }

  bool showSearch = false;
  String searchText = '';

  // void onSearchChanged(String value) {
  //   searchText = value;
  //   if (widget.task == true) {
  //     if (role == '1') {
  //       TasksCubit.get(context).getAllTasksFunWithFilter(text: value);
  //     } else {
  //       TasksCubit.get(context).getAllTasksFunWithFilter(
  //           textEmp: value, employee: userId.toString());
  //     }
  //   } else {
  //     EmployeeCubit.get(context).getAdmins(search: value);
  //   }
  // }
  //
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return BlocBuilder<AppCubit, AppStates>(
          builder: (context, state) {
            final loginInfo = AppCubit.get(context).getInfoLogin;
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: CustomAppBar(
                            back: true,
                            title: AppLocalizations.of(context)!
                                .translate("employee_details")),
                      ),
                      ProfileHeader(
                        id: int.parse(widget.id),
                        name: widget.name,
                        role: widget.role,
                        avatar: widget.avatar,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppDefaults.padding.w / 1.6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: globalDark
                                ? AppColors.cardColorDark
                                : AppColors.gray,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: TabSelector(
                            selectedTab: selectedTab,
                            onTabSelected: (int index) {
                              setState(() {
                                selectedTab = index;
                              });
                            },
                          ),
                        ),
                      ),
                      _buildContentForSelectedTab(
                        id: widget.id,
                        phone1: widget.phone1 != '' ? widget.phone1 : AppLocalizations.of(context)!.translate("not_available"),
                        phone2: widget.phone2 != '' ? widget.phone2 : AppLocalizations.of(context)!.translate("not_available"),
                        whatsapp:
                            widget.whatsapp != '' ? widget.whatsapp : AppLocalizations.of(context)!.translate("not_available"),
                        empEmail:
                            widget.empEmail != '' ? widget.empEmail : AppLocalizations.of(context)!.translate("not_available"),
                        password: widget.passwordToken != ''
                            ? widget.passwordToken
                            : AppLocalizations.of(context)!.translate("not_available"),
                        address:
                            widget.address != '' ? widget.address :AppLocalizations.of(context)!.translate("not_available"),
                        name: widget.name != '' ? widget.name : AppLocalizations.of(context)!.translate("not_available"),
                        emailLogin:
                            widget.email != '' ? widget.email : AppLocalizations.of(context)!.translate("not_available"),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  Widget _buildContentForSelectedTab({
    required String phone1,
    required String phone2,
    required String empEmail,
    required String whatsapp,
    required String emailLogin,
    required String address,
    required String password,
    required String name,
    required String id,
  }) {
    if (selectedTab == 0) {
      return OverviewSection(
        phone1: phone1,
        id: id,
        phone2: phone2,
        whatsapp: whatsapp,
        empEmail: empEmail,
      );
    } else if (selectedTab == 1) {
      return TaskListInProfile(
        task: true,
      );
    } else {
      return EmployeeInfo(
        name: name,
        empEmail: empEmail,
        phone2: phone2,
        phone1: phone1,
        address: address,
        emailLogin: emailLogin,
        password: password,
      );
    }
  }
}

class TabSelector extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabSelected;

  TabSelector(
      {super.key, required this.selectedTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    // bool showSearch = false;
    // String searchText = '';
    //
    // void onSearchChanged(String value) {
    //   searchText = value;
    //   if (task == true) {
    //     if (role == '1') {
    //       TasksCubit.get(context).getAllTasksFunWithFilter(text: value);
    //     } else {
    //       TasksCubit.get(context).getAllTasksFunWithFilter(
    //           textEmp: value, employee: userId.toString());
    //     }
    //   } else {
    //     EmployeeCubit.get(context).getAdmins(search: value);
    //   }
    // }
    return Row(
      children: [
        _buildTab(AppLocalizations.of(context)!.translate("overview"),
            0), // Overview tab
        _buildTab(
            AppLocalizations.of(context)!.translate("tasks"), 1), // Tasks tab
        _buildTab(AppLocalizations.of(context)!.translate("information"),
            2), // Information tab
      ],
    );
  }

  // Helper method to build each tab
  Widget _buildTab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        // Call the parent widget's onTabSelected method
        child: Container(
          decoration: BoxDecoration(
            color: selectedTab == index
                ? globalDark
                    ? AppColors.primary
                    : Colors.black
                : globalDark
                    ? AppColors.cardColorDark
                    : AppColors.gray, // Active tab is black, inactive is gray
            borderRadius:
                BorderRadius.circular(8.r), // Rounded corners for tabs
          ),
          padding: EdgeInsets.all(16.h), // Adds padding inside the tab
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedTab == index
                    ? Colors.white
                    : globalDark
                        ? AppColors.textWhite
                        : AppColors.textBlack,
                fontSize: 14.sp, // Font size for tab text
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskListInProfile extends StatefulWidget {
  TaskListInProfile({super.key, this.task});

  final bool? task;
  bool showSearch = false;
  String searchText = '';

  @override
  State<TaskListInProfile> createState() => _TaskListInProfileState();
}

class _TaskListInProfileState extends State<TaskListInProfile> {
  bool isGrid = false;

  void onSearchChanged(String value) {
    widget.searchText = value;

    if (widget.task == true) {
      if (role == '1') {
        TasksCubit.get(context).getAllTasksFunWithFilter(text: value);
      } else {
        TasksCubit.get(context).getAllTasksFunWithFilter(
          textEmp: value,
          employee: userId.toString(),
        );
      }
    } else {
      EmployeeCubit.get(context).getAdmins(search: value);
    }
  }

  void toggleViewMode() {
    setState(() {
      isGrid = !isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(
              right: AppDefaults.padding.w,
              top: AppDefaults.padding.h / 2,
            ),
            child: BuildSearchFilter(
              onTap: () {
                setState(() {
                  widget.showSearch = !widget.showSearch;
                  if (!widget.showSearch) {
                    widget.searchText = '';
                    if (role == '3') {
                      TasksCubit.get(context)
                          .getUserTaskFun(userId: userId.toString());
                    } else {
                      TasksCubit.get(context).getAllTasksFun();
                    }
                  }
                });
              },
              isGrid: isGrid,
              emp: false,
              task: true,
              admin: false,
              toggleViewMode: toggleViewMode,
            ),
          ),
          if (widget.showSearch) ...[
            SizedBox(height: 30.h),
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color:
                    globalDark ? AppColors.cardColorDark : AppColors.cardColor,
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
                onChanged: onSearchChanged,
                onFieldSubmitted: onSearchChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(AppIcons.searchIcon),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 20, minHeight: 20),
                  labelText:AppLocalizations.of(context)!.translate("search_here"),
                  labelStyle: AppFonts.style14normal,
                ),
              ),
            )
          ],
          Padding(
            padding: EdgeInsets.all(AppDefaults.padding.w),
            child: BlocConsumer<TasksCubit, TasksStates>(
              listener: (context, state) {},
              builder: (context, state) {
                final cubit = TasksCubit.get(context);

                if (state is NoInternetState) {
                  return const NoInternet();
                }

                if (state is GetLoadingAllTaskFilterState ||
                    state is GetLoadingAllTaskState ||
                    state is GetLoadingUserTaskState) {
                  return Column(
                    children: [
                      SizedBox(height: 10.h),
                      const LinearProgressIndicator(),
                    ],
                  );
                }
                if (state is GetSuccessSearchTaskFilterState ||
                    state is GetSuccessAllTaskFilterState) {
                  return cubit.getAllTaskListFilter?.isNotEmpty ?? false
                      ? TaskListFilter(isGrid: isGrid)
                      : nothing(
                          context,
                          route: AppRoutes.addTask,
                          button:AppLocalizations.of(context)!.translate("task")
                    ,
                          text: LocalizationService.tr("no_matching_results")
                    ,
                        );
                }

                // ✅ عرض قائمة المهام العادية
                final userTasks = cubit.getUserTaskList;
                if (userTasks != null && userTasks.isNotEmpty) {
                  return TaskListForAdminToShowUserTasks(isGrid: isGrid);
                }

                return nothing(
                  context,
                  route: AppRoutes.addTask,
                  button:"${ AppLocalizations.of(context)!.translate("task")}"
                  ,
                  text: AppLocalizations.of(context)!.translate("no_tasks_yet")
                  ,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewSection extends StatefulWidget {
  final String phone1;
  final String phone2;
  final String empEmail;
  final String whatsapp;
  final String id;

  const OverviewSection({
    super.key,
    required this.phone1,
    required this.phone2,
    required this.empEmail,
    required this.whatsapp,
    required this.id,
  });

  @override
  State<OverviewSection> createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection> {
  List<DataUserTask>? completedTasks;
  List<DataUserTask>? uncompletedTasks;

  @override
  void initState() {
    completedTasks = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    uncompletedTasks = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppDefaults.padding.w / 1.6),
          child: Text(
            AppLocalizations.of(context)!.translate("today_tasks"),
            style: AppFonts.style20Bold,
          ),
        ),
        SizedBox(height: 8.h),
        BlocBuilder<TasksCubit, TasksStates>(
          builder: (context, state) {
            if (state is GetLoadingUserTaskState) {
              return AppLottie.loader;
            }

            if (state is GetSuccessUserTaskState) {
              final tasks = TasksCubit.get(context).getUserTaskList ?? [];

              final completedTasks = tasks
                  .where((task) => task.task_status == 'completed')
                  .toList();

              final uncompletedTasks = tasks
                  .where((task) => task.task_status != 'completed')
                  .toList();

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDefaults.padding.w / 1.6,
                ),
                child: TaskSummarySectionForEmployee(
                  completedTasks: completedTasks,
                  uncompletedTasks: uncompletedTasks,
                ),
              );
            }

            // في حال وجود خطأ أو حالة فارغة
            return const Center(child: Text("لا توجد مهام"));
          },
        ),

        SizedBox(height: 20.h),
        //  Container(
        //    padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 1.6),
        //    margin: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 1.6),
        //    height: 60.h,
        //    width: double.infinity,
        //    decoration: BoxDecoration(
        //      color: AppColors.coloredBackground,
        //      borderRadius: BorderRadius.circular(8.r),
        //    ),
        //    child: Row(
        //      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //      children: [
        //        Text(S.of(context)!.اخر_ظهور_للموظف),style: AppFonts.style16Normal,),
        //
        //        Text('20 / 10 / 2024 12:40 pm',style: AppFonts.style16Normal,),
        //      ],
        //    ),
        //  ),
        // SizedBox(height: 10.h,),
        ContactOptionsCard(
          phone1: widget.phone1,
          phone2: widget.phone2,
          empEmail: widget.empEmail,
          whatsapp: widget.whatsapp,
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 1.6),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              const ChartsSection(),
              SizedBox(height: 16.h),
              CompletedTasksSectionForOneUser(id: widget.id),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ],
    );
  }
}

class CompletedTasksSectionForOneUser extends StatefulWidget {
  const CompletedTasksSectionForOneUser({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<CompletedTasksSectionForOneUser> createState() =>
      _CompletedTasksSectionForOneUserState();
}

class _CompletedTasksSectionForOneUserState
    extends State<CompletedTasksSectionForOneUser> {
  @override
  void initState() {
    super.initState();
    // فقط نقوم بطلب المهام المكتملة لهذا المستخدم
    TasksCubit.get(context).getUserTaskFun(
      userId: widget.id,
      status: 'completed',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
        border: Border.all(
          color: globalDark ? AppColors.borderColorDark : AppColors.borderColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child: BlocBuilder<TasksCubit, TasksStates>(
        builder: (context, state) {
          final data = TasksCubit.get(context).getUserTaskListWithStatus;

          if (state is GetLoadingUserTaskStateForEmpScreens) {
            return AppLottie.loader;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.translate("completed_tasks")
                ,
                textAlign: TextAlign.right,
                style: AppFonts.style16semiBold,
              ),
              const SizedBox(height: 10),
              data != null && data.isNotEmpty
                  ? ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      separatorBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Divider(
                          color: globalDark
                              ? AppColors.borderColorDark
                              : AppColors.borderColor,
                        ),
                      ),
                      itemBuilder: (context, index) {
                        final task = data[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              animatedNavigation(
                                screen: TaskDetailsScreen(
                                  file: task.files ?? [],
                                  task_status: task.task_status.toString(),
                                  id: task.id!.toInt(),
                                  locationId:
                                      task.location?.id?.toString() ?? '10',
                                  nameTask: task.title.toString(),
                                  nameEmployee:
                                      '${task.assigned_to?['first_name'] ?? ''} ${task.assigned_to?['last_name'] ?? ''}',
                                  nameClient: task.client_name.toString(),
                                  phoneClient: task.client_phone.toString(),
                                  notes: task.notes.toString(),
                                  address: task.location?.address ?? AppLocalizations.of(context)!.translate("not_available"),
                                  link: task.location?.map_url ?? AppLocalizations.of(context)!.translate("not_available"),
                                  deadline: task.due_date.toString(),
                                  description: task.description.toString(),
                                ),
                              ),
                            );
                          },
                          child: TaskListItem(
                            index: index + 1,
                            taskName: task.title.toString(),
                            location: task.location?.address ?? AppLocalizations.of(context)!.translate("not_available"),
                            time: task.complete_date?.toString() ?? '',
                          ),
                        );
                      },
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Center(
                        child: Text(
                       AppLocalizations.of(context)!.translate("no_data"),
                          style: AppFonts.style12light,
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

class TaskSummarySectionForEmployee extends StatefulWidget {
  TaskSummarySectionForEmployee({
    super.key,
    required this.completedTasks,
    required this.uncompletedTasks,
  });

  List<DataUserTask>? completedTasks;
  List<DataUserTask>? uncompletedTasks;

  @override
  State<TaskSummarySectionForEmployee> createState() =>
      _TaskSummarySectionForEmployeeState();
}

class _TaskSummarySectionForEmployeeState
    extends State<TaskSummarySectionForEmployee> {
  @override
  void initState() {
    widget.completedTasks = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    widget.uncompletedTasks = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    widget.completedTasks = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    widget.uncompletedTasks = TasksCubit.get(context)
        .getUserTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TaskSummaryCard(
          title: AppLocalizations.of(context)!.translate("all_tasks"),
          count: TasksCubit.get(context).getUserTaskList!.length.toString(),
          color: AppColors.primary,
        ),
        TaskSummaryCard(
          title: AppLocalizations.of(context)!.translate('completed'),
          count: widget.completedTasks!.length.toString(),
          color: Colors.green,
        ),
        TaskSummaryCard(
          title: AppLocalizations.of(context)!.translate('unCompleted'),
          count: widget.uncompletedTasks!.length.toString(),
          color: Colors.red,
        ),
      ],
    );
  }
}

// Employee Info Section (for the "Information" tab)
class EmployeeInfo extends StatelessWidget {
  final String name;
  final String phone1;
  final String phone2;
  final String emailLogin;
  final String empEmail;
  final String password;
  final String address;

  const EmployeeInfo(
      {super.key,
      required this.name,
      required this.phone1,
      required this.phone2,
      required this.emailLogin,
      required this.empEmail,
      required this.password,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.h),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate("login_data"),
                  style: AppFonts.style16semiBold,
                ),
                SizedBox(height: 8.h),
                _buildRow(label:AppLocalizations.of(context)!.translate('email'), value: emailLogin),
                SizedBox(height: 16.h),
                _buildRow(label: AppLocalizations.of(context)!.translate('password'), value: '**********'),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.h),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.translate("employee_data"),
                  style: AppFonts.style16semiBold,
                ),
                SizedBox(height: 8.h),
                _buildRow(label: AppLocalizations.of(context)!.translate("name")
                    , value: name),
                SizedBox(height: 16.h),
                _buildRow(label: AppLocalizations.of(context)!.translate("phone_number")
                    , value: phone1),
                SizedBox(height: 16.h),
                _buildRow(label: AppLocalizations.of(context)!.translate("alternative_phone_number")
                    , value: phone2),
                SizedBox(height: 16.h),
                _buildDescription(
                    label: AppLocalizations.of(context)!.translate("personal_email")
                    , value: empEmail),
                SizedBox(height: 16.h),
                _buildDescription(label: AppLocalizations.of(context)!.translate("residence_address")
                    , value: address),
              ],
            ),
          ),

          SizedBox(height: 16.h),
          BlocBuilder<AppCubit, AppStates>(
            builder: (context, state) {
              final loginInfo = AppCubit.get(context).getInfoLogin;
              return Container(
                padding: EdgeInsets.all(16.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.translate("company_info")
                      ,
                      style: AppFonts.style16semiBold,
                    ),
                    SizedBox(height: 8.h),
                    _buildRow(
                      label: AppLocalizations.of(context)!.translate("name"),
                      value: loginInfo?.companies?.name ?? '',
                    ),
                    SizedBox(height: 16.h),
                    _buildRow(
                      label:  AppLocalizations.of(context)!.translate("phone_number"),
                      value: loginInfo?.companies?.whatsapp ?? "",
                    ),
                    SizedBox(height: 16.h),
                    _buildRow(
                      label:AppLocalizations.of(context)!.translate("alternative_phone_number"),
                      value: loginInfo?.companies?.whatsapp ?? "",
                    ),
                    SizedBox(height: 16.h),
                    _buildDescription(
                      label:  AppLocalizations.of(context)!.translate("personal_email"),
                      value: loginInfo?.companies?.email ?? '',
                    ),
                    SizedBox(height: 16.h),
                    _buildDescription(label: AppLocalizations.of(context)!.translate("company_address")
                        , value: address),
                  ],
                ),
              );
            },
          ),
          //  AttachmentsSection(files: [],),
        ],
      ),
    );
  }

  Widget _buildRow({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.style14normal,
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            value,
            style: AppFonts.style16semiBold,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.style14normal,
        ),
        SizedBox(height: 4.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: globalDark ? AppColors.cardColorDark : AppColors.cardColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Text(
            value,
            style: AppFonts.style16semiBold,
          ),
        ),
      ],
    );
  }
}
