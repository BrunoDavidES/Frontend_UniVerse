
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

/*class ConnectivityChecker {

  ConnectivityChecker._();
  static final _instance = ConnectivityChecker._();
  static ConnectivityChecker get instance => _instance;
  final _networkConnectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;
  // 1.
  void initialise() async {
  ConnectivityResult result = await _networkConnectivity.checkConnectivity();
  _checkStatus(result);
  _networkConnectivity.onConnectivityChanged.listen((result) {
  print(result);
  _checkStatus(result);
  });
  }
// 2.
  void _checkStatus(ConnectivityResult result) async {
  bool isOnline = false;
  try {
  final result = await InternetAddress.lookup('google.com');
  isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
  isOnline = false;
  }
  _controller.sink.add({result: isOnline});
  }
  void disposeStream() => _controller.close();
}*/

class ConnectivityChecker {
  ConnectivityChecker._();

  static final _instance = ConnectivityChecker._();
  static ConnectivityChecker get instance => _instance;
  final _connectivity = Connectivity();
  final _controller = StreamController.broadcast();
  Stream get myStream => _controller.stream;

  void initialize() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    _checkStatus(result);
    _connectivity.onConnectivityChanged.listen((result) {
      _checkStatus(result);
    });
  }

  void _checkStatus(ConnectivityResult result) async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      isOnline = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch(_) {
      isOnline = false;
    }
    _controller.sink.add({result: isOnline});
  }

  void disposeStream() => _controller.close();

}