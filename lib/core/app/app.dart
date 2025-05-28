import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/core/routes/on_generate_route.dart';
import 'package:itsale/core/themes/app_themes.dart';
import 'package:itsale/generated/l10n.dart';
import '../../features/Tasks_Screens/data/cubit/cubit.dart';
import '../../features/auth/data/states.dart';
import '../../features/auth/screens/reset_password/reset_password_view.dart';
import '../../features/auth/data/cubit.dart';
import '../../features/home/data/cubit.dart';
import '../../features/profile/widgets/language_show_dialog/language_show_dialog_cubit.dart';
import '../../features/profile/widgets/language_show_dialog/language_show_dialog_state.dart';
import '../injection/injection.dart';
import '../localization/app_localizations.dart';
import '../models/enums/language_event_type.dart';
import '../routes/app_routes.dart';
import '../utils/transition.dart';

var globalDark = false;

class MyApp extends StatefulWidget {
  final String defaultLocale;


  const MyApp({
    super.key,
    required this.defaultLocale,

  });

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

    // Delay the initial app link handling until after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialAppLink();
      _handleIncomingAppLinks();
    });
  }

  void _handleIncomingAppLinks() {
    _sub = _appLinks.uriLinkStream.listen(
          (Uri uri) => _processUri(uri),
      onError: (err) => debugPrint('Deep link error: $err'),
    );
  }

  Future<void> _handleInitialAppLink() async {
    try {
      final initialUri = await _appLinks.getInitialAppLink();
      if (initialUri != null) _processUri(initialUri);
    } catch (e) {
      debugPrint('Initial link error: $e');
    }
  }

  void _processUri(Uri uri) async{
    debugPrint('Processing deep link: $uri');

    if (uri.path == '/reset-password') {
      final resetToken = uri.queryParameters['token'];
 await CacheHelper.saveData(key: "reset_token", value: resetToken);
      debugPrint("resetToken: $resetToken");
print("MainResetToken$resetToken");
      if (resetToken != null && resetToken.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordPage(resetToken: resetToken),
          ),
        );
      } else {
        // No navigation — just show a simple message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid or missing reset token.'),
          ),
        );
      }
    } else {
      debugPrint('Unknown deep link: ${uri.toString()}');
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
                  onGenerateRoute: RouteGenerator.onGenerate,
                  locale: locale,
                  themeMode: globalDark ? ThemeMode.dark : ThemeMode.light,
                  theme: AppTheme.defaultTheme,
                  darkTheme: AppTheme.darkTheme,
                  supportedLocales: const [
                    Locale('ar'),
                    Locale('en'),
                  ],
                  title: 'itSales',

                  initialRoute: AppRoutes.splash,
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  localeResolutionCallback: (deviceLocale, supportedLocales) {
                    if (deviceLocale != null) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode == deviceLocale
                            .languageCode) {
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
