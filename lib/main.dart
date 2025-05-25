import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itsale/features/auth/screens/forget_password/forget_password_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/constants/storage_constants.dart';
import 'package:itsale/core/injection/injection.dart';
import 'package:itsale/core/utils/token.dart';

import 'features/profile/widgets/language_show_dialog/widgets/restart_widget.dart';

import 'package:app_links/app_links.dart';

SharedPreferences? sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await getInit();
    sharedPreferences = await SharedPreferences.getInstance();
    await CacheHelper.init();

    token = CacheHelper.getData(key: 'token');
    role = CacheHelper.getData(key: 'role');
    userId = CacheHelper.getData(key: 'userId');
    globalDark = CacheHelper.getData(key: 'isDark') ?? false;
    companyId = CacheHelper.getData(key: 'company_id');

    final defaultLocale = sharedPreferences?.getString('lang') ?? 'ar';

    runApp(
      RestartWidget(
        child: MyApp(defaultLocale: defaultLocale),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error during main() init: $e');
    debugPrintStack(stackTrace: stackTrace);
  }
}

