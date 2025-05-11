import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/components/default_app_bar.dart';
import 'package:itsale/core/constants/app_colors.dart';
import 'package:itsale/core/constants/app_defaults.dart';
import 'package:itsale/core/constants/app_fonts.dart';

import '../../../core/constants/navigation.dart';
import '../../../core/routes/app_routes.dart';
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
import '../../home/components/widgets_for_tasks_screen.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final String name;
  final String role;
  final String avatar;
  final String email;
  final String phone1;
  final String phone2;
  final String address;
  final String passwordToken;
  final String empEmail;
  final String whatsapp;
  final String id;


  const EmployeeDetailsScreen({super.key,
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
    required this.role, });

  @override
  _EmployeeDetailsScreenState createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  int selectedTab = 0;
@override
  void initState() {

  TasksCubit.get(context).getUserTaskFun(userId: widget.id);


  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: [
             Padding(
               padding:  EdgeInsets.all(10.0.h),
               child: const  CustomAppBar(back: true, title: 'تفاصيل الموظف'),
             ),
               ProfileHeader(id : int.parse(widget.id) , name: widget.name,role: widget.role, avatar: widget.avatar,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDefaults.padding.w / 1.6),
                child: Container(
                  decoration: BoxDecoration(
                    color: globalDark ? AppColors.cardColorDark : AppColors.gray,
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
                phone1: widget.phone1 ?? 'لا يوجد',
              phone2: widget.phone2 != '' ? widget.phone2 : 'لا يوجد',
                whatsapp:  widget.whatsapp != '' ? widget.whatsapp : 'لا يوجد',
                empEmail: widget.empEmail != '' ? widget.empEmail : 'لا يوجد',
                password:  widget.passwordToken != '' ? widget.passwordToken : 'لا يوجد',
                address:  widget.address != '' ? widget.address : 'لا يوجد',
                name:  widget.name != '' ? widget.name : 'لا يوجد',
                emailLogin:  widget.email != '' ? widget.email : 'لا يوجد',
              ),
        
            ],
          ),
        ),
      ),
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
    return  OverviewSection(
      phone1: phone1,
    id: id,
    phone2: phone2,
      whatsapp: whatsapp,
      empEmail: empEmail,
    );
  } else if (selectedTab == 1) {
    return const TaskListInProfile();
  } else {
    return  EmployeeInfo(name: name,
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
  final int selectedTab; // Receives the current selected tab from parent
  final Function(int) onTabSelected; // Callback to inform parent when a tab is selected

  const TabSelector({super.key, required this.selectedTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab("نظرة عامة", 0), // Overview tab
        _buildTab("المهام", 1), // Tasks tab
        _buildTab("المعلومات", 2), // Information tab
      ],
    );
  }

  // Helper method to build each tab
  Widget _buildTab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index), // Call the parent widget's onTabSelected method
        child: Container(
          decoration: BoxDecoration(
            color: selectedTab == index ?
            globalDark ? AppColors.primary :   Colors.black :  globalDark ? AppColors.cardColorDark : AppColors.gray, // Active tab is black, inactive is gray
            borderRadius: BorderRadius.circular(8.r), // Rounded corners for tabs
          ),
          padding: EdgeInsets.all(16.h), // Adds padding inside the tab
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selectedTab == index ? Colors.white :  globalDark ? AppColors.textWhite : AppColors.textBlack, // Active tab text is white
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
  const TaskListInProfile({super.key});

  @override
  State<TaskListInProfile> createState() => _TaskListInProfileState();
}

class _TaskListInProfileState extends State<TaskListInProfile> {

