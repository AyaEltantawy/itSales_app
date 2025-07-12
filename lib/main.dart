import 'dart:async';
import 'package:flutter/material.dart';
import 'package:itsale/core/constants/constants.dart';
import 'package:itsale/core/routes/app_routes.dart';
import 'package:itsale/features/auth/screens/reset_password/reset_password_view.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_links/app_links.dart';
import 'package:itsale/core/app/app.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/constants/storage_constants.dart';
import 'package:itsale/core/injection/injection.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:itsale/features/profile/widgets/language_show_dialog/widgets/restart_widget.dart';
import 'core/localization/app_localizations.dart';
import 'core/routes/on_generate_route.dart';

SharedPreferences? sharedPreferences;
late final AppLocalizations localizations;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MediaStore.ensureInitialized();
  try {
    await getInit();
    sharedPreferences = await SharedPreferences.getInstance();
    await CacheHelper.init();
    resetToken = CacheHelper.getData(key: "reset_token");
    token = CacheHelper.getData(key: 'token');
    role = CacheHelper.getData(key: 'role');
    userId = CacheHelper.getData(key: 'userId');
    globalDark = CacheHelper.getData(key: 'isDark') ?? false;
    companyId = CacheHelper.getData(key: 'company_id');
    passwordLogin = CacheHelper.getData(key: 'password');
    idMainUser = CacheHelper.getData(key: 'id_user');
    passwordAddMain = CacheHelper.getData(key: 'password_add_$idMainUser');
    print("passMainLogin$passwordLogin");
    final defaultLocale = sharedPreferences?.getString('lang') ?? 'ar';

    runApp(
      RestartWidget(
        child: MyApp(
          defaultLocale: defaultLocale,
        ),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error during main() init: $e');
    debugPrintStack(stackTrace: stackTrace);
  }
}
