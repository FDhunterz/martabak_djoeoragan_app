import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/core/custom_sendrequest.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/core/storage.dart';
import 'package:martabakdjoeragan_app/pages/CekKoneksi/cek_koneksi.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_bloc.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_loading.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_model.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/detail_penjualan.dart';
// import 'package:martabakdjoeragan_app/pages/profile.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

GlobalKey<ScaffoldState> _scaffoldKeyDaftarPenjualan;
Map<String, String> requestHeaders = Map();
DateTime _selectedTanggal;
String _errorMessage;
bool _isLoading, _isError, _isSearch;
TextEditingController _cariController;

class DaftarPenjualan extends StatefulWidget {
  @override
  _DaftarPenjualanState createState() => _DaftarPenjualanState();
}

class _DaftarPenjualanState extends State<DaftarPenjualan> {
  CekKoneksi cekKoneksi = CekKoneksi.instance;
  CustomSendRequest customHttp = CustomSendRequest.initialize;
  DataStore store = DataStore();
  PenyimpananKu storage = PenyimpananKu();
  bool isSendNotaOffline = false;

  Map statusKoneksi = {
    'type': ConnectivityResult.none,
    'isOnline': false,
  };

  void getNota() async {
    int perusahaan = await store.getDataInteger('us_perusahaan');
    String accessToken = await store.getDataString('access_token');
    String outlet = await store.getDataString('comp');

    // print(perusahaan);

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    String dateParse = DateFormat('MM/yyyy').format(_selectedTanggal);
    // print(dateParse);

    try {
      String namaFile = 'daftar-nota.json';

      _kelolaResourceNota(String encodedString) async {
        var responseJson = jsonDecode(encodedString);
        DaftarPenjualanBloc bloc = context.read<DaftarPenjualanBloc>();

        bloc.clearNota();
        for (var data in responseJson['data']) {
          DateTime tanggal = DateTime.parse(data['pk_tanggal']);

          if (DateTime(tanggal.year, tanggal.month)
                  .difference(
                      DateTime(_selectedTanggal.year, _selectedTanggal.month))
                  .inDays ==
              0) {
            List<Item> listDetail = List<Item>();
            for (var item in data['detail']) {
              listDetail.add(
                Item(
                  diskon: item['pkdt_diskon'].toString(),
                  harga: item['pkdt_harga'].toString(),
                  idItem: item['pkdt_item'].toString(),
                  namaItem: item['pkdt_nama'],
                  nomor: item['pkdt_nomor'].toString(),
                  penjualanKasir: item['pkdt_penjualan_kasir'].toString(),
                  qty: item['pkdt_qty'].toString(),
                  total: item['pkdt_total'].toString(),
                  gambar: item['gambar'].toString(),
                ),
              );
            }

            bloc.addNota(
              NotaPenjualan(
                alamat: data['c_alamat'],
                bayar: data['pk_bayar'].toString(),
                customer: data['c_nama'],
                diskonPlus: data['pk_diskon_plus'].toString(),
                grandTotal: data['pk_grand_total'].toString(),
                harga: data['pk_harga'],
                id: data['pk_id'].toString(),
                kasir: data['p_nama'],
                nota: data['pk_nota'],
                pajak: data['pk_pajak'].toString(),
                subTotal: data['pk_sub_total'].toString(),
                tanggal: data['pk_tanggal'],
                telpon: data['c_telp'],
                detailNotaPenjualan: listDetail,
              ),
            );
          }
        }
      }

      customHttp.get(
        '${url}penjualan/kasir/get/nota',
        body: {
          'cabangs': perusahaan,
          'outlet': outlet,
          'periode': dateParse,
        },
        headers: requestHeaders,
        isOnline: statusKoneksi['isOnline'],
        namaFile: namaFile,
        onBeforeSend: () {
          setState(() {
            _isLoading = true;
            _isError = false;
          });
        },
        onComplete: () {
          setState(() {
            _isLoading = false;
            _isError = false;
          });
        },
        onErrorCatch: (ini) {
          print(ini);
          setState(() {
            _isError = true;
            _isLoading = false;
            _errorMessage = ini;
          });
        },
        onSuccess: (ini) {
          print(ini);

          storage.tulisBerkas(ini, namaFile);

          _kelolaResourceNota(ini);
        },
        onUnknownStatusCode: (statusCode, e) {
          Fluttertoast.showToast(msg: 'Error Code : $statusCode');
          Fluttertoast.showToast(msg: e);
          print(e);
          setState(() {
            _isLoading = false;
            _isError = true;
            _errorMessage = e;
          });
        },
        onUseLocalFile: (ini) async {
          DaftarPenjualanBloc bloc = context.read<DaftarPenjualanBloc>();

          _kelolaResourceDataKasirTersimpanOffline() async {
            String anotherFile = 'simpan-kasir.json';

            String encodedFile = await storage.bacaBerkas(anotherFile);

            if (encodedFile.isNotEmpty) {
              List<dynamic> listDecode = List();

              listDecode = jsonDecode(encodedFile);

              // bloc.clearNota();

              for (String data in listDecode) {
                Map decodedData = jsonDecode(data);

                print(decodedData);

                DateTime tanggal =
                    DateTime.parse(decodedData['tanggal_penjualan']);

                // print(tanggal);
                /// compare data jika bulan yang dipilih[_selectedTanggal] sama dengan bulan nota dibuat[tanggal]
                if (DateTime(tanggal.year, tanggal.month)
                        .difference(DateTime(
                            _selectedTanggal.year, _selectedTanggal.month))
                        .inDays ==
                    0) {
                  print('true');

                  List<Item> listDetail = List<Item>();

                  double subTotal = 0;
                  for (int i = 0; i < decodedData['pkdt_item'].length; i++) {
                    double total = (double.parse(
                                decodedData['pkdt_harga_item'][i].toString()) -
                            double.parse(
                                decodedData['pkdt_diskon'][i].toString())) *
                        int.parse(decodedData['pkdt_qty'][i].toString());

                    subTotal += total;

                    listDetail.add(
                      Item(
                        diskon: decodedData['pkdt_diskon'][i].toString(),
                        harga: decodedData['pkdt_harga_item'][i].toString(),
                        idItem: decodedData['pkdt_item'][i].toString(),
                        namaItem: decodedData['pkdt_nama_item'][i],
                        // nomor: decodedData['pkdt_nomor'][i].toString(),
                        // penjualanKasir:
                        //     decodedData['pkdt_penjualan_kasir'][i].toString(),
                        qty: decodedData['pkdt_qty'][i].toString(),
                        total: total.toString(),
                        gambar: decodedData['pkdt_gambar'][i].toString(),
                      ),
                    );
                  }

                  bloc.addNota(
                    NotaPenjualan(
                      alamat: decodedData['c_alamat'],
                      bayar: decodedData['pk_bayar']
                          .toString()
                          .replaceAll(',', ''),
                      customer: decodedData['c_nama'],
                      diskonPlus: decodedData['pk_diskon_plus'].toString(),
                      grandTotal: (subTotal -
                              double.parse(
                                  decodedData['pk_diskon_plus'].toString()))
                          .toString(),
                      harga: decodedData['namaHargaPenjualan'],
                      id: '0',
                      kasir: decodedData['namaUserMelayani'],
                      nota: decodedData['nota'],
                      pajak: decodedData['totalPpn'].toString(),
                      subTotal: subTotal.toString(),
                      tanggal: DateFormat('yyyy-MM-dd').format(tanggal),
                      telpon: decodedData['c_telepon'],
                      detailNotaPenjualan: listDetail,
                    ),
                  );
                }
              }
            } else {
              print('encoded file isempty');
            }
          }

          if (ini.isNotEmpty) {
            _kelolaResourceNota(ini);
            _kelolaResourceDataKasirTersimpanOffline();
          } else {
            print('lokal isEmpty');
            bloc.clearNota();
            _kelolaResourceDataKasirTersimpanOffline();
          }
          setState(() {
            _isLoading = false;
            _isError = false;
          });
        },
      );
    } catch (e) {
      print(e);
      setState(() {
        _isError = true;
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void cekKoneksiFunction() {
    cekKoneksi.myStream.listen((event) async {
      print(event);

      if (event['isOnline'] && !isSendNotaOffline) {
        isSendNotaOffline = true;
        await Future.delayed(Duration.zero, () {
          simpanNotaOfflineKeServer(
            context,
            onOnlyOnce: (ini) {
              isSendNotaOffline = false;
            },
          );
        });
      }

      /// event @return
      /// {
      ///   'type': ConnectivityResult.none | ConnectivityResult.mobile | ConnectivityResult.wifi,
      ///   'isOnline' : bool,
      /// };
      setState(() {
        statusKoneksi = event;
      });
    });
  }

  @override
  void initState() {
    _cariController = TextEditingController();
    _scaffoldKeyDaftarPenjualan = GlobalKey<ScaffoldState>();
    _errorMessage = '';
    _isLoading = true;
    _isError = false;
    _isSearch = false;
    _selectedTanggal = DateTime.now();

    cekKoneksi.initialise();
    cekKoneksiFunction();

    getNota();
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
    var bloc = Provider.of<DaftarPenjualanBloc>(context);

    var listNota = bloc.listFilteredNota(_cariController.text);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKeyDaftarPenjualan,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: CalendarDatePicker(
                  initialDate: _selectedTanggal,
                  firstDate: DateTime(DateTime.now().year - 1),
                  lastDate: DateTime.now(),
                  onDateChanged: (ini) {
                    if (ini != null) {
                      setState(() {
                        _selectedTanggal = ini;
                      });
                    }
                    getNota();
                  },
                ),
              ),
            );

            // DatePicker.showDatePicker(
            //   context,
            //   maxDateTime: DateTime.now(),
            //   minDateTime: DateTime(DateTime.now().year - 1),
            //   onConfirm: (ini, selectedIndex) {
            //     if (ini != null) {
            //       setState(() {
            //         _selectedTanggal = ini;
            //       });
            //     }
            //     getNota();
            //   },
            // );

            // # package month_picker_dialog
            // showMonthPicker(
            //   context: context,
            //   initialDate: _selectedTanggal,
            //   lastDate: DateTime.now(),
            //   firstDate: DateTime(DateTime.now().year - 1),
            // ).then((ini) {
            //   if (ini != null) {
            //     setState(() {
            //       _selectedTanggal = ini;
            //     });
            //   }
            //   getNota();
            // });
          },
          label: Text('Periode Nota'),
          icon: Icon(Icons.calendar_today),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Color(0xff25282b),
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
          title: _isSearch
              ? TextField(
                  autofocus: true,
                  controller: _cariController,
                  decoration: InputDecoration(
                    hintText: 'Cari Nota/Customer/Kasir',
                  ),
                  onChanged: (ini) {
                    setState(() {
                      _cariController.value = TextEditingValue(
                        text: ini,
                        selection: _cariController.selection,
                      );
                      listNota = bloc.listFilteredNota(ini);
                    });
                  },
                )
              : Text('Daftar Nota Kasir'),
          actions: <Widget>[
            _isSearch
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _cariController.clear();
                        _isSearch = false;
                        listNota = bloc.listFilteredNota(_cariController.text);
                      });
                    },
                    icon: Icon(Icons.close),
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        _isSearch = true;
                      });
                    },
                  )
          ],
        ),
        body: _isLoading
            ? SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    DaftarPenjualanLoading(),
                    Divider(),
                    DaftarPenjualanLoading(),
                    Divider(),
                    DaftarPenjualanLoading(),
                    Divider(),
                    DaftarPenjualanLoading(),
                    Divider(),
                  ],
                ),
              )
            : _isError
                ? ErrorOutputWidget(
                    errorMessage: _errorMessage,
                    onPress: () {
                      getNota();
                    },
                  )
                : Scrollbar(
                    child: RefreshIndicator(
                      onRefresh: () {
                        getNota();
                        return Future.value('');
                      },
                      child: ListView(
                        padding: EdgeInsets.only(bottom: 100),
                        children: listNota.length != 0
                            ? listNota
                                .map(
                                  (f) => Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(f.nota),
                                        subtitle: Text(
                                            f.customer ?? 'Tidak diketahui'),
                                        trailing: Text(
                                            DateFormat('dd MMMM yyyy').format(
                                                DateTime.parse(f.tanggal))),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DetailPenjualan(
                                                nota: f,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                )
                                .toList()
                            : [
                                ListTile(
                                  title: Text(
                                    'Tidak ada data',
                                    textAlign: TextAlign.center,
                                  ),
                                  subtitle: Text(
                                    'Periode ' +
                                        DateFormat('MMMM yyyy')
                                            .format(_selectedTanggal),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
