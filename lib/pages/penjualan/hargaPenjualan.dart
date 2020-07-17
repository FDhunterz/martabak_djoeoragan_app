// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/hargaPenjualanWidget.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:warungislamibogorandroid/penjualan/kasir/tambah_penjualan.dart';

// import 'package:http/http.dart' as http;
// import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
// import 'package:martabakdjoeragan_app/pages/penjualan/kuponWidget.dart';
// import 'package:martabakdjoeragan_app/store/DataStore.dart';
// import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'dart:async';

import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:provider/provider.dart';

HargaPenjualan hargaPenjualanState;
bool _isCari, _isLoading;

String tokenType, accessToken;
Map<String, String> requestHeaders = Map();
GlobalKey<ScaffoldState> _scaffoldCariHargaPenjualan;

FocusNode cariFocus;
TextEditingController cariController;
KasirBloc bloc;

class CariHargaPenjualan extends StatefulWidget {
  final HargaPenjualan hargaPenjualanX;

  CariHargaPenjualan({
    this.hargaPenjualanX,
  });

  @override
  _CariHargaPenjualanState createState() => _CariHargaPenjualanState();
}

class _CariHargaPenjualanState extends State<CariHargaPenjualan> {
  Timer timer;
  int delayRequest;

  getKuponBelanja() async {
    setState(() {
      _isLoading = true;
    });

    // listHargaPenjualan = bloc.kupon;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    delayRequest = 0;
    _scaffoldCariHargaPenjualan = GlobalKey<ScaffoldState>();
    _isCari = false;
    _isLoading = false;
    // getKuponBelanja();
    hargaPenjualanState = widget.hargaPenjualanX == null
        ? HargaPenjualan(
            id: '',
            nama: '',
          )
        : widget.hargaPenjualanX;

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
    List<HargaPenjualan> listHargaPenjualan;

    listHargaPenjualan = bloc.cariHargaPenjualan(cariController.text);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldCariHargaPenjualan,
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
                      listHargaPenjualan = bloc.cariHargaPenjualan(ini);
                    });
                  },
                )
              : Text('Pilih Golongan Harga'),
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
                        listHargaPenjualan = bloc.listHarga;
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
                  itemCount: listHargaPenjualan.length,
                  itemBuilder: (BuildContext context, int i) => Container(
                    child: HargaPenjualanListTile(
                      hargaPenjualan: listHargaPenjualan[i],
                      onTap: () {
                        bloc.setHargaPenjualan(
                          context: context,
                          hargaX: listHargaPenjualan[i],
                        );
                      },
                    ),
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (hargaPenjualanState != null) {
              Navigator.pop(context, hargaPenjualanState);
              print('selected');
            } else {
              // Fluttertoast.showToast(msg: 'Pilih KuponBelanja terlebih dahulu');
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Kembali'),
        ),
      ),
    );
  }
}
