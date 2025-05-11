
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
import '../injection/injection.dart';

var globalDark = false;



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      return  MultiBlocProvider(
        providers: [
          BlocProvider(
            create: ( context) => getIt<AppCubit>(),
          ),
          BlocProvider(
            create: ( context) => getIt<EmployeeCubit>(),
          ),

          BlocProvider(
            create: ( context) => getIt<TasksCubit>(),
          ),
        ],
        child: BlocConsumer<AppCubit,AppStates>  (
          listener: (context , state) async {
            if (state is ThemeState) {
              globalDark = state.isDarkMode;
              setState(() {

              });
            } else {
              globalDark = context.read<AppCubit>().isDarkMode;

            }
// if(state is ThemeState)
// {
//   setState(() {
//     globalDark = CacheHelper.getData(key: 'isDark') ?? false ;
//
//   });


 print('faaaaaaaaaaaaaaaaaaaaaaaaal$globalDark');
 print('faaaaaaaaaaaaaaaaaaaaaaaaal${AppCubit.get(context).isDarkMode}');
//}

          },
          builder: ( context , state)  {


            return

              MaterialApp(
                themeMode: ThemeMode.system,
                theme: AppCubit.get(context).isDarkMode ? AppTheme.darkTheme : AppTheme.defaultTheme,
                locale: const Locale('ar'),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                title: 'itSales',
                onGenerateRoute: RouteGenerator.onGenerate,
                initialRoute: AppRoutes.splash,

              );

          }
      ),
      );
    },
    );

  }

  void restart() {
    setState(() {});
  }
}
