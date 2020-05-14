// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:warungislamibogorandroid/penjualan/kasir/tambah_penjualan.dart';

// import 'package:http/http.dart' as http;
// import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kuponWidget.dart';
// import 'package:martabakdjoeragan_app/store/DataStore.dart';
// import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'dart:async';

import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:provider/provider.dart';

KuponBelanja kuponState;
bool _isCari, _isLoading;

String tokenType, accessToken;
Map<String, String> requestHeaders = Map();
GlobalKey<ScaffoldState> _scaffoldKeyKuponBelanja;

FocusNode cariFocus;
TextEditingController cariController;
KasirBloc bloc;

class CariKupon extends StatefulWidget {
  final KuponBelanja kupon;

  CariKupon({this.kupon});

  @override
  _CariKuponState createState() => _CariKuponState();
}

class _CariKuponState extends State<CariKupon> {
  Timer timer;
  int delayRequest;

  cariKuponBelanja() {}

  getKuponBelanja() async {
    setState(() {
      _isLoading = true;
    });

    // listKuponBelanja = bloc.kupon;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    delayRequest = 0;
    _scaffoldKeyKuponBelanja = GlobalKey<ScaffoldState>();
    _isCari = false;
    _isLoading = false;
    // getKuponBelanja();
    kuponState = widget.kupon == null
        ? KuponBelanja(
            id: '',
            nama: '',
          )
        : widget.kupon;

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
    bloc = Provider.of<KasirBloc>(context);
    List<KuponBelanja> listKuponBelanja;

    listKuponBelanja = bloc.cariKupon(cariController.text);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKeyKuponBelanja,
        appBar: AppBar(
          backgroundColor: _isCari ? Colors.white : Colors.orange[300],
          iconTheme: _isCari
              ? IconThemeData(
                  color: Colors.black,
                )
              : null,
          title: _isCari == true
              ? TextField(
                  decoration: InputDecoration(
                      hintText: 'Cari Nama/Nominal/Persen/Catatan'),
                  controller: cariController,
                  autofocus: true,
                  focusNode: cariFocus,
                  onChanged: (ini) {
                    cariController.value = TextEditingValue(
                      text: ini,
                      selection: cariController.selection,
                    );
                    setState(() {
                      listKuponBelanja = bloc.cariKupon(ini);
                    });
                  },
                )
              : Text(kuponState != null ? kuponState.nama : ''),
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
                      KasirBloc bloc = Provider.of<KasirBloc>(context);
                      setState(() {
                        _isCari = false;
                        cariController.clear();
                        listKuponBelanja = bloc.kupon;
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
            : Scrollbar(
                child: ListView.builder(
                  itemCount: listKuponBelanja.length,
                  itemBuilder: (BuildContext context, int i) => Container(
                    child: KuponListTile(
                      persen: listKuponBelanja[i].dPersen,
                      nama: listKuponBelanja[i].nama,
                      catatan: listKuponBelanja[i].catatan,
                      maxDiskon: listKuponBelanja[i].dMaxDiskon,
                      isDouble: listKuponBelanja[i].dIsDouble,
                      selected: listKuponBelanja[i].selected,
                      disabled: listKuponBelanja[i].disabled,
                      nominal: listKuponBelanja[i].nominal,
                      onTap: () {
                        if (listKuponBelanja[i].disabled != '1') {
                          bloc.updateKupon(listKuponBelanja[i]);
                        }
                      },
                    ),
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (kuponState != null) {
              Navigator.pop(context, kuponState);
              print('selected');
            } else {
              Fluttertoast.showToast(msg: 'Pilih KuponBelanja terlebih dahulu');
            }
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Kembali'),
        ),
      ),
    );
  }
}
