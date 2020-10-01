import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:warungislamibogorandroid/penjualan/kasir/tambah_penjualan.dart';

import 'package:http/http.dart' as http;
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'dart:async';

import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:provider/provider.dart';

Customer customerState;
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

  @override
  void initState() {
    _errorMessage = '';
    delayRequest = 0;
    _scaffoldKeyCustomer = GlobalKey<ScaffoldState>();
    _isCari = false;
    _isLoading = true;

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
    KasirBloc bloc = Provider.of<KasirBloc>(context);

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
                  decoration: InputDecoration(hintText: 'Cari Nama/HP/Alamat'),
                  controller: cariController,
                  autofocus: true,
                  focusNode: cariFocus,
                  onChanged: (ini) {
                    setState(() {
                      cariController.value = TextEditingValue(
                        text: ini,
                        selection: cariController.selection,
                      );
                    });
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
                    },
                    icon: Icon(Icons.search),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _isCari = false;
                        cariController.clear();
                      });
                    },
                    icon: Icon(Icons.close),
                  )
          ],
        ),
        body: Scrollbar(
          child: ListView(
              children: bloc.cariCustomer(cariController.text).isEmpty
                  ? [
                      ListTile(
                        title: Text(
                          'Tidak ada Data',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]
                  : bloc
                      .cariCustomer(cariController.text)
                      .map(
                        (e) => Container(
                          margin: EdgeInsets.only(
                            top: 3.0,
                            bottom: 3.0,
                            left: 5.0,
                            right: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: e.idCustomer == customerState.idCustomer
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
                            title: Text(e.namaCustomer),
                            subtitle: Text(e.alamat),
                            trailing: Text(e.noTelp),
                            onTap: () {
                              setState(() {
                                customerState = e;
                                _isCari = false;
                                cariController.clear();
                              });
                              Navigator.pop(context, customerState);
                            },
                          ),
                        ),
                      )
                      .toList()),
        ),
      ),
    );
  }
}
