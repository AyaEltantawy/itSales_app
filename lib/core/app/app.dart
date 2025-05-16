import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';

import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/on_generate_route.dart';
import 'package:itsale/core/themes/app_themes.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';

import 'package:itsale/features/home/data/cubit.dart';
import 'package:itsale/generated/l10n.dart';

import '../../features/auth/data/cubit.dart';
import '../../features/auth/data/states.dart';
import '../../features/profile/widgets/language_show_dialog/language_show_dialog_cubit.dart';
import '../../features/profile/widgets/language_show_dialog/language_show_dialog_state.dart'
    show AppLanguageChangeState, LanguageShowDialogState;
import '../../features/profile/widgets/language_show_dialog/language_show_dialog_view.dart';
import '../injection/injection.dart';
import '../localization/app_localizations.dart';
import '../models/enums/language_event_type.dart';

var globalDark = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LanguageShowDialogCubit languageCubit;

  @override
  void initState() {
    super.initState();
    languageCubit = LanguageShowDialogCubit();
    // No need to call appLanguageFunc here, Cubit's constructor already loads saved language
  }

  @override
  void dispose() {
    languageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
      ),
    );

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AppCubit>()),
            BlocProvider(create: (context) => getIt<EmployeeCubit>()),
            BlocProvider(create: (context) => getIt<TasksCubit>()),
            BlocProvider<LanguageShowDialogCubit>.value(value: languageCubit),
          ],
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {
              if (state is ThemeState) {
                globalDark = state.isDarkMode;
                setState(() {});
              } else {
                globalDark = context.read<AppCubit>().isDarkMode;
              }
            },
            builder: (context, state) {
              return BlocBuilder<LanguageShowDialogCubit, LanguageShowDialogState>(
                builder: (context, state) {
                  Locale locale = const Locale('en');
                  if (state is AppLanguageChangeState) {
                    locale = Locale(state.languageCode);
                  }

                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    themeMode: AppCubit.get(context).isDarkMode ? ThemeMode.dark : ThemeMode.light,
                    theme: AppTheme.defaultTheme,
                    darkTheme: AppTheme.darkTheme,
                    locale: locale,
                    supportedLocales: const [
                      Locale('ar'),
                      Locale('en'),
                    ],
                    title: 'itSales',
                    onGenerateRoute: RouteGenerator.onGenerate,
                    initialRoute: AppRoutes.splash,
                    localizationsDelegates:  [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    localeListResolutionCallback: (deviceLocales, supportedLocales) {
                      if (deviceLocales == null || deviceLocales.isEmpty) {
                        return supportedLocales.first;
                      }
                      for (var deviceLocale in deviceLocales) {
                        for (var supportedLocale in supportedLocales) {
                          if (deviceLocale.languageCode == supportedLocale.languageCode) {
                            return supportedLocale;
                          }
                        }
                      }
                      return supportedLocales.first;
                    },
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