  bool isGrid = false;

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
            padding:  EdgeInsets.only(right: AppDefaults.padding.w, top: AppDefaults.padding.h / 2 ),
            child: BuildSearchFilter(task : true ,admin: false,
                emp : false , isGrid: isGrid,
                toggleViewMode: toggleViewMode),
          ),
          Padding(
            padding:  EdgeInsets.all(AppDefaults.padding.w),
            child: BlocConsumer<TasksCubit,TasksStates>(
                listener: (context, state) {

                },
                builder: (context, state) {



                  if(state is NoInternetState)
                  {

                    return const NoInternet();

                  }
                  if(state is GetLoadingSearchTaskFilterState)
                  {

                    return Column(
                      children: [
                        SizedBox(height: 10.h,),
                        const LinearProgressIndicator(),
                      ],
                    );

                  }

                  if(state is GetSuccessSearchTaskFilterState)
                  {

                    return   TasksCubit.get(context).getAllTaskListFilter!.isNotEmpty  ?
                    TaskListFilter(isGrid: isGrid)
                        : nothing(context,route:
                    AppRoutes.addTask,button: 'مهمة',text: 'لا يوجد');

                  }
                  if(state is GetLoadingUserTaskState) {
                    return loader();
                  }
                  if(state is GetSuccessAllTaskFilterState  )

                  {
                    return   TasksCubit.get(context).getAllTaskListFilter!.isNotEmpty  ? TaskListFilter(isGrid: isGrid)
                        : nothing(context,route: AppRoutes.addTask,button: 'مهمة',text: 'لا يوجد');

                  }

                  return ( TasksCubit.get(context).getUserTaskList!.isNotEmpty  ) ?
                  TaskListForAdminToShowUserTasks(isGrid: isGrid) :
                  nothing(context,route: AppRoutes.addTask,button: 'مهمة',text: 'لا يوجد مهام الى الان');



                }
            ),
          ),
        ],
      ),
    );
  }
}

// Overview Section (for the "Overview" tab)
class OverviewSection extends StatefulWidget {
  final String phone1;
  final String phone2;
  final String empEmail;
  final String whatsapp;
  final String id;
  const OverviewSection({super.key,
    required this.phone1,
    required this.phone2,
    required this.empEmail,
    required this.whatsapp, required this.id,

  });

  @override
  State<OverviewSection> createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection> {
  List<DataUserTask>? completedTasks;
  List<DataUserTask>? uncompletedTasks;
  @override
  void initState() {

    completedTasks = TasksCubit.get(context).getUserTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    uncompletedTasks = TasksCubit.get(context).getUserTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppDefaults.padding.w / 1.6),
          child: Text(S.of(context).today_tasks,style: AppFonts.style20Bold,),
        ),
        SizedBox(height: 8.h),
        BlocBuilder<TasksCubit,TasksStates>(
          builder: (context, state) {
            if(state is GetLoadingUserTaskState)
            {
              return loader();
            }
            return Padding(
              padding:  EdgeInsets.symmetric(horizontal: AppDefaults.padding.w / 1.6),
              child:
              TaskSummarySectionForEmployee(completedTasks: completedTasks, uncompletedTasks: uncompletedTasks,),
            );
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
         ContactOptionsCard(phone1: widget.phone1,

         phone2: widget.phone2,
           empEmail: widget.empEmail,
           whatsapp: widget.whatsapp,
         ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 1.6),
          child: Column(

            children: [
              SizedBox(height: 20.h),
              const ChartsSection(),
              SizedBox(height: 16.h),

                      CompletedTasksSectionForOneUser(id : widget.id),


              SizedBox(height: 32.h),
            ],
          ),
        ),


      ],
    );
  }
}

class CompletedTasksSectionForOneUser extends StatefulWidget {
  const CompletedTasksSectionForOneUser({super.key, required this.id, });
final String id;
  @override
  State<CompletedTasksSectionForOneUser> createState() => _CompletedTasksSectionForOneUserState();
}

class _CompletedTasksSectionForOneUserState extends State<CompletedTasksSectionForOneUser> {

