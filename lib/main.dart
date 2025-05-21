import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/constants/storage_constants.dart';
import 'package:itsale/core/injection/injection.dart';
import 'package:itsale/core/utils/check_internet.dart';
import 'package:itsale/core/utils/token.dart';

import 'features/profile/widgets/language_show_dialog/widgets/restart_widget.dart';

SharedPreferences? sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    //Initialize dependencies
    await getInit();

    // Initialize SharedPreferences and Cache
    sharedPreferences = await SharedPreferences.getInstance();
    await CacheHelper.init();

    // Check internet connectivity (optional - non-blocking preferred)
    //await NetworkInfoImpl().checkInternet();

    // Load cached values
    token = CacheHelper.getData(key: 'token');
    role = CacheHelper.getData(key: 'role');
    userId = CacheHelper.getData(key: 'userId');
    globalDark = CacheHelper.getData(key: 'isDark') ?? false;

    // Load language preference
    final defaultLocale = sharedPreferences?.getString('lang') ?? 'ar';

    // Run app
    runApp(
      RestartWidget(
        child: MyApp(defaultLocale: defaultLocale),
      ),
    );
  } catch (e, stackTrace) {
    // Catch any initialization errors
    debugPrint('Error during main() init: $e');
    debugPrintStack(stackTrace: stackTrace);
  }
}
