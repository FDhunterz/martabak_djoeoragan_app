import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
// ignore: unused_import
import 'package:fluttertoast/fluttertoast.dart';
// ignore: unused_import
import 'package:martabakdjoeragan_app/core/env.dart';

class CekKoneksi {
  ///   The _internal construction is just a name often given to constructors that are private
  /// to the class (the name is not required to be ._internal
  /// you can create a private constructor using any Class._someName construction).
  CekKoneksi._internal();

  static final CekKoneksi _instance = CekKoneksi._internal();

  static CekKoneksi get instance => _instance;

  Connectivity connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> subscription;
  StreamController controller;

  Stream get myStream => controller.stream;

  void initialise() async {
    // ConnectivityResult result = await connectivity.checkConnectivity();
    // checkStatus(result);
    subscription = connectivity.onConnectivityChanged.listen((result) {
      checkStatus(result);
    });
    controller = StreamController.broadcast();
  }

  void disposeConnectivity() => subscription.cancel();

  Future<Map> checkStatus(ConnectivityResult resultX) async {
    bool isOnline = false;
    String message = 'Mode Offline';
    try {
      // final result = await InternetAddress.lookup(noapiurl);
      final result = await InternetAddress.lookup('alamraya.site');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
        message = 'Mode Online';
      } else
        isOnline = false;
    } on SocketException catch (_) {
      isOnline = false;
    }
    Map hasil = {
      'type': resultX,
      'isOnline': isOnline,
      'message': message,
    };

    if (!controller.isClosed) {
      controller.sink.add(
        hasil,
      );
    }

    return hasil;
  }

  void disposeStream() => controller.close();
}

class TipeKoneksi {
  ConnectivityResult tipe;
  bool isOnline;

  TipeKoneksi({
    this.tipe,
    this.isOnline,
  });
}
