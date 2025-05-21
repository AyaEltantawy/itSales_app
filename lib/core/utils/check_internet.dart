import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/core/routes/magic_router.dart';
import 'package:itsale/core/utils/snack_bar.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<void> checkInternet();
}

BuildContext? currentContext = navigatorKey.currentContext; // Make it nullable.

// class NetworkInfoImpl implements NetworkInfo {
//   final InternetConnectionChecker? connectionChecker;
//
//   NetworkInfoImpl({this.connectionChecker});
//
//   @override
//   Future<bool> get isConnected => connectionChecker!.hasConnection;
//
//   @override
// Future<void> checkInternet() async {
//   bool result = await InternetConnectionChecker().hasConnection;
//   if (result == false) {
//     // Check if context is available.
//     if (currentContext != null) {
//       Utils.showSnackBar(currentContext!, "لا يوجد اتصال بالانترنت");
//     } else {
//       // Fallback in case context is not available
//       print('No context available to show the snackbar');
//     }
//   }
// }
//}

//class InternetConnectivityManager {
  //final Function onConnectionRestored;
  //final Function onConnectionLost;

  // InternetConnectivityManager({
  //   required this.onConnectionRestored,
  //   required this.onConnectionLost,
  // });

//   void startMonitoring() {
//     InternetConnectionChecker().onStatusChange.listen((status) {
//       switch (status) {
//         case InternetConnectionStatus.connected:
//           onConnectionRestored();
//           break;
//         case InternetConnectionStatus.disconnected:
//           onConnectionLost();
//           break;
//       }
//     });
//   }
// }
