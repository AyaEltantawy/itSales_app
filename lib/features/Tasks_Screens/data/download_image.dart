import 'dart:io';

import 'package:itsale/core/routes/magic_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:itsale/core/utils/snack_bar.dart';
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

    Utils.showSnackBar(MagicRouter.currentContext, 'تم الحفظ في المعرض', );
  } catch (e) {
    Utils.showSnackBar(MagicRouter.currentContext ,'عفوا حاول مرة اخرى',);


  }
}
