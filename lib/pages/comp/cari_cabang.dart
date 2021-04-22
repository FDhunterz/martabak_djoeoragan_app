import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_bloc.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_model.dart';
import 'dart:async';

import 'package:provider/provider.dart';

Cabang cabangState;
bool _isCari, _isLoading;
List<Cabang> listCabang, listCabangX;

String tokenType, accessToken;
Map<String, String> requestHeaders = Map();

CompBloc bloc;

class CariCabang extends StatefulWidget {
  final Cabang cabang;

  CariCabang({this.cabang});

  @override
  _CariCabangState createState() => _CariCabangState();
}

class _CariCabangState extends State<CariCabang> {
  GlobalKey<ScaffoldState> _scaffoldKeyCabang = GlobalKey<ScaffoldState>();

  FocusNode cariFocus = FocusNode();
  TextEditingController cariController = TextEditingController();

  cariCabang() {}

  getCabang() async {
    setState(() {
      _isLoading = true;
    });

    CompBloc blocX = Provider.of<CompBloc>(context);

    listCabangX = blocX.listCabang;
    listCabang = listCabangX;
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    listCabang = [];
    listCabangX = [];
    // getCabang();

    _isCari = false;
    _isLoading = false;
    // getCabang();
    cabangState = widget.cabang == null
        ? Cabang(
            id: '',
            nama: '',
          )
        : widget.cabang;

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
    bloc = Provider.of<CompBloc>(context);
    List<Cabang> listCabang = bloc.cariCabang(cariController.text);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKeyCabang,
        appBar: AppBar(
          backgroundColor: _isCari ? Colors.white : Colors.orange[300],
          iconTheme: _isCari
              ? IconThemeData(
                  color: Colors.black,
                )
              : null,
          title: _isCari == true
              ? TextField(
                  decoration: InputDecoration(hintText: 'Cari Nama'),
                  controller: cariController,
                  autofocus: true,
                  focusNode: cariFocus,
                  onChanged: (ini) {
                    cariController.value = TextEditingValue(
                      text: ini,
                      selection: cariController.selection,
                    );
                    setState(() {
                      bloc.cariCabang(ini);
                    });
                    // bloc.notifyListeners();
                  },
                )
              : Text('Pilih Cabang'),
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
                        bloc.cariCabang(cariController.text);
                      });
                      // bloc.notifyListeners();
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
                  itemCount: listCabang.length,
                  itemBuilder: (BuildContext context, int i) => Container(
                    child: ListTile(
                      title: Text(
                        listCabang[i].nama,
                        style: TextStyle(
                          color: bloc.selectedCabang != null
                              ? bloc.selectedCabang.id == listCabang[i].id
                                  ? Colors.green
                                  : Colors.black
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          bloc.setSelectedCabang(listCabang[i]);
                        });
                      },
                    ),
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (cabangState != null) {
              Navigator.pop(context, cabangState);
              print('selected');
            } else {
              Fluttertoast.showToast(msg: 'Pilih Cabang terlebih dahulu');
            }
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Kembali'),
        ),
      ),
    );
  }
}
