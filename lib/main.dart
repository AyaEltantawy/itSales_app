import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_links/app_links.dart';

import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/constants/storage_constants.dart';
import 'package:itsale/core/injection/injection.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:itsale/features/auth/screens/forget_password/forget_password_view.dart';
import 'package:itsale/features/profile/widgets/language_show_dialog/widgets/restart_widget.dart';

// Global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

SharedPreferences? sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await getInit();
    sharedPreferences = await SharedPreferences.getInstance();
    await CacheHelper.init();

    // Load cached values
    token = CacheHelper.getData(key: 'token');
    role = CacheHelper.getData(key: 'role');
    userId = CacheHelper.getData(key: 'userId');
    globalDark = CacheHelper.getData(key: 'isDark') ?? false;
    companyId = CacheHelper.getData(key: 'company_id');

    final defaultLocale = sharedPreferences?.getString('lang') ?? 'ar';

    // Start the app
    runApp(
      RestartWidget(
        child: MyApp(defaultLocale: defaultLocale),
      ),
    );

    // Handle deep links after app start
    final AppLinks appLinks = AppLinks();

    appLinks.uriLinkStream.listen((Uri uri) {
      debugPrint('Received deep link: $uri');

      final String host = uri.host.toLowerCase();
      final String path = uri.path.toLowerCase();

      // Support both app links and custom schemes
      if ((host == 'myapp.guessit.com' && path == '/resetpass') ||
          (uri.scheme == 'geotask' && host == 'reset_password')) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => ForgetPasswordPage()),
        );
      }
    });
  } catch (e, stackTrace) {
    debugPrint('Error during main() init: $e');
    debugPrintStack(stackTrace: stackTrace);
  }
}
