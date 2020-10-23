import 'dart:convert';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/diskon/diskonModel.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'package:intl/intl.dart';
import 'package:martabakdjoeragan_app/utils/numberMask.dart';
import 'package:http/http.dart' as http;

GlobalKey<ScaffoldState> _scaffoldKeyTambahDiskon;
bool _isError, _isLoading, _isNilai, _isNotValid;
String _errorMessage;
Map<String, String> requestHeaders = Map();

TextEditingController _namaDiskonController,
    _awalDiskonController,
    _akhirDiskonController,
    _catatanController;
FocusNode _namaDiskonFocus, _awalDiskonFocus, _akhirDiskonFocus, _catatanFocus;

MoneyMaskedTextController _maxDiskonController,
    _diskonNilaiController,
    _kategoriTotalPembelianController;

DateTime _initialAwalDiskon, _initialAkhirDiskon;

DTipe _selectedlistDTipe = DTipe(
  id: 'ITEM',
  text: 'Potongan harga item',
);

List<int> _listDiskon = [
  10,
  15,
  20,
  30,
  50,
  100,
];

List<Produk> _listProduk;

Produk _selectedProduk;

int _selectedDiskon = 10;
int _dGabung, _dKonfirmasi;

class TambahDiskon extends StatefulWidget {
  @override
  _TambahDiskonState createState() => _TambahDiskonState();
}

class _TambahDiskonState extends State<TambahDiskon> {
  @override
  void initState() {
    _namaDiskonController = TextEditingController();
    _awalDiskonController = TextEditingController();
    _akhirDiskonController = TextEditingController();
    _catatanController = TextEditingController();
    _diskonNilaiController = MoneyMaskedTextController(
      thousandSeparator: ',',
      decimalSeparator: '.',
    );
    _kategoriTotalPembelianController = MoneyMaskedTextController(
      initialValue: 10000.0,
      thousandSeparator: ',',
      decimalSeparator: '.',
    );

    _maxDiskonController = MoneyMaskedTextController(
      initialValue: 0.0,
      thousandSeparator: ',',
      decimalSeparator: '.',
    );
    _namaDiskonFocus = FocusNode();
    _awalDiskonFocus = FocusNode();
    _akhirDiskonFocus = FocusNode();
    _catatanFocus = FocusNode();
    _isNotValid = false;
    _isError = false;
    _isLoading = false;
    _initialAwalDiskon = null;
    _initialAkhirDiskon = null;
    _dGabung = 0;
    _dKonfirmasi = 1;
    _selectedProduk = null;
    _listProduk = List<Produk>();
    _selectedlistDTipe = DTipe(
      id: 'ITEM',
      text: 'Potongan harga item',
    );
    _selectedDiskon = 10;
    _isNilai = false;

    resource();

    super.initState();
  }

