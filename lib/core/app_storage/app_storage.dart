import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/user_model.dart';

class AppStorage {
  static final GetStorage box = GetStorage();

  static Future<void> init() async => await GetStorage.init();

  static Future<void> cacheUserInfo(UserModel userModel) =>
      box.write('user', userModel.toJson());

  static UserModel? get getUserInfo {
    UserModel? userModel;
    if (box.hasData('user')) {
      userModel = UserModel.fromJson(box.read('user'));
    }
    return userModel;
  }

  static bool get isLogged => getUserInfo != null;

  set saveToken(String? value) {
    value = getUserInfo?.data?.token;
  }

  static String? get getToken => getUserInfo?.data?.token ?? '';

  static User? get getUserData => getUserInfo?.data?.user;

  static Future<void> eraseBox() async {
    await box.erase();
  }
}
