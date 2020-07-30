import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/core/api.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
// import 'package:martabakdjoeragan_app/pages/comp/cari_cabang.dart';
import 'package:martabakdjoeragan_app/pages/comp/cari_outlet.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_bloc.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_loading.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_model.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

bool _isError, _isLoading;
String _errorMessage;
String comp = 'Tidak ditemukan';
Map<String, String> requestHeaders = Map();

class PilihCabangOutlet extends StatefulWidget {
  @override
  PilihCabangOutletState createState() => PilihCabangOutletState();
}

class PilihCabangOutletState extends State<PilihCabangOutlet> {
  GlobalKey<ScaffoldState> _scaffoldKeyComp = GlobalKey<ScaffoldState>();

  void getResource() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    comp = await dataStore.getDataString('comp');
    // CompBloc bloc = Provider.of<CompBloc>(context);
    // String compX = bloc.selectedOutlet != null
    //     ? bloc.selectedOutlet.id
    //     : 'Tidak ditemukan';

    try {
      final response = await http.get(
        '${url}setting/session/resource',
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        print(responseJson);

        CompBloc bloc = Provider.of<CompBloc>(context);

        bloc.clearListCabang();
        bloc.clearListOutlet();

        for (var c in responseJson['cabang']) {
          bloc.addCabang(
            Cabang(
              id: c['id'].toString(),
              nama: c['text'],
            ),
          );
        }

        for (var o in responseJson['outlet']) {
          bloc.addOutlet(
            Outlet(
              id: o['id'].toString(),
              nama: o['text'],
              idCabang: o['o_perusahaan'].toString(),
            ),
          );
        }

        if (bloc.selectedCabang == null) {
          bloc.setSelectedCabang(
            Cabang(
              id: responseJson['cabang_pegawai']['p_id'].toString(),
              nama: responseJson['cabang_pegawai']['p_nama'],
            ),
          );
        }

        setState(() {
          _isLoading = false;
          _isError = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token Kedaluwarsa, silahkan login kembali');
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = 'Token Kedaluwarsa, silahkan login kembali';
        });
      } else {
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = response.body;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isError = true;
        _isLoading = false;
      });
      Fluttertoast.showToast(msg: e.toString());
      print(e);
    }
  }

  @override
  void initState() {
    _isLoading = true;
    _isError = false;
    comp = null;
    getResource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CompBloc bloc = Provider.of<CompBloc>(context);
    return Scaffold(
      key: _scaffoldKeyComp,
      appBar: AppBar(
        title: Text('Setting Session'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await Auth().logout(context);
            },
            textColor: Colors.white,
            icon: Icon(Icons.exit_to_app),
            label: Text('Logout'),
          ),
        ],
      ),
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                if (bloc.selectedOutlet != null) {
                  DataStore store = DataStore();
                  store.setDataString('comp', bloc.selectedOutlet.id);
                  Navigator.pushReplacementNamed(context, '/pos');
                } else {
                  Fluttertoast.showToast(msg: 'Pilih Outlet terlebih dahulu');
                }
              },
              label: Text('Simpan Informasi'),
              icon: Icon(Icons.save),
              backgroundColor: Colors.teal,
            ),
      body: _isLoading
          ? SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: Column(
                  children: <Widget>[
                    CompHeaderLoading(),
                    CompContentLoading(),
                    CompFooterLoading(),
                  ],
                ),
              ),
            )
          : _isError
              ? ErrorOutputWidget(
                  errorMessage: _errorMessage,
                  onPress: () {
                    getResource();
                  },
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 5.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        comp != 'Tidak ditemukan'
                            ? Container(
                                padding: EdgeInsets.all(10.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Jika anda ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Maison Neue',
                                      height: 1.5,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'diberi wewenang ',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: 'untuk dapat '),
                                      TextSpan(
                                        text:
                                            'mengelola lebih dari satu cabang/outlet. ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              'anda bisa mengganti cabang/outlet yang ingin anda kelola tersebut melalui form dibawah ini :'),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(10.0),
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Sebelum anda memulai, ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text:
                                              'tentukan terlebih dahulu beberapa informasi terkait '),
                                      TextSpan(
                                        text: 'login ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(text: 'anda dibawah ini :'),
                                    ],
                                  ),
                                ),
                              ),
                        Container(
                          padding: EdgeInsets.all(15.0),
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(
                              238,
                              238,
                              238,
                              1,
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Cabang yang digunakan untuk login',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: null,
                                    // () {
                                    //   Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (BuildContext context) =>
                                    //           CariCabang(),
                                    //     ),
                                    //   );
                                    // },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              bloc.selectedCabang == null
                                                  ? '~ Pilih Cabang'
                                                  : bloc.selectedCabang.nama,
                                            ),
                                          ),
                                          // Icon(
                                          //   Icons.chevron_right,
                                          //   color: Colors.blue,
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Tooltip(
                                        message:
                                            'informasi ini digunakan ketika menggunakan fitur kasir',
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Icon(
                                            FontAwesomeIcons.infoCircle,
                                            size: 14.0,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'Outlet yang digunakan untuk login',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CariOutlet(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              bloc.selectedOutlet == null
                                                  ? '~ Pilih Outlet (pilih cabang terlebih dahulu)'
                                                  : bloc.selectedOutlet.nama,
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                            color: Colors.blue,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Form pilihan diatas hanya akan ',
                              style: TextStyle(
                                color: Colors.black,
                                height: 1.5,
                                fontFamily: 'Maison Neue',
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'menampilkan data-data cabang/outlet yang bisa anda kelola. ',
                                  style: TextStyle(
                                    color: Colors.cyan,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                    text:
                                        'anda bisa menentukan data cabang/outlet tersebut melalui fitur master pegawai.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
