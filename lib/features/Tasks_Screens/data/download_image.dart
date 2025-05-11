import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:itsale/core/utils/toast.dart';
Future<void> downloadImage(String url, String fileName) async {
  try {
    //
    // if (!status.isGranted) {
    //   throw Exception("Storage permission not granted");
    // }

    // Get the directory for storing the image
    Directory appDir = await getApplicationDocumentsDirectory();
    String savePath = "${appDir.path}/$fileName";

    Dio dio = Dio();
    await dio.download(url, savePath);

    showToast(text: 'تم الحفظ في المعرض', state: ToastStates.success);
  } catch (e) {
    showToast(text: 'عفوا حاول مرة اخرى', state: ToastStates.error);


  }
}
