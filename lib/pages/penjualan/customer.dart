import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:warungislamibogorandroid/penjualan/kasir/tambah_penjualan.dart';

import 'package:http/http.dart' as http;
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'dart:async';

import 'package:martabakdjoeragan_app/utils/martabakModel.dart';

Customer customerState;
List<Customer> listCustomer, listCustomerX;
bool _isCari, _isLoading, _isError;

String tokenType, accessToken, _errorMessage, _perusahaan;
Map<String, String> requestHeaders = Map();
GlobalKey<ScaffoldState> _scaffoldKeyCustomer;

FocusNode cariFocus;
TextEditingController cariController;

class CariCustomer extends StatefulWidget {
  final Customer customer;

  CariCustomer({this.customer});

  @override
  _CariCustomerState createState() => _CariCustomerState();
}

class _CariCustomerState extends State<CariCustomer> {
  Timer timer;
  int delayRequest;

  getUserCabang() async {
    DataStore dataStore = DataStore();
    int perusaahan = await dataStore.getDataInteger('us_perusahaan');

    _perusahaan = perusaahan.toString();
  }

  cariCustomer() {
    listCustomer = listCustomerX;

    List<Customer> cs = List<Customer>();

    for (var data in listCustomer) {
      if (data.namaCustomer
              .toLowerCase()
              .contains(cariController.text.toLowerCase()) ||
          data.alamat
              .toLowerCase()
              .contains(cariController.text.toLowerCase()) ||
          data.noTelp
              .toLowerCase()
              .contains(cariController.text.toLowerCase())) {
        cs.add(data);
      }
    }

    setState(() {
      listCustomer = cs;
    });
  }

  getCustomer() async {
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    setState(() {
      _isLoading = true;
      _isError = false;
    });
    String link = '${url}penjualan/kasir/resource?cabangs=$_perusahaan';
    print(link);
    try {
      final response = await http.get(
        link,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        print(responseJson);

        listCustomer = List<Customer>();

        for (var i in responseJson['customer']) {
          listCustomer.add(
            Customer(
              idCustomer: i['id'].toString(),
              namaCustomer: i['nama'],
              noTelp: i['text'],
              alamat: i['alamat'],
            ),
          );
        }

        listCustomerX = listCustomer;

        setState(() {
          _isLoading = false;
          _isError = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
          msg: 'Token kedaluwarsa, silahkan login kembali',
        );
        setState(() {
          _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
          _isLoading = false;
          _isError = true;
        });
      } else {
        Fluttertoast.showToast(msg: 'Error Code = ${response.statusCode}');
        Map responseJson = jsonDecode(response.body);

        if (responseJson.containsKey('message')) {
          Fluttertoast.showToast(msg: responseJson['message']);
        }
        print(jsonDecode(response.body));
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = response.body;
        });
      }
    } catch (e, stacktrace) {
      print('Error = $e || Stacktrace = $stacktrace');
      Fluttertoast.showToast(msg: 'Error = ${e.toString()}');
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
        _isError = true;
      });
    }
  }

  @override
  void initState() {
    getUserCabang();
    _errorMessage = '';
    delayRequest = 0;
    _scaffoldKeyCustomer = GlobalKey<ScaffoldState>();
    _isCari = false;
    _isLoading = true;
    getCustomer();
    customerState = widget.customer == null
        ? Customer(idCustomer: '', namaCustomer: '')
        : widget.customer;

    cariFocus = FocusNode();
    cariController = TextEditingController();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKeyCustomer,
        appBar: AppBar(
          backgroundColor: _isCari ? Colors.white : Colors.orange[300],
          iconTheme: _isCari
              ? IconThemeData(
                  color: Colors.black,
                )
              : null,
          title: _isCari == true
              ? TextField(
                  decoration:
                      InputDecoration(hintText: 'Cari Nama/HP/Alamat'),
                  controller: cariController,
                  autofocus: true,
                  focusNode: cariFocus,
                  onChanged: (ini) {
                    cariController.value = TextEditingValue(
                      text: ini,
                      selection: cariController.selection,
                    );

                    cariCustomer();
                  },
                )
              : Text(customerState != null ? customerState.namaCustomer : ''),
          actions: <Widget>[
            _isCari == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isCari = true;
                        cariController.clear();
                      });

                      Future.delayed(
                        Duration(
                          milliseconds: 200,
                        ),
                        () => FocusScope.of(context).requestFocus(cariFocus),
                      );
                    },
                    icon: Icon(Icons.search),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _isCari = false;
                        cariController.clear();
                        listCustomer = listCustomerX;
                      });
                    },
                    icon: Icon(Icons.close),
                  )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _isError
                ? ErrorOutputWidget(
                    onPress: () => getCustomer(),
                    errorMessage: _errorMessage,
                  )
                : Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: () => getCustomer(),
                      child: ListView.builder(
                        itemCount: listCustomer.length,
                        itemBuilder: (BuildContext context, int i) => Container(
                          margin: EdgeInsets.only(
                            top: 3.0,
                            bottom: 3.0,
                            left: 5.0,
                            right: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: listCustomer[i].idCustomer ==
                                    customerState.idCustomer
                                ? Colors.green[100].withOpacity(0.5)
                                : Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                                color: Colors.grey.withOpacity(0.2),
                                offset: Offset(1.0, 1.0),
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: Icon(FontAwesomeIcons.user),
                            title: Text(listCustomer[i].namaCustomer),
                            subtitle: Text(listCustomer[i].alamat),
                            trailing: Text(listCustomer[i].noTelp),
                            onTap: () {
                              if (_isCari) {
                                getCustomer();
                              }
                              setState(() {
                                customerState = listCustomer[i];
                                _isCari = false;
                                cariController.clear();
                              });
                              Navigator.pop(context, customerState);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     if (customerState != null) {
        //       Navigator.pop(context, customerState);
        //     } else {
        //       showInSnackBarCustomer('Pilih Customer terlebih dahulu');
        //     }
        //   },
        //   child: Icon(Icons.check),
        // ),
      ),
    );
  }
}
