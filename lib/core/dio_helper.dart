import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:itsale/core/cache_helper/cache_helper.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/core/utils/snack_bar.dart';
import 'package:itsale/core/utils/token.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_storage/app_storage.dart';

class DioHelper {
  static const _baseUrl = 'https://eby-itsales.guessitt.com/public/itsales/';
  static Dio dioSingleton = Dio()..options.baseUrl = _baseUrl;

  static Future<Response<dynamic>> post(String path, bool isAuh,
      {FormData? formData,
        encoding,
        Map<String, dynamic>? body,
        Function(int, int)? onSendProgress}) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      Utils.showSnackBar(MagicRouter.currentContext!,
          'You are disconnected from the internet');
      throw Exception("No internet connection");
    }

    dioSingleton.options.headers =
    isAuh ? {'Authorization': "Token$token"} : null;
    print('POST path: $path');
    print("Token: $token");

    final response = await dioSingleton.post(path,
        data: formData ?? (body == null ? null : FormData.fromMap(body)),
        options: Options(
            requestEncoder: encoding,
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
              'Accept-Language': 'en/ar',
            },
            followRedirects: false,
            contentType: Headers.formUrlEncodedContentType,
            receiveDataWhenStatusError: true,
            sendTimeout: const Duration(seconds: 10),
            validateStatus: (status) => status! < 500),
        onSendProgress: onSendProgress);

    print("POST response: $response");
    return response;
  }

  static Future<Response<dynamic>> put(String path, bool isAuh,
      {FormData? formData,
        Map<String, dynamic>? body,
        Function(int, int)? onSendProgress}) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      Utils.showSnackBar(MagicRouter.currentContext!,
          'You are disconnected from the internet');
      throw Exception("No internet connection");
    }

    dioSingleton.options.headers =
    isAuh ? {'Authorization': 'Bearer ${AppStorage.getToken}'} : null;

    final response = await dioSingleton.put(path,
        data: formData ?? FormData.fromMap(body!),
        options: Options(
            headers: {
              'Authorization': 'Bearer ${AppStorage.getToken}',
              'Accept': 'application/json',
            },
            followRedirects: false,
            receiveDataWhenStatusError: true,
            validateStatus: (status) => status! < 500),
        onSendProgress: onSendProgress);

    return response;
  }

  static Future<Response<dynamic>> patch(String path, bool isAuh,
      {FormData? formData,
        Map<String, dynamic>? body,
        Function(int, int)? onSendProgress}) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      Utils.showSnackBar(MagicRouter.currentContext!,
          'You are disconnected from the internet');
      throw Exception("No internet connection");
    }

    dioSingleton.options.headers =
    isAuh ? {'Authorization': 'Bearer ${token}'} : null;

    final response = await dioSingleton.patch(path,
        data: body,
        options: Options(
            headers: {
              'Authorization': 'Bearer ${token}',
              'Accept': 'application/json',
            },
            followRedirects: false,
            receiveDataWhenStatusError: true,
            validateStatus: (status) => status! < 500),
        onSendProgress: onSendProgress);

    print("PATCH response: $response");
    return response;
  }

  static Future<Response<dynamic>> delete(
      String path, {
        Map<String, dynamic>? body,
      }) {
    try {
      dioSingleton.options.headers = {
        'Authorization': 'Bearer ${AppStorage.getToken}'
      };
      final response = dioSingleton.delete(
        path,
        data: body,
        options: Options(
            headers: {
              'Authorization': 'Bearer ${AppStorage.getToken}',
              'Accept': 'application/json'
            },
            followRedirects: false,
            validateStatus: (status) => status! < 500),
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  static Future<Response<dynamic>>? get(String path, {dynamic body}) async {
    if (AppStorage.isLogged) {
      bool result = await InternetConnectionChecker().hasConnection;
      if (!result) {
        Utils.showSnackBar(MagicRouter.currentContext!,
            'You are disconnected from the internet');
        throw Exception("No internet connection");
      }

      dioSingleton.options.headers = {
        'Authorization': 'Bearer ${AppStorage.getToken}',
        'Accept': 'application/json',
      };
    }

    print(dioSingleton.options.headers);
    final response = await dioSingleton.get(path,
        queryParameters: body,
        options: Options(
          // You can set timeouts here if needed
        ));

    dioSingleton.options.headers = null;
    return response;
  }

  static Future<void>? launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}
