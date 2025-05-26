import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/core/routes/on_generate_route.dart';
import 'package:itsale/core/themes/app_themes.dart';
import 'package:itsale/generated/l10n.dart';

import '../../features/Tasks_Screens/data/cubit/cubit.dart';
import '../../features/auth/data/cubit.dart';
import '../../features/auth/data/states.dart';
import '../../features/auth/screens/forget_password/forget_password_view.dart';
import '../../features/home/data/cubit.dart';
import '../../features/profile/widgets/language_show_dialog/language_show_dialog_cubit.dart';
import '../../features/profile/widgets/language_show_dialog/language_show_dialog_state.dart';
import '../injection/injection.dart';
import '../localization/app_localizations.dart';
import '../models/enums/language_event_type.dart';

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
  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _sub;

  @override
  void initState() {
    super.initState();
    locale = Locale(widget.defaultLocale);

    languageCubit = LanguageShowDialogCubit()
      ..appLanguageFunc(LanguageEventEnums.InitialLanguage);

    _appLinks = AppLinks();

    _handleInitialAppLink();
    _handleIncomingAppLinks();
  }

  void _handleIncomingAppLinks() {
    _sub = _appLinks.uriLinkStream.listen(
          (Uri uri) {
        _processUri(uri);
      },
      onError: (err) {
        debugPrint('Error in app link stream: $err');
      },
    );
  }

  Future<void> _handleInitialAppLink() async {
    try {
      final initialUri = await _appLinks.getInitialAppLink();
      if (initialUri != null) {
        _processUri(initialUri);
      }
    } on PlatformException catch (e) {
      debugPrint('PlatformException while getting initial app link: $e');
    } catch (e) {
      debugPrint('Error while getting initial app link: $e');
    }
  }

  void _processUri(Uri uri) {
    debugPrint('Processing app link: $uri');

    final isResetPasswordDeepLink =
        (uri.scheme == 'geotask' && uri.host == 'reset_password') ||
            (uri.host == 'myapp.guessit.com' && uri.path == '/resetpass');

    if (isResetPasswordDeepLink) {
      final token = uri.queryParameters['token'];
      if (token != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ForgetPasswordPage()),
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
  void dispose() {
    _sub?.cancel();
    languageCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar colors
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
            BlocProvider(create: (_) => getIt<AppCubit>()),
            BlocProvider(create: (_) => getIt<EmployeeCubit>()),
            BlocProvider(create: (_) => getIt<TasksCubit>()),
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
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    if (deviceLocale != null) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                            deviceLocale.languageCode) {
                          return supportedLocale;
                        }
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
