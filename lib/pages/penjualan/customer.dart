import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'dart:async';

import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:provider/provider.dart';

class CariCustomer extends StatefulWidget {
  final Customer customer;

  CariCustomer({Key key, this.customer}) : super(key: key);

  @override
  _CariCustomerState createState() => _CariCustomerState();
}

class _CariCustomerState extends State<CariCustomer> {
  Timer timer;
  int delayRequest;

  Customer customerState;
  bool _isCari;

  String tokenType, accessToken;
  Map<String, String> requestHeaders = Map();
  GlobalKey<ScaffoldState> _scaffoldKeyCustomer = GlobalKey<ScaffoldState>();

  FocusNode cariFocus = FocusNode();
  TextEditingController cariController = TextEditingController();

  @override
  void initState() {
    delayRequest = 0;
    _isCari = false;

    customerState = widget.customer == null
        ? Customer(idCustomer: '', namaCustomer: '')
        : widget.customer;

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    cariController.dispose();
    cariFocus.dispose();
    super.dispose();
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