  resource() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';
    try {
      final response = await http.get(
        url + 'penjualan/diskon/resource',
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        dynamic responseJson = jsonDecode(response.body);
        _listProduk = List<Produk>();

        _listProduk.add(
          Produk(
            id: 'all',
            nama: 'Semua Item',
          ),
        );

        for (var data in responseJson['data2']) {
          _listProduk.add(
            Produk(
              id: data['id'].toString(),
              nama: data['text'],
            ),
          );
        }

        _selectedProduk = Produk(
          id: 'all',
          nama: 'Semua Item',
        );
        setState(() {
          _isError = false;
          _isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: 'Error Code : ${response.statusCode}');
        print(response.body);
        setState(() {
          _isError = true;
          _isLoading = false;
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

  simpan() async {
    // setState(() {
    //   _isLoading = true;
    // });
    Map<String, String> formSerialize = Map<String, String>();

    formSerialize['cabangs'] = null;
    formSerialize['d_jenis'] = null;
    formSerialize['d_nama'] = null;
    formSerialize['d_mulai'] = null;
    formSerialize['d_akhir'] = null;
    formSerialize['d_type'] = null;
    formSerialize['d_item'] = null;
    formSerialize['d_kategori_harga'] = null;
    formSerialize['d_persen'] = null;
    formSerialize['d_max_value'] = null;
    formSerialize['d_catatan'] = null;
    formSerialize['d_gabung'] = null;
    formSerialize['d_konfirmasi'] = null;

    DataStore store = DataStore();
    int perusaahan = await store.getDataInteger('us_perusahaan');

    formSerialize['cabangs'] = perusaahan.toString();
    formSerialize['d_jenis'] = _isNilai ? 'rupiah' : 'persen';
    formSerialize['d_nama'] = _namaDiskonController.text;
    formSerialize['d_mulai'] = _awalDiskonController.text;
    formSerialize['d_akhir'] = _akhirDiskonController.text;
    formSerialize['d_type'] =
        _selectedlistDTipe != null ? _selectedlistDTipe.id : '';
    formSerialize['d_kategori_harga'] = _kategoriTotalPembelianController.text;
    formSerialize['d_persen'] =
        _isNilai ? _diskonNilaiController.text : _selectedDiskon.toString();
    formSerialize['d_item'] = _selectedProduk != null ? _selectedProduk.id : '';
    formSerialize['d_max_value'] = _maxDiskonController.text;
    formSerialize['d_catatan'] = _catatanController.text;
    formSerialize['d_gabung'] = _dGabung == 1 ? '1' : '';
    formSerialize['d_konfirmasi'] = _dKonfirmasi == 1 ? '1' : '';

    String accessToken = await store.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    print(formSerialize);

    try {
      final response = await http.post(
        '${url}penjualan/diskon/save',
        headers: requestHeaders,
        body: formSerialize,
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        print(responseJson);

        if (responseJson['status'] == 'success') {
          Fluttertoast.showToast(msg: responseJson['text']);
          Navigator.popUntil(context, ModalRoute.withName('/diskon'));
        } else if (responseJson['status'] == 'error') {
          Fluttertoast.showToast(msg: responseJson['text']);
        }

        setState(() {
          _isLoading = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali');

        setState(() {
          _isLoading = false;
        });
      } else {
        print(response.body);
        Fluttertoast.showToast(msg: 'Error Code : ${response.statusCode}');

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);

      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      key: _scaffoldKeyTambahDiskon,
      appBar: AppBar(
        title: Text('Form Data Diskon'),
        backgroundColor: Colors.orange[300],
      ),
      floatingActionButtonLocation: showFab
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          List<String> validasi = List<String>();

          if (_namaDiskonController.text.isEmpty) {
            validasi.add('Input Nama Diskon tidak boleh kosong!');
          }
          if (_awalDiskonController.text.isEmpty) {
            validasi.add('Input Tanggal Awal Diskon tidak boleh kosong!');
          }

          if (_akhirDiskonController.text.isEmpty) {
            validasi.add('Input Tanggal Akhir Diskon tidak boleh kosong!');
          }

          if (_selectedlistDTipe.id == 'SUB') {
            if (_kategoriTotalPembelianController.text.isEmpty) {
              validasi
                  .add('Input Kategori Total Pembelian tidak boleh kosong!');
            }
          }

          if (_maxDiskonController.text.isEmpty) {
            validasi.add('Input Maksimal Diskon tidak boleh kosong!');
          }

          if (_isNilai) {
            if (_diskonNilaiController.text.isEmpty) {
              validasi.add('Input Diskon Nilai tidak boleh kosong!');
            }
          } else {
            if (_selectedDiskon.toString().isEmpty) {
              validasi.add('Silahkan Pilih Diskon Persen');
            }
          }

          if (_catatanController.text.isEmpty) {
            validasi.add('Input Catatan tidak boleh kosong!');
          }

          if (validasi.length == 0) {
            setState(() {
              _isNotValid = false;
            });
            simpan();
          } else {
            setState(() {
              _isNotValid = true;
            });
            for (var data in validasi) {
              Fluttertoast.showToast(msg: data);
            }
          }
        },
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
        tooltip: 'Simpan',
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _isError
                ? ErrorOutputWidget(
                    errorMessage: _errorMessage,
                    onPress: () {},
                  )
                : Scrollbar(
                    child: SingleChildScrollView(
                      child: Card(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Nama Diskon ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: TextField(
                                        controller: _namaDiskonController,
                                        focusNode: _namaDiskonFocus,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding: EdgeInsets.all(10),
                                          errorText: _isNotValid
                                              ? _namaDiskonController
                                                      .text.isEmpty
                                                  ? 'Nama Diskon tidak boleh kosong'
                                                  : null
                                              : null,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Tanggal Awal Diskon ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DateTimeField(
                                        enabled: true,
                                        focusNode: _awalDiskonFocus,
                                        format: DateFormat('dd/MM/yyyy'),
                                        initialValue: _initialAwalDiskon,
                                        controller: _awalDiskonController,
                                        onShowPicker: (context, currentValue) {
                                          return showDatePicker(
                                            initialDate:
                                                currentValue ?? DateTime.now(),
                                            firstDate: DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                            ),
                                            context: context,
                                            lastDate: DateTime(
                                                DateTime.now().year + 30),
                                          );
                                        },
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          hintText: 'DD/MM/YYYY',
                                          errorText: _isNotValid
                                              ? _awalDiskonController
                                                      .text.isEmpty
                                                  ? 'Tanggal Awal Diskon tidak boleh kosong'
                                                  : null
                                              : null,
                                        ),
                                        onChanged: (ini) {
                                          setState(() {
                                            _initialAwalDiskon = ini;
                                            _awalDiskonController.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(ini);
                                          });
                                          if (_initialAkhirDiskon == null) {
                                            _initialAkhirDiskon = ini;
                                          } else if (_initialAwalDiskon
                                              .isAfter(_initialAkhirDiskon)) {
                                            _initialAkhirDiskon = ini;
                                          }
                                          print(_initialAkhirDiskon);
                                          setState(() {
                                            _initialAkhirDiskon =
                                                _initialAkhirDiskon;
                                            _akhirDiskonController.text =
                                                DateFormat('dd/MM/yyyy').format(
                                                    _initialAkhirDiskon);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Tanggal Akhir Diskon ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DateTimeField(
                                        enabled: true,
                                        focusNode: _akhirDiskonFocus,
                                        format: DateFormat('dd/MM/yyyy'),
                                        initialValue: _initialAkhirDiskon,
                                        controller: _akhirDiskonController,
                                        onShowPicker: (context, currentValue) {
                                          DateTime date, date1;
                                          if (currentValue == null &&
                                              _initialAwalDiskon == null) {
                                            date = DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                            );
                                          } else if (currentValue == null &&
                                              _initialAwalDiskon != null) {
                                            date = _initialAwalDiskon;
                                          } else if (currentValue != null &&
                                              _initialAwalDiskon != null) {
                                            if (_initialAwalDiskon
                                                .isAfter(currentValue)) {
                                              date = _initialAwalDiskon;
                                            } else {
                                              date = currentValue;
                                            }
                                          } else if (currentValue != null) {
                                            date = currentValue;
                                          } else {
                                            date = DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                            );
                                          }

                                          if (_initialAwalDiskon == null) {
                                            date1 = DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                            );
                                          } else if (_initialAwalDiskon !=
                                              null) {
                                            date1 = _initialAwalDiskon;
                                          } else {
                                            date1 = DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day,
                                            );
                                          }
                                          return showDatePicker(
                                            initialDate: date,
                                            firstDate: date1,
                                            context: context,
                                            lastDate: DateTime(
                                                DateTime.now().year + 30),
                                          );
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'DD/MM/YYYY',
                                          errorText: _isNotValid
                                              ? _akhirDiskonController
                                                      .text.isEmpty
                                                  ? 'Tanggal Akhir Diskon tidak boleh kosong'
                                                  : null
                                              : null,
                                        ),
                                        readOnly: true,
                                        onChanged: (ini) {
                                          setState(() {
                                            _initialAkhirDiskon = ini;
                                            _akhirDiskonController.text =
                                                DateFormat('dd/MM/yyyy')
                                                    .format(ini);
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Tipe Diskon ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DropdownButton(
                                        hint: Text('Pilih Tipe Diskon'),
                                        isExpanded: true,
                                        value: _selectedlistDTipe,
                                        items: listDTipe.map((f) {
                                          return DropdownMenuItem(
                                            child: Text(f.text),
                                            value: f,
                                          );
                                        }).toList(),
                                        onChanged: (iniValue) {
                                          setState(() {
                                            _selectedlistDTipe = iniValue;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              _selectedlistDTipe.id == 'SUB'
                                  ? Container(
                                      margin: EdgeInsets.only(
                                        bottom: 10.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          CheckboxListTile(
                                            value: _dGabung == 1,
                                            title: Text(
                                                'Diskon ini bisa digabung dengan diskon lain ?'),
                                            selected: _dGabung == 1,
                                            onChanged: (ini) {
                                              print(ini);
                                              setState(() {
                                                _dGabung =
                                                    _dGabung == 1 ? 0 : 1;
                                              });
                                            },
                                          ),
                                          CheckboxListTile(
                                            value: _dKonfirmasi == 1,
                                            title: Text(
                                                'Diskon ini harus dikonfirmasi oleh kasir ?'),
                                            selected: _dKonfirmasi == 1,
                                            onChanged: (ini) {
                                              print(ini);
                                              setState(() {
                                                _dKonfirmasi =
                                                    _dKonfirmasi == 1 ? 0 : 1;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              _selectedlistDTipe.id == 'SUB'
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                              text: 'Kategori Total Pembelian ',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '(lebih dari / sama dengan)',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 11.0,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          TextField(
                                            controller:
                                                _kategoriTotalPembelianController,
                                            textAlign: TextAlign.end,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              NumberMask()
                                            ],
                                            keyboardType: TextInputType.number,
                                            onChanged: (ini) {
                                              _kategoriTotalPembelianController
                                                  .value = TextEditingValue(
                                                text: ini,
                                                selection:
                                                    _kategoriTotalPembelianController
                                                        .selection,
                                              );
                                            },
                                            decoration: InputDecoration(
                                              errorText: _isNotValid
                                                  ? _kategoriTotalPembelianController
                                                          .text.isEmpty
                                                      ? 'Input Kategori Total Pembelian tidak boleh kosong'
                                                      : null
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Pilih Produk'),
                                          DropdownButton(
                                            isExpanded: true,
                                            hint: Text('Pilih Produk'),
                                            value: _selectedProduk,
                                            items: _listProduk.map((f) {
                                              return DropdownMenuItem(
                                                child: Text(f.nama),
                                                value: f,
                                              );
                                            }).toList(),
                                            onChanged: (ini) {
                                              setState(() {
                                                _selectedProduk = ini;
                                              });
                                            },
                                          ),
                                          Text(
                                            'tidak akan mempengaruhi item-item yang sudah memiliki diskon sebelumnya ',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.cyan,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              Divider(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Nilai Diskon ',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '*',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        title: _isNilai
                                            ? TextField(
                                                controller:
                                                    _diskonNilaiController,
                                                textAlign: TextAlign.end,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  NumberMask()
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  errorText: _isNotValid
                                                      ? _diskonNilaiController
                                                              .text.isEmpty
                                                          ? 'Input Diskon Nilai tidak boleh kosong'
                                                          : null
                                                      : null,
                                                ),
                                                onChanged: (ini) {
                                                  if (_isNilai) {
                                                    // _diskonNilaiController.text = ini;

                                                    _diskonNilaiController
                                                            .value =
                                                        TextEditingValue(
                                                      text: ini,
                                                      selection:
                                                          _diskonNilaiController
                                                              .selection,
                                                    );
                                                    setState(() {
                                                      _maxDiskonController
                                                          .text = ini;
                                                    });
                                                  } else {
                                                    // _diskonNilaiController.text = ini;
                                                    _diskonNilaiController
                                                            .value =
                                                        TextEditingValue(
                                                      text: ini,
                                                      selection:
                                                          _diskonNilaiController
                                                              .selection,
                                                    );
                                                  }
                                                },
                                              )
                                            : DropdownButton(
                                                hint:
                                                    Text('Pilih Diskon Persen'),
                                                isExpanded: true,
                                                value: _selectedDiskon,
                                                items: _listDiskon.map((f) {
                                                  return DropdownMenuItem(
                                                    child: Text(f.toString()),
                                                    value: f,
                                                  );
                                                }).toList(),
                                                onChanged: (iniValue) {
                                                  setState(() {
                                                    _selectedDiskon = iniValue;
                                                  });
                                                },
                                              ),
                                        trailing: Tooltip(
                                          message: _isNilai
                                              ? 'Tekan untuk mengganti menjadi persen'
                                              : 'Tekan untuk mengganti menjadi nilai',
                                          child: Container(
                                            width: 50.0,
                                            padding: EdgeInsets.all(0),
                                            child: FlatButton(
                                              child: _isNilai
                                                  ? Text(
                                                      'Rp',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 15.0,
                                                      ),
                                                    )
                                                  : Icon(
                                                      FontAwesomeIcons.percent,
                                                      color: Colors.blue,
                                                      size: 16.0,
                                                    ),
                                              onPressed: () {
                                                if (_isNilai) {
                                                  setState(() {
                                                    _isNilai = false;
                                                  });
                                                } else {
                                                  if (_maxDiskonController
                                                          .text ==
                                                      '0.00') {
                                                    setState(() {
                                                      _isNilai = true;

                                                      _diskonNilaiController
                                                          .text = '10,000.00';
                                                      _maxDiskonController
                                                          .text = '10,000.00';
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _isNilai = true;

                                                      _diskonNilaiController
                                                              .text =
                                                          _maxDiskonController
                                                              .text;
                                                    });
                                                  }
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(),
                              _selectedlistDTipe.id == 'SUB'
                                  ? Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Nilai Maks Diskon ',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: TextField(
                                              controller: _maxDiskonController,
                                              enabled: !_isNilai,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                                NumberMask()
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.end,
                                              decoration: InputDecoration(
                                                errorText: _isNotValid
                                                    ? _maxDiskonController
                                                            .text.isEmpty
                                                        ? 'Maksimal Diskon tidak boleh kosong isi minimal 0'
                                                        : null
                                                    : null,
                                              ),
                                              onChanged: (ini) {
                                                if (ini.isEmpty) {
                                                  ini = '0.00';
                                                }
                                                _maxDiskonController.value =
                                                    TextEditingValue(
                                                  text: ini,
                                                  selection:
                                                      _maxDiskonController
                                                          .selection,
                                                );
                                              },
                                            ),
                                          ),
                                          Text(
                                            'jika diisi 0 (nol) berarti tidak ada nilai maksimal',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.cyan,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              _selectedlistDTipe.id == 'SUB'
                                  ? Divider()
                                  : Container(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Catatan',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: TextField(
                                        focusNode: _catatanFocus,
                                        decoration: InputDecoration(
                                          hintText:
                                              'Contoh : Diskon 10%/Item maksimal Rp. 20,000',
                                          errorText: _isNotValid
                                              ? _catatanController.text.isEmpty
                                                  ? 'Catatan tidak boleh kosong'
                                                  : null
                                              : null,
                                        ),
                                        minLines: 3,
                                        maxLines: 5,
                                        controller: _catatanController,
                                        onChanged: (ini) {
                                          _catatanController.value =
                                              TextEditingValue(
                                            text: ini,
                                            selection:
                                                _catatanController.selection,
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
