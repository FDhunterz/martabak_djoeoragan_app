import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_bloc.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_loading.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_model.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/detail_penjualan.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
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
  void getNota() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    DataStore store = DataStore();

    int perusahaan = await store.getDataInteger('us_perusahaan');
    String accessToken = await store.getDataString('access_token');
    String outlet = await store.getDataString('comp');

    // print(perusahaan);

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    String dateParse = DateFormat('MM/yyyy').format(_selectedTanggal);
    // print(dateParse);

    try {
      final response = await http.get(
        '${url}penjualan/kasir/get/nota?cabangs=$perusahaan&outlet=$outlet&periode=$dateParse',
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        print(response.body);
        var responseJson = jsonDecode(response.body);
        var bloc = Provider.of<DaftarPenjualanBloc>(context);
        bloc.clearNota();
        for (var data in responseJson['data']) {
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
        setState(() {
          _isLoading = false;
          _isError = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali');

        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
        });
      } else {
        Fluttertoast.showToast(msg: 'Error Code : ${response.statusCode}');
        Fluttertoast.showToast(msg: response.body);
        print(response.body);
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = response.body;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isError = true;
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
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
            showMonthPicker(
              context: context,
              initialDate: _selectedTanggal,
              lastDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year - 1),
            ).then((ini) {
              if (ini != null) {
                setState(() {
                  _selectedTanggal = ini;
                });
              }
              getNota();
            });
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
                      child: Column(
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
