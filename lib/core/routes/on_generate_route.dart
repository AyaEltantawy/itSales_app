import 'package:flutter/cupertino.dart';
import 'package:itsale/features/SplashScreen/splash_screen.dart';

import 'package:itsale/features/auth/screens/sign_up_page.dart';

import 'package:itsale/features/choose_page/screens/choose_page.dart';
import 'package:itsale/features/entrypoint/entrypoint_ui.dart';
import 'package:itsale/features/onboarding/onboarding_page.dart';
import 'package:itsale/features/notifications/notification_page.dart';
import 'package:itsale/features/profile/settings/change_password_page.dart';
import 'package:itsale/features/profile/settings/MainSettingPage.dart';
import 'package:itsale/features/profile/settings/language_settings_page.dart';
import 'package:itsale/features/notifications/notifications_settings_page.dart';
import 'package:itsale/features/profile/settings/ProfilePage.dart';


import '../../features/HomeEmployee/screens/home_employee.dart';
import '../../features/Tasks_Screens/screens/confirm/confirm_page.dart';
import '../../features/Tasks_Screens/screens/task_details.dart';
import '../../features/Tasks_Screens/screens/tasks.dart';
import '../../features/addEmployee/screens/add_employee.dart';
import '../../features/addTask/screens/add_Task.dart';
import '../../features/auth/screens/forget_password_page.dart';
import '../../features/auth/screens/intro_login_page.dart';
import '../../features/auth/screens/login_or_signup_page.dart';
import '../../features/auth/screens/login_page.dart';
import '../../features/auth/screens/number_verification_page.dart';
import '../../features/auth/screens/password_reset_page.dart';
import '../../features/detailed_employee_screen/screens/detailed_employee_screens.dart';
import '../../features/home/screens/employee_screen.dart';
import '../utils/transition.dart';
import 'app_routes.dart';
import 'unknown_page.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.introLogin:
        return   animatedNavigation(screen: const IntroLoginPage());

      case AppRoutes.splash:
        return  animatedNavigation(screen: const SplashScreen());

      case AppRoutes.onBoarding:
        return  animatedNavigation(screen: const OnBoardingPage());

      case AppRoutes.login:
        return  animatedNavigation(screen: const LoginPage());

      case AppRoutes.choosePage:
        return   animatedNavigation(screen: const ChoosePage());


      case AppRoutes.entryPoint:
        return  animatedNavigation(screen: const EntryPointUI());

      case AppRoutes.addEmployee:
        return
          animatedNavigation(screen: const AddNewEmployee(isEdit: false, empId: 0,));

      case AppRoutes.allEmployees:
        return  animatedNavigation(screen: const AllEmployeeScreen(admin: false,));


      case AppRoutes.confirmPage:
        return  animatedNavigation(screen: const ConfirmTaskListPage());

      case AppRoutes.homeTasks:
        return  animatedNavigation(screen: const TasksScreenForEmployee(back: false,));


      // case AppRoutes.taskDetails:
      //   return  animatedNavigation(screen: const TaskDetailsScreen());
      //




      case AppRoutes.signup:
        return  animatedNavigation(screen: const SignUpPage());

      case AppRoutes.loginOrSignup:
        return  animatedNavigation(screen: const LoginOrSignUpPage());

      case AppRoutes.numberVerification:
        return animatedNavigation(screen: const NumberVerificationPage());

      case AppRoutes.forgotPassword:
        return  animatedNavigation(screen: const ForgetPasswordPage());

      case AppRoutes.passwordReset:
        return  animatedNavigation(screen: const PasswordResetPage());



      case AppRoutes.homeEmployee:
        return  animatedNavigation(screen: const HomeEmployeeScreen(back: false,));

      case AppRoutes.addTask:
        return  animatedNavigation(screen: const AddTaskScreen(
          taskId: 0,
          isEdit: false,
          back: true,));

      case AppRoutes.notifications:
        return  animatedNavigation(screen: const NotificationPage());

      case AppRoutes.settingsNotifications:
        return  animatedNavigation(screen: const NotificationSettingsPage());

      case AppRoutes.settings:
        return  animatedNavigation(screen: const SettingsPage());

      case AppRoutes.settingsLanguage:
        return  animatedNavigation(screen: const LanguageSettingsPage());

      case AppRoutes.changePassword:
        return  animatedNavigation(screen: const ChangePasswordPage());

      case AppRoutes.changePhoneNumber:
        return  animatedNavigation(screen: const MainSettingsPage());


      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
        CupertinoPageRoute(builder: (_) => UnknownPage());
}
