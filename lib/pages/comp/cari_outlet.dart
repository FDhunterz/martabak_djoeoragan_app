import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_bloc.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_model.dart';
import 'dart:async';

import 'package:provider/provider.dart';

Outlet outletState;
bool _isCari, _isLoading;
List<Outlet> listOutlet, listOutletX;

String tokenType, accessToken;
Map<String, String> requestHeaders = Map();

FocusNode cariFocus;
TextEditingController cariController;
CompBloc bloc;

class CariOutlet extends StatefulWidget {
  final Outlet outlet;

  CariOutlet({this.outlet});

  @override
  _CariOutletState createState() => _CariOutletState();
}

class _CariOutletState extends State<CariOutlet> {
  GlobalKey<ScaffoldState> _scaffoldKeyOutlet = GlobalKey<ScaffoldState>();

  Timer timer;
  int delayRequest;

  cariOutlet() {}

  getOutlet() async {
    setState(() {
      _isLoading = true;
    });

    CompBloc blocX = Provider.of<CompBloc>(context);

    listOutletX = blocX.listOutlet(filterByCabang: blocX.selectedCabang);
    listOutlet = listOutletX;
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    listOutlet = List<Outlet>();
    listOutletX = List<Outlet>();
    // getOutlet();
    delayRequest = 0;
    _isCari = false;
    _isLoading = false;
    // getOutlet();
    outletState = widget.outlet == null
        ? Outlet(
            id: '',
            nama: '',
          )
        : widget.outlet;

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
    bloc = Provider.of<CompBloc>(context);
    List<Outlet> listOutlet = bloc.cariOutlet(
      cariController.text,
      filterByCabang: bloc.selectedCabang,
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKeyOutlet,
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
                    setState(() {
                      cariController.value = TextEditingValue(
                        text: ini,
                        selection: cariController.selection,
                      );
                    });
                  },
                )
              : Text('Pilih Outlet'),
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
                  itemCount: listOutlet.length,
                  itemBuilder: (BuildContext context, int i) => Container(
                    child: ListTile(
                      title: Text(
                        listOutlet[i].nama,
                        style: TextStyle(
                          color: bloc.selectedOutlet != null
                              ? bloc.selectedOutlet.id == listOutlet[i].id
                                  ? Colors.green
                                  : Colors.black
                              : Colors.black,
                        ),
                      ),
                      onTap: () async {
                        bloc.setSelectedOutlet(listOutlet[i]);
                        Navigator.pop(context, outletState);
                      },
                    ),
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (outletState != null) {
              Navigator.pop(context, outletState);
              print('selected');
            } else {
              Fluttertoast.showToast(msg: 'Pilih Outlet terlebih dahulu');
            }
          },
          icon: Icon(Icons.arrow_back),
          label: Text('Kembali'),
        ),
      ),
    );
  }
}