  List<DataUserTask>? data = [];
  @override
  void initState() {
    TasksCubit.get(context).getUserTaskFun(userId: widget.id, status: 'completed');
 data = TasksCubit.get(context).getUserTaskListWithStatus;

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(AppDefaults.padding),

      decoration: BoxDecoration(
        color: globalDark ?
        AppColors.cardColorDark : AppColors.cardColor,
        border: Border.all(color: globalDark ?
        AppColors.borderColorDark : AppColors.borderColor, width: 0.5),
        borderRadius: BorderRadius.circular(8.0.r),
      ),
      child:      BlocBuilder<TasksCubit,TasksStates>(
        builder: (context, state) {
          if (state is GetLoadingUserTaskStateForEmpScreens) {
            return loader();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المهمات المكتملة',
                textAlign: TextAlign.right,
                style: AppFonts.style16semiBold,
              ),

              data!.isNotEmpty
                  ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              animatedNavigation(
                                  screen: TaskDetailsScreen(
                                    file: data![index].files!.isNotEmpty ||
                                        data![index].files != null
                                        ? data![index].files
                                        : [],
                                    task_status: data![index].task_status
                                        .toString(),
                                    id: data![index].id!.toInt(),
                                    locationId: data![index].location != null
                                        ? data![index].location!.id.toString()
                                        : '10',
                                    nameTask: data![index].title.toString(),
                                    nameEmployee:
                                    '${data![index].assigned_to!.first_name
                                        .toString()} ${data![index].assigned_to!
                                        .last_name.toString()}',
                                    nameClient: data![index].client_name
                                        .toString(),
                                    phoneClient:
                                    data![index].client_phone.toString(),
                                    notes: data![index].notes.toString(),
                                    address: data![index].location != null
                                        ? data![index].location!.address
                                        .toString()
                                        : 'لا يوجد',
                                    link: data![index].location != null
                                        ? data![index].location!.map_url
                                        .toString()
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
                  separatorBuilder: (context, index) =>
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Divider(
                          color: globalDark ?
                          AppColors.borderColorDark : AppColors.borderColor,
                        ),
                      ),
                  itemCount: data!.length)
                  : Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(child: Text(
                      'لا يوجد بيانات', style: AppFonts.style12light)),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ],
          );
        },
      ),

    );
  }
}

class TaskSummarySectionForEmployee extends StatefulWidget {
   TaskSummarySectionForEmployee({super.key,required  this.completedTasks,
    required  this.uncompletedTasks,});
  List<DataUserTask>? completedTasks;
  List<DataUserTask>? uncompletedTasks;

  @override
  State<TaskSummarySectionForEmployee> createState() => _TaskSummarySectionForEmployeeState();
}

class _TaskSummarySectionForEmployeeState extends State<TaskSummarySectionForEmployee> {


 @override
  void initState() {
   widget.completedTasks = TasksCubit.get(context).getUserTaskList!
       .where((task) => task.task_status == 'completed')
       .toList();
   widget.uncompletedTasks = TasksCubit.get(context).getUserTaskList!
       .where((task) => task.task_status != 'completed')
       .toList();
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    widget.completedTasks = TasksCubit.get(context).getUserTaskList!
        .where((task) => task.task_status == 'completed')
        .toList();
    widget.uncompletedTasks = TasksCubit.get(context).getUserTaskList!
        .where((task) => task.task_status != 'completed')
        .toList();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {




    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TaskSummaryCard(
          title: 'كل المهمات',
          count: TasksCubit.get(context).getUserTaskList!.length.toString(),
          color: AppColors.primary,
        ),

        TaskSummaryCard(
          title: 'مكتمل',
          count:  widget.completedTasks!.length.toString(),
          color: Colors.green,
        ),
        TaskSummaryCard(
          title: 'غير مكتمل',
          count:  widget.uncompletedTasks!.length.toString(),
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

  const EmployeeInfo({super.key, required this.name, required this.phone1, required this.phone2, required this.emailLogin, required this.empEmail, required this.password, required this.address});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
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
                Text(S.of(context).login_data,style: AppFonts.style16semiBold,),
                SizedBox(height: 8.h),
                _buildRow(label: 'البريد الالكتروني', value: emailLogin),
                SizedBox(height: 16.h),
                _buildRow(label: 'كلمة المرور', value: '**********'),
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
                Text(S.of(context).employee_data,style: AppFonts.style16semiBold,),
                SizedBox(height: 8.h),
                _buildRow(label: 'الاسم', value: name),
                SizedBox(height: 16.h),
                _buildRow(label: 'رقم الهاتف', value: phone1),
                SizedBox(height: 16.h),
                _buildRow(label: 'رقم الهاتف البديل', value: phone2),
                SizedBox(height: 16.h),
                _buildDescription(label: 'البريد الالكتروني الخاص', value: empEmail),
                SizedBox(height: 16.h),
                _buildDescription(label: 'عنوان الاقامة', value: address),

              ],
            ),
          ),


          SizedBox(height: 16.h),
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
            color:globalDark ? AppColors.cardColorDark : AppColors.cardColor
           ,
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
            color:globalDark ? AppColors.cardColorDark : AppColors.cardColor,
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
