import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:itsale/core/utils/toast.dart';



abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<void> checkInternet();

}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker? connectionChecker;
 // final BuildContext context;
  NetworkInfoImpl({this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker!.hasConnection;

  @override
  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == false) {
     ///
    showToast(text: 'لا يوجد اتصال بالانترنت', state: ToastStates.error);
    }
    }

}
class InternetConnectivityManager {
  final Function onConnectionRestored;
  final Function onConnectionLost;

  InternetConnectivityManager({
    required this.onConnectionRestored,
    required this.onConnectionLost,
  });

  void startMonitoring() {
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          onConnectionRestored();
          break;
        case InternetConnectionStatus.disconnected:
          onConnectionLost();
          break;
      }
    });
  }
}
