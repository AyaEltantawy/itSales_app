import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:itsale/features/SplashScreen/splash_screen.dart';
import 'package:itsale/features/addEmployee/data/models/add_employee_model.dart';
import 'package:itsale/features/auth/data/repo.dart';
import 'package:itsale/features/auth/screens/otp/otp_view.dart';
import 'package:itsale/features/auth/screens/register/register_view.dart';
import 'package:itsale/features/auth/screens/reset_password/reset_password_view.dart';

import 'package:itsale/features/auth/screens/sign_up_page.dart';

import 'package:itsale/features/choose_page/screens/choose_page.dart';
import 'package:itsale/features/entrypoint/entrypoint_ui.dart';
import 'package:itsale/features/onboarding/onboarding_page.dart';
import 'package:itsale/features/notifications/notification_page.dart';
import 'package:itsale/features/profile/settings/change_password_page.dart';
import 'package:itsale/features/profile/settings/MainSettingPage.dart';
import 'package:itsale/features/profile/settings/language_settings_page.dart';
import 'package:itsale/features/notifications/notifications_settings_page.dart';
import 'package:itsale/features/profile/screens/ProfilePage.dart';

import '../../features/HomeEmployee/screens/home_employee.dart';
import '../../features/Tasks_Screens/screens/confirm/confirm_page.dart';
import '../../features/Tasks_Screens/screens/task_details.dart';
import '../../features/Tasks_Screens/screens/tasks.dart';
import '../../features/addEmployee/screens/add_employee.dart';
import '../../features/addTask/screens/add_Task.dart';
import '../../features/auth/company/company_view.dart';
import '../../features/auth/screens/choose_login_or_sign_up/choose_login_or_sign_up_view.dart';
import '../../features/auth/screens/forget_password/forget_password_view.dart';

import '../../features/auth/screens/intro_login_page.dart';
import '../../features/auth/screens/login_or_signup_page.dart';
import '../../features/auth/screens/login_page.dart';
import '../../features/auth/screens/number_verification_page.dart';
import '../../features/auth/screens/password_changed_success/success_view.dart';
import '../../features/auth/screens/password_reset_page.dart';
import '../../features/detailed_employee_screen/screens/detailed_employee_screens.dart';
import '../../features/entrypoint/components/select_any_button_bottom_sheet.dart';
import '../../features/home/components/widgets_for_tasks_screen.dart';
import '../../features/home/screens/employee_screen.dart';
import '../../features/profile/widgets/edit_data/edit_data_view.dart';
import '../../features/profile/widgets/help/help_view.dart';
import '../../features/profile/widgets/reports/reports_view.dart';
import '../remote_data_source/web_services.dart';
import '../utils/transition.dart';
import 'app_routes.dart';
import 'unknown_page.dart';

class RouteGenerator {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRoutes.introLogin:
        return animatedNavigation(screen: const IntroLoginPage());

      case AppRoutes.splash:
        return animatedNavigation(screen: const SplashScreen());

      case AppRoutes.onBoarding:
        return animatedNavigation(screen: const OnBoardingPage());

      case AppRoutes.login:
        return animatedNavigation(screen: LoginPage());

      case AppRoutes.choosePage:
        return animatedNavigation(screen: const ChoosePage());

      case AppRoutes.reportsPge:
        return animatedNavigation(screen: ReportsPage());

      case AppRoutes.entryPoint:
        return animatedNavigation(screen: const EntryPointUI());
      case AppRoutes.otpPage:
        return animatedNavigation(screen: OtpPage());
      case AppRoutes.registerPage:
        return animatedNavigation(
            screen: RegisterPage(
          repository: Repository(WebServices(Dio())),
        ));
      case AppRoutes.passwordChangedSuccessPage:
        return animatedNavigation(screen: SuccessPage());

      case AppRoutes.addEmployee:
        return animatedNavigation(
            screen: const AddNewEmployee(
          empId: 0,
          isEdit: false,
        ));

      case AppRoutes.allEmployees:
        return animatedNavigation(
            screen: const AllEmployeeScreen(
          task: false,
          admin: false,
        ));

      case AppRoutes.confirmPage:
        return animatedNavigation(screen: const ConfirmTaskListPage());
      case AppRoutes.resetPasswordPage:
        return animatedNavigation(screen: ResetPasswordPage());
      case AppRoutes.companyPage:
        return animatedNavigation(screen: const CompanyPage());
      case AppRoutes.homeTasks:
        return animatedNavigation(
            screen: TasksScreenForEmployee(
          back: false,
        ));

      // case AppRoutes.taskDetails:
      //   return  animatedNavigation(screen: const TaskDetailsScreen());
      //

      case AppRoutes.signup:
        return animatedNavigation(screen: const SignUpPage());
      case AppRoutes.successPage:
        return animatedNavigation(screen: SuccessPage());
      case AppRoutes.profilePage:
        return animatedNavigation(screen: const SettingsPage());

      case AppRoutes.loginOrSignup:
        return animatedNavigation(screen: const LoginOrSignUpPage());

      case AppRoutes.numberVerification:
        return animatedNavigation(screen: const NumberVerificationPage());

      case AppRoutes.forgotPassword:
        return animatedNavigation(screen: ForgetPasswordPage());

      case AppRoutes.passwordReset:
        return animatedNavigation(screen: const PasswordResetPage());

      case AppRoutes.homeEmployee:
        return animatedNavigation(
            screen: HomeEmployeeScreen(
          back: false,
        ));
      case AppRoutes.helpPge:
        return animatedNavigation(screen: const HelpPage());
      case AppRoutes.editDataPage:
        return animatedNavigation(screen: EditDataPage());

      case AppRoutes.addTask:
        return animatedNavigation(
            screen: const AddTaskScreen(
          taskId: 0,
          isEdit: false,
          back: true,
        ));

      case AppRoutes.notifications:
        return animatedNavigation(screen: const NotificationPage());
      case AppRoutes.changePasswordPage:
        return animatedNavigation(screen: const ChangePasswordPage());

      case AppRoutes.settingsNotifications:
        return animatedNavigation(screen: const NotificationSettingsPage());

      case AppRoutes.settings:
        return animatedNavigation(screen: const SettingsPage());

      case AppRoutes.settingsLanguage:
        return animatedNavigation(screen: const LanguageSettingsPage());
      case AppRoutes.chooseLoginOrSignUpPage:
        return animatedNavigation(screen: ChooseLoginOrSignUpPage());
      case AppRoutes.selectAnyButtonBottomSheet:
        return animatedNavigation(screen: const SelectAnyButtonBottomSheet());

      case AppRoutes.changePassword:
        return animatedNavigation(screen: const ChangePasswordPage());

      case AppRoutes.changePhoneNumber:
        return animatedNavigation(screen: const MainSettingsPage());

      default:
        return errorRoute();
    }
  }

  static Route? errorRoute() =>
      CupertinoPageRoute(builder: (_) => UnknownPage());
}
