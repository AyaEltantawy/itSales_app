import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';

import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/on_generate_route.dart';
import 'package:itsale/core/themes/app_themes.dart';
import 'package:itsale/features/HomeEmployee/screens/home_employee.dart';
import 'package:itsale/features/Tasks_Screens/data/cubit/cubit.dart';
import 'package:itsale/features/auth/screens/reset_password/reset_password_view.dart';

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
// import 'package:uni_links/uni_links.dart';

import 'dart:async';

var globalDark = false;

class MyApp extends StatefulWidget {
  final String defaultLocale;

  const MyApp({super.key, required this.defaultLocale});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale locale;
  late final LanguageShowDialogCubit languageCubit;
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleInitialLink();
    // _handleIncomingLinks();
    locale = Locale(widget.defaultLocale);
    languageCubit = LanguageShowDialogCubit()
      ..appLanguageFunc(LanguageEventEnums.InitialLanguage);
  }

  // void _handleIncomingLinks() {
  //   _sub = uriLinkStream.listen((Uri? uri) {
  //     _processUri(uri);
  //   }, onError: (err) {
  //     print('Error in deep link: $err');
  //   });
  // }

  Future<void> _handleInitialLink() async {
    try {
      // final uri = await getInitialUri();
      // _processUri(uri);
    } catch (e) {
      print('Error getting initial URI: $e');
    }
  }

  void _processUri(Uri? uri) {
    if (uri == null) return;

    if (uri.scheme == 'geotask' && uri.host == 'reset-password') {
      final token = uri.queryParameters['token'];
      if (token != null) {
        Future.microtask(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ResetPasswordPage(),
            ),
          );
        });
      }
    }
  }
  void _updateLocale(Locale newLocale) {
    setState(() {
      locale = newLocale;
    });
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
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<AppCubit>()),
            BlocProvider(create: (context) => getIt<EmployeeCubit>()),
            BlocProvider(create: (context) => getIt<TasksCubit>()),
            BlocProvider.value(value: languageCubit),
          ],
          child: BlocListener<LanguageShowDialogCubit, LanguageShowDialogState>(
            listener: (context, state) {
              if (state is AppLanguageChangeState) {
                _updateLocale(Locale(state.languageCode));
              }
            },
            child: BlocConsumer<AppCubit, AppStates>(
              listener: (context, state) {
                if (state is ThemeState) {
                  globalDark = state.isDarkMode;
                  setState(() {});
                }
              },
              builder: (context, state) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  locale: locale,
                  themeMode: AppCubit.get(context).isDarkMode
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  theme: AppTheme.defaultTheme,
                  darkTheme: AppTheme.darkTheme,
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
                  localeResolutionCallback: (locale, supportedLocales) {
                    for (var supportedLocale in supportedLocales) {
                      if (supportedLocale.languageCode == locale?.languageCode) {
                        return supportedLocale;
                      }
                    }
                    return supportedLocales.first;
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
