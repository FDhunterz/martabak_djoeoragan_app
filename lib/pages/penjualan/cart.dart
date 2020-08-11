import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/cartTile.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/customer.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/escpos_function.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kupon.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:martabakdjoeragan_app/utils/numberMask.dart';
import 'package:provider/provider.dart';
import 'package:martabakdjoeragan_app/pages/cameo/empty_cart.dart';
// import 'package:martabakdjoeragan_app/utils/foods.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:escposprinter/escposprinter.dart';

Map<String, String> requestHeaders = Map();
GlobalKey<ScaffoldState> _scaffoldKeyCart;
double offset;
bool _isSendRequest;
String _errorMessage;
ScrollController _scrollController;

class CartPage extends StatefulWidget {
  CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  NumberFormat _numberFormat =
      NumberFormat.simpleCurrency(decimalDigits: 0, name: 'Rp. ');

  void simpanKasir() async {
    setState(() {
      _isSendRequest = true;
      _errorMessage = '';
    });
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');
    int perusahaan = await dataStore.getDataInteger('us_perusahaan');
    String comp = await dataStore.getDataString('comp');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    Map formSerialize = Map();

    KasirBloc blocX = Provider.of<KasirBloc>(context);

    formSerialize['cabangs'] = perusahaan.toString();
    if (blocX.selectedCustomer != null) {
      formSerialize['c_nama'] = blocX.selectedCustomer.namaCustomer;
      formSerialize['c_telepon'] = blocX.selectedCustomer.noTelp;
      formSerialize['c_alamat'] = blocX.selectedCustomer.alamat;
    }

    formSerialize['pk_bayar'] = blocX.jumlahBayarController.text;
    formSerialize['p_harga'] = blocX.selectedHargaPenjualan.id;

    formSerialize['pkdt_item'] = List();
    formSerialize['pkdt_qty'] = List();
    formSerialize['pkdt_harga_item'] = List();
    formSerialize['pkdt_diskon'] = List();

    for (MartabakModel data in blocX.cart) {
      formSerialize['pkdt_item'].add(data.id);
      formSerialize['pkdt_qty'].add(data.qty);
      formSerialize['pkdt_harga_item'].add(data.sysprice);
      formSerialize['pkdt_diskon'].add(data.diskon ?? 0.toString());
    }

    formSerialize['pk_diskon_plus'] = blocX.totalDiskon;
    formSerialize['platform'] = 'android';
    formSerialize['outlet'] = comp;
    formSerialize['pk_catatan'] = blocX.catatanController.text;

    try {
      final response = await http.post(
        '${url}penjualan/kasir/save',
        headers: requestHeaders,
        body: {
          'data': jsonEncode(formSerialize),
          'platform': 'android',
        },
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        if (responseJson['status'] == 'success') {
          await printKasir(responseJson['data']['nota'], context);
          Fluttertoast.showToast(msg: responseJson['text']);
          blocX.clearCart();
          blocX.unsetCustomer();
          blocX.catatanController.clear();
          blocX.jumlahBayarController.text = '0';
          Navigator.pop(context, true);
        } else if (responseJson['status'] == 'error') {
          Fluttertoast.showToast(msg: responseJson['text']);
        } else {
          Fluttertoast.showToast(msg: 'Send Response done');
          print(responseJson);
        }
        setState(() {
          _isSendRequest = false;
        });
      } else if (response.statusCode == 401) {
        Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali');
        setState(() {
          _isSendRequest = false;
          _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
        });
      } else {
        Fluttertoast.showToast(msg: 'Error Code: ${response.statusCode}');
        Fluttertoast.showToast(msg: response.body);
        print(response.body);
        setState(() {
          _errorMessage = response.body;
          _isSendRequest = false;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        _isSendRequest = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    _scaffoldKeyCart = GlobalKey<ScaffoldState>();
    _scrollController = ScrollController(
      keepScrollOffset: true,
    );
    offset = 0;
    bool lessOnce = false;
    bool moreOnce = false;
    _scrollController.addListener(() {
      if (lessOnce && _scrollController.offset < 2000) {
        setState(() {
          offset = _scrollController.offset;
        });
        lessOnce = false;
      } else {
        lessOnce = true;
      }

      if (moreOnce && _scrollController.offset > 2000) {
        setState(() {
          offset = _scrollController.offset;
        });
        moreOnce = false;
      } else {
        moreOnce = true;
      }
    });
    _isSendRequest = false;
    _errorMessage = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    KasirBloc bloc = Provider.of<KasirBloc>(context);
    var cart = bloc.cart;
    Customer selectedCustomer = bloc.selectedCustomer;
    List<KuponBelanja> kuponList = bloc.kupon;
    int selectedKupon = 0;
    int kuponEnable = 0;

    for (var data in kuponList) {
      if (data.selected == '1') {
        selectedKupon += 1;
      }
      if (data.disabled == '0') {
        kuponEnable += 1;
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKeyCart,
        backgroundColor: Colors.grey[300],
        floatingActionButton: offset > 1000
            ? FloatingActionButton(
                child: Icon(FontAwesomeIcons.chevronCircleUp),
                onPressed: () {
                  _scrollController.jumpTo(0);
                },
              )
            : null,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff25282b),
          ),
          title: Text(
            cart.isEmpty ? "Tidak Ada Item" : "Cart",
            style: TextStyle(
              color: Color(0xff25282b),
            ),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: cart.isEmpty
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(bottom: 50),
                  color: Colors.white,
                  child: EmptyCart(),
                ),
              )
            : Scrollbar(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Order Item(s)",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff25282b),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "+ Tambah",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xfffbaf18),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              height: 15.0,
                            ),
                            Container(
                              // height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: cart.map(
                                  (cart) {
                                    return CartTile(
                                      cart: cart,
                                      onIncrease: () {
                                        bloc.addToCart(cart);
                                      },
                                      onReduce: () {
                                        bloc.reduceQty(cart);
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Nama Customer ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontFamily: 'Maison Neue',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '(Optional)',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Customer pilihCustomer = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CariCustomer(
                                      customer: selectedCustomer,
                                    ),
                                  ),
                                );

                                if (pilihCustomer != null) {
                                  bloc.setCustomer(pilihCustomer);
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: selectedCustomer == null
                                          ? Text(
                                              'Pilih Customer',
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Text(
                                              selectedCustomer.namaCustomer,
                                            ),
                                    ),
                                    selectedCustomer != null
                                        ? InkWell(
                                            onTap: () {
                                              bloc.unsetCustomer();
                                            },
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          )
                                        : Icon(
                                            Icons.chevron_right,
                                            color: Colors.blue,
                                          )
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  text: 'No.Telpon Customer ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontFamily: 'Maison Neue',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: selectedCustomer == null
                                  ? Text(
                                      'Pilih Customer terlebih dahulu',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Text(
                                      selectedCustomer.noTelp,
                                    ),
                            ),
                            Divider(),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Alamat Customer ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontFamily: 'Maison Neue',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: selectedCustomer == null
                                  ? Text(
                                      'Pilih Customer terlebih dahulu',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Text(
                                      selectedCustomer.alamat,
                                    ),
                            ),
                            Divider(),
                            Container(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Catatan ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.0,
                                    fontFamily: 'Maison Neue',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: TextField(
                                minLines: 2,
                                maxLines: 4,
                                controller: bloc.catatanController,
                                onChanged: (ini) {
                                  setState(() {
                                    bloc.catatanController.value =
                                        TextEditingValue(
                                      text: ini,
                                      selection:
                                          bloc.catatanController.selection,
                                    );
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width,
                          height: 50.0,
                          buttonColor: Color(0xfffbaf18),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      CariKupon(),
                                ),
                              );
                            },
                            child: Text(
                              '$selectedKupon dari $kuponEnable Kupon Terpilih',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            elevation: 0.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 10.0, left: 10.0, top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Payment details",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xff25282b),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    height: 15.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Price(estimated)",
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14.0,
                                              color: Color(0xff25282b),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          _numberFormat.format(
                                              bloc.totalHarga.ceilToDouble()),
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14.0,
                                              color: Color(0xff25282b),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "PPN(${bloc.getSettingPpn}%)",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 14.0,
                                            color: Color(0xff25282b),
                                            fontWeight: FontWeight.w500,
                                            decoration: bloc.getSettingPpn == 0
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        ),
                                        Text(
                                          _numberFormat
                                              .format(bloc.ppn.ceilToDouble()),
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 14.0,
                                            color: Color(0xff25282b),
                                            fontWeight: FontWeight.w500,
                                            decoration: bloc.getSettingPpn == 0
                                                ? TextDecoration.lineThrough
                                                : null,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Diskon++",
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14.0,
                                              color: Color(0xff25282b),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          _numberFormat.format(
                                              bloc.totalDiskon.ceilToDouble()),
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14.0,
                                              color: Color(0xff25282b),
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    height: 15.0,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          "Total Payment",
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14.0,
                                              color: Color(0xff25282b),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          _numberFormat.format(bloc
                                              .totalHargaPenjualan
                                              .ceilToDouble()),
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14.0,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 10.0, left: 10.0, top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Pembayaran",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Color(0xff25282b),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              height: 15.0,
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Nominal Bayar',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextField(
                                    controller: bloc.jumlahBayarController,
                                    textAlign: TextAlign.end,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      NumberMask()
                                    ],
                                    keyboardType: TextInputType.number,
                                    onChanged: (ini) {
                                      if (ini.isEmpty) {
                                        ini = 0.toString();
                                      }
                                      bloc.jumlahBayarController.value =
                                          TextEditingValue(
                                        text: ini,
                                        selection: bloc
                                            .jumlahBayarController.selection,
                                      );
                                      print(ini);

                                      bloc.kembalian = bloc
                                              .totalHargaPenjualan -
                                          double.parse(ini.replaceAll(',', ''));
                                      print(bloc.kembalian);

                                      // print(_kembalian);
                                      // print(_kembalian *= -1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Kembalian",
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14.0,
                                        color: Color(0xff25282b),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    bloc.kembalian < 0
                                        ? _numberFormat.format(
                                            (bloc.kembalian *= -1)
                                                .ceilToDouble())
                                        : '(${_numberFormat.format((bloc.kembalian).ceilToDouble())})',
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 14.0,
                                        color: Color(0xff25282b),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width,
                                height: 50.0,
                                buttonColor: Color(0xfffbaf18),
                                child: RaisedButton(
                                  onPressed: _isSendRequest
                                      ? null
                                      : () {
                                          if (bloc.cart.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Pilih Item minimal 1 qty');
                                            // } else if (bloc.selectedCustomer ==
                                            //     null) {
                                            //   Fluttertoast.showToast(
                                            //       msg:
                                            //           'Pilih Customer terlebih dahulu');
                                          } else if (bloc.totalHargaPenjualan >
                                              double.parse(bloc
                                                      .jumlahBayarController
                                                      .text
                                                      .replaceAll(',', ''))
                                                  .ceilToDouble()) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Nominal Pembayaran kurang');
                                          } else {
                                            print('simpan function');
                                            simpanKasir();
                                          }
                                        },
                                  child: Text(
                                    'Checkout',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  elevation: 0.0,
                                ),
                              ),
                            ),
                            _errorMessage != ''
                                ? Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.white,
                                    child: Text(
                                      _errorMessage,
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
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
