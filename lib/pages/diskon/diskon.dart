import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/diskon/diskonModel.dart';
import 'package:martabakdjoeragan_app/pages/diskon/diskonTile.dart';
import 'package:martabakdjoeragan_app/pages/diskon/editDiskon.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

GlobalKey<ScaffoldState> _scaffoldKeyDiskon;
List<DiskonModel> _listModel;
bool _isError, _isLoading, _isPressed, _isCari;
String _errorMessage;
Map<String, String> requestHeaders = Map();
Timer _timer;
int _durationSearch;
TextEditingController _cariController;

class ViewDiskon extends StatefulWidget {
  @override
  _ViewDiskonState createState() => _ViewDiskonState();
}

class _ViewDiskonState extends State<ViewDiskon> {
  @override
  void initState() {
    _scaffoldKeyDiskon = GlobalKey<ScaffoldState>();
    _listModel = [];
    _isError = false;
    _isCari = false;
    _isLoading = false;
    _durationSearch = 0;
    _isPressed = false;
    _timer = null;
    _errorMessage = '';
    _cariController = TextEditingController();

    resource();

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  cariDelay() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timex) {
      if (_durationSearch > 0) {
        _durationSearch--;
      } else {
        timex.cancel();
        search();
      }
    });
  }

  search() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await http.post(
        Uri.parse(url + 'penjualan/diskon/search'),
        headers: requestHeaders,
        body: {
          'cari': _cariController.text,
        },
      );

      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        _listModel = [];

        for (var data in responseJson['data1']) {
          _listModel.add(
            DiskonModel(
              id: data['d_id'].toString(),
              akhir: data['d_akhir'],
              kode: data['d_kode'],
              nama: data['d_nama'],
              periode: data['d_periode'].toString(),
              isActive: data['d_isactive'].toString(),
            ),
          );
        }
        setState(() {
          _isError = false;
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali');
        setState(() {
          _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
          _isError = true;
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: 'Error Code : ${response.statusCode}');
        Fluttertoast.showToast(msg: 'Error Code : ${response.body}');
        print(response.body);
        setState(() {
          _isError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  resource() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await http.get(
        Uri.parse(url + 'penjualan/diskon/resource'),
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        _listModel = [];

        for (var data in responseJson['data1']) {
          _listModel.add(
            DiskonModel(
              id: data['d_id'].toString(),
              akhir: data['d_akhir'],
              kode: data['d_kode'],
              nama: data['d_nama'],
              periode: data['d_periode'].toString(),
              isActive: data['d_isactive'].toString(),
            ),
          );
        }
        setState(() {
          _isError = false;
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali');
        setState(() {
          _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
          _isError = true;
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: 'Error Code : ${response.statusCode}');
        print(response.body);
        setState(() {
          _isError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        _isError = true;
        _isLoading = false;
      });
    }
  }

  showModal({
    String nama,
    String id,
    String isActive,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  nama,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      primary: Colors.white,
                    ),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditDiskon(
                            id: id,
                          ),
                        ),
                      );
                      resource();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.edit,
                          size: 16.0,
                        ),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      delete(id);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.close,
                          size: 16.0,
                        ),
                        Text('Delete'),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      aktifNonAktif(
                        id: id,
                        statusAktif: isActive == '1' ? '0' : '1',
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          isActive == '1' ? Icons.close : Icons.check,
                          size: 16.0,
                          color: isActive == '1' ? Colors.red : Colors.green,
                        ),
                        Text(isActive == '1' ? 'Nonaktifkan' : 'Aktifkan'),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  aktifNonAktif({
    String id,
    String statusAktif,
  }) async {
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    try {
      final response = await http.post(
        Uri.parse('${url}penjualan/diskon/status'),
        headers: requestHeaders,
        body: {
          'ids': id.toString(),
          'status': statusAktif.toString(),
        },
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        if (responseJson['status'] == 'success') {
          Fluttertoast.showToast(msg: responseJson['text']);
          Navigator.popUntil(context, ModalRoute.withName('/diskon'));
          resource();
        } else if (responseJson['status'] == 'error') {
          Fluttertoast.showToast(msg: responseJson['text']);
        } else {
          print(responseJson);
          Fluttertoast.showToast(msg: response.body);
        }
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali');
        setState(() {
          _isError = true;
          _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
        });
      } else {
        Fluttertoast.showToast(msg: 'Error Code : ${response.statusCode}');
        setState(() {
          _isError = true;
          _errorMessage = response.body;
        });
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  delete(String id) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            if (_isPressed) {
              return Future.value(false);
            }
            Navigator.pop(context);
            return Future.value(true);
          },
          child: StatefulBuilder(
            builder: (BuildContext context, setState) => AlertDialog(
              title: Text('Peringatan!'),
              content: Text('Apa anda yakin ingin menghapus data ini?'),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _isPressed
                      ? null
                      : () async {
                          setState(() {
                            _isPressed = true;
                          });
                          DataStore dataStore = DataStore();
                          String accessToken =
                              await dataStore.getDataString('access_token');

                          requestHeaders['Accept'] = 'application/json';
                          requestHeaders['Authorization'] =
                              'Bearer $accessToken';
                          try {
                            final response = await http.post(
                              Uri.parse('${url}penjualan/diskon/delete'),
                              body: {
                                'ids': id.toString(),
                              },
                              headers: requestHeaders,
                            );

                            if (response.statusCode == 200) {
                              var responseJson = jsonDecode(response.body);
                              print(responseJson);
                              if (responseJson['status'] == 'success') {
                                resource();
                                Navigator.popUntil(
                                    context, ModalRoute.withName('/diskon'));
                                Fluttertoast.showToast(
                                    msg: 'Data berhasil dihapus');
                              } else if (responseJson['status'] == 'error') {
                                Fluttertoast.showToast(
                                    msg: responseJson['text']);
                              } else {
                                print(responseJson);
                                Fluttertoast.showToast(
                                    msg: responseJson.toString());
                              }

                              setState(() {
                                _isPressed = false;
                              });
                            } else if (response.statusCode == 401) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Token kedaluwarsa, silahkan login kembali');

                              setState(() {
                                _isPressed = false;
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Error Code : ${response.statusCode}');

                              setState(() {
                                _isPressed = false;
                              });
                            }
                          } catch (e) {
                            print(e);

                            setState(() {
                              _isPressed = false;
                            });

                            Fluttertoast.showToast(
                                msg: 'Ada terjadi masalah, silahkan coba lagi');
                          }
                        },
                  child: Text('Ya'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    primary: Colors.black,
                  ),
                  onPressed: _isPressed
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  child: Text('Tidak'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyDiskon,
      appBar: AppBar(
        title: _isCari
            ? TextField(
                controller: _cariController,
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Cari Kode/Nama/Keterangan Diskon'),
                onChanged: (ini) {
                  _cariController.value = TextEditingValue(
                    text: ini,
                    selection: _cariController.selection,
                  );

                  if (_durationSearch > 0) {
                    _timer.cancel();
                  }
                  _durationSearch = 2;
                  cariDelay();
                },
              )
            : Text('Fitur Diskon'),
        backgroundColor: _isCari ? Colors.white : Colors.orange[300],
        actions: <Widget>[
          _isCari
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (_timer != null) {
                      _timer.cancel();
                    }
                    resource();
                    setState(() {
                      _isCari = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      _cariController.text = '';
                      _isCari = true;
                    });
                  },
                )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () async {
          await Navigator.pushNamed(context, '/tambah_diskon');

          resource();
        },
        label: Text('Tambah Diskon'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _isError
              ? ErrorOutputWidget(
                  onPress: () {
                    resource();
                  },
                  errorMessage: _errorMessage,
                )
              : Scrollbar(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      resource();
                      Future.value({});
                    },
                    child: ListView(
                      padding: EdgeInsets.only(
                        bottom: 70.0,
                      ),
                      children: _listModel.map((data) {
                        return DiskonListTile(
                          periode: int.parse(data.periode) >= 0
                              ? '${data.periode} hari lagi'
                              : 'expired',
                          akhir:
                              'Tanggal Akhir : ${DateFormat('dd MMMM y').format(DateTime.parse(data.akhir))}',
                          nama: data.nama,
                          kode: data.kode,
                          isActive: data.isActive,
                          onTap: () {
                            showModal(
                              nama: data.nama,
                              id: data.id,
                              isActive: data.isActive,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
    );
  }
}
