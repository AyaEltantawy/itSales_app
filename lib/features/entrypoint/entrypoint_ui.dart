import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/utils/transition.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:svg_flutter/svg.dart';
import '../../core/app/app.dart';
import '../../core/constants/app_icons.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_defaults.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/token.dart';
import '../HomeEmployee/screens/home_employee.dart';
import '../Tasks_Screens/data/cubit/cubit.dart';
import '../Tasks_Screens/screens/confirm/confirm_page.dart';
import '../Tasks_Screens/screens/tasks.dart';
import '../addTask/screens/add_Task.dart';
import '../auth/data/cubit.dart';
import '../auth/data/states.dart';
import '../home/data/cubit.dart';
import '../home/screens/employee_screen.dart';
import '../profile/screens/ProfilePage.dart';
import 'components/app_navigation_bar.dart';
import 'components/select_any_button_bottom_sheet.dart';

/// This page will contain all the bottom navigation tabs
class EntryPointUI extends StatefulWidget {
  const EntryPointUI({super.key});

  @override
  State<EntryPointUI> createState() => _EntryPointUIState();
}

class _EntryPointUIState extends State<EntryPointUI> {
  /// Current Page
  int currentIndex = 0;

  @override
  void initState() {
    AppCubit.get(context).getUserDataFun(context);
    role == '3'
        ? TasksCubit.get(context).getUserTaskFun(userId: userId.toString())
        : TasksCubit.get(context).getAllTasksFun();
    role == '3'
        ? TasksCubit.get(context).getAllTasksFunWithFilter(

    sort: 'complete_date', status: 'completed', employee: userId)
        : TasksCubit.get(context).getAllTasksFunWithFilter(
            sort: 'complete_date', status: 'completed');
    EmployeeCubit.get(context).getAllSales();
    TasksCubit.get(context)
        .getUserTaskFun(userId: userId.toString(), status: 'inbox');
    EmployeeCubit.get(context).getAdmins(role: 1);
    EmployeeCubit.get(context).getAdmins(role: 3);
    //EmployeeCubit.get(context).getAllEmployee();

    // TODO: implement initState
    super.initState();
  }

  /// On labelLarge navigation tap
  void onBottomNavigationTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  /// All the pages
  List<Widget> pages = [
  HomeEmployeeScreen(
      back: false,
    ),
     TasksScreenForEmployee(
      back: true,
    ),
  TasksScreenForEmployee(
      back: true,
    ),
    //const AddTaskScreen(back: false, isEdit: false, taskId: 0,),
    // const SavePage(isHomePage: false),
    role.toString() == "1"
        ? const AllEmployeeScreen(
            admin: false, task: false,
          )
        : const ConfirmTaskListPage(),
    // const AllEmployeeScreen(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppStates>(
      listener: (context, state) async {
        if (state is ThemeState) {
          globalDark = state.isDarkMode;
          setState(() {});
        } else {
          globalDark = context.read<AppCubit>().isDarkMode;
          setState(() {});
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              fillColor: AppColors.scaffoldBackground,
              child: child,
            );
          },
          duration: AppDefaults.duration,
          child: pages[currentIndex],
        ),
        floatingActionButton: SizedBox(
          height: 74,
          width: 74,

          child: FloatingActionButton(

            onPressed: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) =>
                    SelectAnyButtonBottomSheet(), // Replace with your bottom sheet widget
              );
            },
            shape: const CircleBorder(),
            child:Icon(Icons.add,color:Colors.white,size: 30.sp,),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AppBottomNavigationBar(
          currentIndex: currentIndex,
          onNavTap: onBottomNavigationTap,
        ),
      ),
    );
  }
}
