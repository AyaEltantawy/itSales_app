import 'package:flutter/material.dart';
import 'package:itsale/core/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/cache_helper/cache_helper.dart';
import 'core/injection/injection.dart';
import 'core/utils/check_internet.dart';
import 'core/utils/token.dart';
import 'core/constants/storage_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 //sharedPreferences = await SharedPreferences.getInstance();
  getInit();
  await NetworkInfoImpl().checkInternet();
  await CacheHelper.init();

  runApp(const MyApp());

  token = CacheHelper.getData(key: 'token');
  role = CacheHelper.getData(key: 'role');
  userId = CacheHelper.getData(key: 'userId');
  print(token);
  globalDark = CacheHelper.getData(key: 'isDark') ?? false;
  print('globaaaaaaaaaaal$globalDark');
}
