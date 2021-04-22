import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/core/storage.dart';
import 'package:martabakdjoeragan_app/pages/CekKoneksi/cek_koneksi.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';

class CustomSendRequest {
  CustomSendRequest._internal();

  static final CustomSendRequest _initialize = CustomSendRequest._internal();

  static CustomSendRequest get initialize => _initialize;

  /// # Send Request Tipe POST
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
  /// [onErrorCatch] = ketika terjadi error di `try {} catch {}.`
  ///
  /// [onUseLocalFile] = ketika [isOnline] false. maka menjalankan function ini.
  ///
  /// [onSuccess] = ketika selesai send request status 200.
  void post(
    String url, {
    Map body,
    Map headers,
    bool isOnline,
    String namaFile,
    Function onBeforeSend,
    Function onComplete,
    Function(int, String) onUnknownStatusCode,
    Function(String) onErrorCatch,
    Function(String) onUseLocalFile,
    Function(String) onSuccess,
  }) async {
    onBeforeSend();
    PenyimpananKu storage = PenyimpananKu();
    // storage.hapusBerkas(namaFile);
    String resourceJson = await storage.bacaBerkas(namaFile);
    try {
      CekKoneksi _cekKoneksi = CekKoneksi.instance;

      Connectivity _connectivity = _cekKoneksi.connectivity;

      ConnectivityResult konekResult = await _connectivity.checkConnectivity();

      Map _hasil = await _cekKoneksi.checkStatus(konekResult);

      if (!_hasil['isOnline']) {
        onUseLocalFile(resourceJson);
        onComplete();
      } else {
        final response = await http.post(
          Uri.parse('$url'),
          headers: headers,
          body: body,
        );

        if (response.statusCode == 200) {
          onSuccess(response.body);
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: 'Token kedaluwarsa, silahkan login kembali');
          onUseLocalFile(resourceJson);
        } else {
          onUnknownStatusCode(response.statusCode, response.body);
          onUseLocalFile(resourceJson);
        }
        onComplete();
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

  /// # Send Request Tipe GET
  ///
  /// [url] = nama url.
  ///
  /// [body] = params send request.
  ///
  /// [headers] = headers send request.
  ///
  /// [namaFile] = nama file untuk offline mode. ex: folder/namaFile.txt | namaFile.txt
  ///
  /// [onBeforeSend] = sebelum melakukan send request.
  ///
  /// [onComplete] = ketika selesai melakukan send request.
  ///
  /// [onUnknownStatusCode] = ketika selesai send request status tidak diketahui.
  ///
  /// [onErrorCatch] = ketika terjadi error di `try {} catch {}.`
  ///
  /// [onUseLocalFile] = ketika [isOnline] false. maka menjalankan function ini.
  ///
  /// [onSuccess] = ketika selesai send request status 200.
  void get(
    String url, {
    Map body,
    Map headers,
    String namaFile,
    Function onBeforeSend,
    Function onComplete,
    Function(int, String) onUnknownStatusCode,
    Function(String) onErrorCatch,
    Function(String) onUseLocalFile,
    Function(String) onSuccess,
  }) async {
    onBeforeSend();

    PenyimpananKu storage = PenyimpananKu();
    // storage.hapusBerkas(namaFile);
    String resourceJson = await storage.bacaBerkas(namaFile);

    CekKoneksi _cekKoneksi = CekKoneksi.instance;

    Connectivity _connectivity = _cekKoneksi.connectivity;
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

      ConnectivityResult konekResult = await _connectivity.checkConnectivity();

      Map _hasil = await _cekKoneksi.checkStatus(konekResult);

      if (_hasil['isOnline']) {
        final response = await http.get(
          Uri.parse('$url$form'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          onSuccess(response.body);
        } else if (response.statusCode == 401) {
          Fluttertoast.showToast(
              msg: 'Token kedaluwarsa, silahkan login kembali');
          onUseLocalFile(resourceJson);
        } else {
          onUnknownStatusCode(response.statusCode, response.body);
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

/// simpan Nota offline ke Server
///
/// [onOnlyOnce] agar mengirim simpanNotaOfflineKeServer() tidak berkali-kali
/// ```
/// onOnlyOnce:(ini){
///
///   setState((){
///     otherBoolean = ini;
///   });
/// }
/// ```
void simpanNotaOfflineKeServer(
  BuildContext context, {
  Function(bool) onOnlyOnce,
}) async {
  try {
    DataStore dataStore = DataStore();

    Map<String, String> requestHeaders = Map();

    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    PenyimpananKu store = PenyimpananKu();

    String namaFile = 'simpan-kasir.json';

    // await store.hapusBerkas(namaFile);
    String encodedNotaOffline = await store.bacaBerkas(namaFile);

    if (encodedNotaOffline.isNotEmpty) {
      print('nota offline ada');
      final response = await http.post(
        Uri.parse('${url}penjualan/kasir/sync'),
        headers: requestHeaders,
        body: {
          'platform': 'android',
          'data': encodedNotaOffline,
        },
      );

      if (response.statusCode == 200) {
        Map jsonDecoded = jsonDecode(response.body);

        if (jsonDecoded.containsKey('status')) {
          if (jsonDecoded['status'] == 'success') {
            store.tulisBerkas('', namaFile);
            Fluttertoast.showToast(
                msg: 'Nota Offline berhasil disimpan ke Server');
          } else if (jsonDecoded['status'] == 'error') {
            Fluttertoast.showToast(msg: jsonDecoded['text']);
            showError(
              context: context,
              errorMessage: jsonDecoded['text'],
              onTryAgain: () {
                simpanNotaOfflineKeServer(context);
                Navigator.pop(context);
              },
            );
          } else {
            print(jsonDecoded);
            Fluttertoast.showToast(msg: 'Send Request Done');
          }
        } else {
          print(jsonDecoded);
          Fluttertoast.showToast(msg: 'Send Request Done');
        }
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali');
      } else {
        Fluttertoast.showToast(
            msg:
                'Simpan Nota Offline ke Server gagal, Error Code ${response.statusCode}');
        showError(
          context: context,
          errorMessage: response.body,
          onTryAgain: () {
            simpanNotaOfflineKeServer(context);
            Navigator.pop(context);
          },
        );
      }
    } else {
      print('nota offline kosong');
    }
  } catch (e) {
    print(e);
    Fluttertoast.showToast(msg: 'Simpan Nota Offline gagal!');
    showError(
      context: context,
      errorMessage: e.toString(),
      onTryAgain: () {
        simpanNotaOfflineKeServer(context);
        Navigator.pop(context);
      },
    );
  }
}

/// jangan lupa di function `onTryAgain`:
/// ```
/// onTryAgain:(){
///   // # some code
///   Navigator.pop(context);
/// }
/// ```
void showError({
  BuildContext context,
  String errorMessage,
  Function onTryAgain,
}) {
  showDialog(
    context: context,
    builder: (BuildContext contextX) => AlertDialog(
      title: Text('Error'),
      content: Scrollbar(
        child: SingleChildScrollView(
          child: Text(errorMessage),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Coba Lagi'),
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
            onPrimary: Colors.white,
          ),
          onPressed: onTryAgain,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
          ),
          child: Text('Tutup'),
          onPressed: () {
            Navigator.pop(contextX);
          },
        ),
      ],
    ),
  );
}
