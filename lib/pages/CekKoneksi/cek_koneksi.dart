import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
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

  StreamController controller = StreamController.broadcast();

  Stream get myStream => controller.stream;

  void initialise() async {
    // ConnectivityResult result = await connectivity.checkConnectivity();
    // checkStatus(result);
    connectivity.onConnectivityChanged.listen((result) {
      checkStatus(result);
    });
  }

  Future<Map> checkStatus(ConnectivityResult result) async {
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
      'type': result,
      'isOnline': isOnline,
    };
    Fluttertoast.showToast(msg: message);

    controller.sink.add(
      hasil,
    );

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
