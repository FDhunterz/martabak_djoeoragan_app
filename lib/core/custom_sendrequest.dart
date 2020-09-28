import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:martabakdjoeragan_app/core/storage.dart';
import 'package:martabakdjoeragan_app/pages/CekKoneksi/cek_koneksi.dart';

class CustomSendRequest {
  CustomSendRequest._internal();

  static final CustomSendRequest _initialize = CustomSendRequest._internal();

  static CustomSendRequest get initialize => _initialize;

  /// send request tipe POST
  void post(
    String url, {
    Map body,
    Map headers,
    bool isOnline,
    Function onBeforeSend,
    Function onComplete,
    Function onError,
    Function(String) onUseLocalFile,
    Function(String) onSuccess,
  }) async {
    try {} catch (e) {
      print(e);
    }
  }

  /// # Send Request Tipe GET
  ///
  /// [url] = nama url.
  ///
  /// [body] = params send request.
  ///
  /// [headers] = headers send request.
  ///
  /// [isOnline] = bool.
  ///
  /// [namaFile] = nama file untuk offline mode. ex: folder/namaFile.txt | namaFile.txt
  ///
  /// [onBeforeSend] = sebelum melakukan send request.
  ///
  /// [onComplete] = ketika selesai melakukan send request.
  ///
  /// [onUnknownStatusCode] = ketika selesai send request status tidak diketahui.
  ///
  /// [onErrorCatch] = ketika terjadi error di try {} catch {}.
  ///
  /// [onUseLocalFile] = ketika [isOnline] false. maka menjalankan function ini.
  ///
  /// [onSuccess] = ketika selesai send request status 200.
  void get(
    String url, {
    Map body,
    Map headers,
    bool isOnline,
    String namaFile,
    Function onBeforeSend,
    Function onComplete,
    Function(int) onUnknownStatusCode,
    Function(String) onErrorCatch,
    Function(String) onUseLocalFile,
    Function(String) onSuccess,
  }) async {
    PenyimpananKu storage = PenyimpananKu();
    // storage.hapusBerkas(namaFile);
    String resourceJson = await storage.bacaBerkas(namaFile);
    try {
      /// membuat @params untuk send request tipe GET
      String form = '';
      if (body != null) {
        for (int i = 0; i < body.keys.toList().length; i++) {
          var key = body.keys.toList()[i];
          var value = body.values.toList()[i];

          if (i == 0) {
            form += '?$key=$value';
          } else {
            form += '&$key=$value';
          }
        }
      }
      print(form);

      CekKoneksi _cekKoneksi = CekKoneksi.instance;

      Connectivity _connectivity = _cekKoneksi.connectivity;

      Map _hasil = await _cekKoneksi
          .checkStatus(await _connectivity.checkConnectivity());

      if (_hasil['isOnline']) {
        final response = await http.get(
          '$url$form',
          headers: headers,
        );

        if (response.statusCode == 200) {
          onSuccess(response.body);
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: 'Token kedaluwarsa, silahkan login kembali');
          onUseLocalFile(resourceJson);
        } else {
          onUnknownStatusCode(response.statusCode);
          onUseLocalFile(resourceJson);
        }
        onComplete();
      } else {
        onUseLocalFile(resourceJson);
      }
    } on SocketException {
      Fluttertoast.showToast(
          msg: 'Tidak dapat mengakses ke server, silahkan coba lagi');
      onUseLocalFile(resourceJson);
    } catch (e) {
      print(e);
      onUseLocalFile(resourceJson);
      onErrorCatch(e.toString());
    }
  }
}
