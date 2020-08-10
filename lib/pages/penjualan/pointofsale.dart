import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/core/api.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/cariPrint.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/hargaPenjualan.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/pointofsales_loading.dart';
// ignore: unused_import
import 'package:martabakdjoeragan_app/pages/penjualan/tesLoading.dart';

import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
// ignore: unused_import
import 'package:martabakdjoeragan_app/utils/print_icon/print_icon_icons.dart';
import 'package:provider/provider.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pointofsale_tile.dart';
import 'dart:async';

// List<MartabakModel> foods, foodsBackup;
String _errorMessage, _perusahaan;
Map<String, String> requestHeaders = Map();
bool _isError, _isLoading, _isCari;
DateTime backbuttonpressedTime;

// String dataResponseItem, dataResponseResource;

class Pointofsales extends StatefulWidget {
  Pointofsales({Key key}) : super(key: key);

  @override
  _PointofsalesState createState() => _PointofsalesState();
}

class _PointofsalesState extends State<Pointofsales> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  void initState() {
    _isLoading = false;
    _isCari = false;
    _isError = false;
    resource();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getUserCabang() async {
    DataStore store = DataStore();
    int perusahaan = await store.getDataInteger('us_perusahaan');

    _perusahaan = perusahaan.toString();
  }

  void resource() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    DataStore dataStore = DataStore();
    String accessToken = await dataStore.getDataString('access_token');

    requestHeaders['Accept'] = 'application/json';
    requestHeaders['Authorization'] = 'Bearer $accessToken';

    try {
      // get item

      final response = await http.get(
        '${url}penjualan/kasir/get/item',
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        // dataResponseItem = response.body;

        KasirBloc blocX = Provider.of<KasirBloc>(context);

        blocX.setEncodedRequest(response.body);

        blocX.clearCart();

        print(responseJson);

        blocX.clearListItem();

        for (var data in responseJson['item']) {
          List<HargaPenjualanPerItem> _listX = List();
          for (var dataS in data['harga_jual']) {
            _listX.add(
              HargaPenjualanPerItem(
                idItem: dataS['ghdt_item'].toString(),
                harga: dataS['ghdt_harga'].toString(),
                idGroup: dataS['ghdt_group'].toString(),
              ),
            );
          }
          blocX.addItem(
            MartabakModel(
              id: int.parse(data['i_id'].toString()),
              name: data['i_nama'],
              img: data['i_gambar1'],
              price: data['i_harga_jual'].toString(),
              sysprice: data['i_harga_jual'].toString(),
              desc: data['i_kode'],
              qty: 1,
              idKategoriItem: data['i_kategori'].toString(),
              details: data['i_kode'],
              diskon: data['diskon'] != null
                  ? data['diskon']['diskon'].toString()
                  : null,
              listHargaPenjualan: _listX,
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
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = response.body;
        });
      }

      // get resouce
      if (!_isError) {
        setState(() {
          _isLoading = true;
          _isError = false;
        });

        String link = '${url}penjualan/kasir/resource?cabangs=$_perusahaan';

        final responseX = await http.get(
          link,
          headers: requestHeaders,
        );

        if (responseX.statusCode == 200) {
          dynamic responseJson = jsonDecode(responseX.body);
          print(responseJson);

          KasirBloc blocX = Provider.of<KasirBloc>(context);

          blocX.clearListKategori();

          blocX.clearKupon();
          KategoriItem kategori = KategoriItem(
            id: 'all',
            text: 'Semua Item',
          );
          blocX.addKategori(
            kategori,
          );
          blocX.setSelectedKategori(
            kategori,
          );
          for (var data in responseJson['kategori']) {
            blocX.addKategori(
              KategoriItem(
                id: data['id'].toString(),
                text: data['text'],
              ),
            );
          }

          for (var i in responseJson['diskon']) {
            blocX.addKupon(
              kupon: KuponBelanja(
                id: i['d_id'].toString(),
                nama: i['d_nama'],
                catatan: i['d_catatan'],
                dMaxDiskon: i['d_max_diskon'].toString(),
                dPersen: i['d_persen'].toString(),
                kategoriHarga: i['d_kategori_harga'].toString(),
                selected: i['selected'].toString(),
                disabled: i['disabled'].toString(),
                dIsDouble: i['d_isdouble'].toString(),
                nominal: i['d_nominal'].toString(),
              ),
            );
          }

          blocX.clearHargaPenjualan();
          blocX.unsetSelectedHargaPenjualan();

          blocX.addHargaPenjualan(
            HargaPenjualan(
              id: '99999',
              nama: 'Harga Normal',
              selected: '0',
            ),
          );

          print('${responseJson['harga'].length} responseJson[harga] length');

          for (var j in responseJson['harga']) {
            print('harga added');
            blocX.addHargaPenjualan(
              HargaPenjualan(
                id: j['gh_id'].toString(),
                nama: j['gh_nama'],
                selected: j['selected'].toString(),
              ),
            );
          }

          blocX.settingPPN(
            double.parse(
              responseJson['setting_ppn']['hs_pajak_kasir'].toString(),
            ),
          );

          setState(() {
            _isLoading = false;
            _isError = false;
          });

          navigatorKePengaturanHarga();
        } else if (responseX.statusCode == 401) {
          Fluttertoast.showToast(
            msg: 'Token kedaluwarsa, silahkan login kembali',
          );
          setState(() {
            _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
            _isLoading = false;
            _isError = true;
          });
        } else {
          Fluttertoast.showToast(msg: 'Error Code = ${responseX.statusCode}');
          Map responseJson = jsonDecode(responseX.body);

          if (responseJson.containsKey('message')) {
            Fluttertoast.showToast(msg: responseJson['message']);
          }
          print(jsonDecode(responseX.body));
          setState(() {
            _isLoading = false;
            _isError = true;
            _errorMessage = responseX.body;
          });
        }
      }
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
      setState(() {
        _isError = true;
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void navigatorKePengaturanHarga() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CariHargaPenjualan(),
      ),
    );
    KasirBloc blocX = Provider.of<KasirBloc>(context);

    blocX.resetItemSetelahGantiGroupHarga(
      onStart: () {
        setState(() {
          _isLoading = true;
          _isError = false;
          _errorMessage = '';
        });
      },
      onFinish: () {
        setState(() {
          _isLoading = false;
        });
      },
      onError: (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = e;
          _isError = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    KasirBloc bloc = Provider.of<KasirBloc>(context);
    // bloc.cart.clear();

    return WillPopScope(
      onWillPop: () async {
        DateTime currentTime = DateTime.now();
        //Statement 1 Or statement2
        bool backButton = backbuttonpressedTime == null ||
            currentTime.difference(backbuttonpressedTime) >
                Duration(seconds: 3);
        if (backButton) {
          backbuttonpressedTime = currentTime;
          Fluttertoast.showToast(
            msg: "Tekan lagi untuk keluar dari aplikasi",
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Color(0xff25282b),
            ),
            title: Text(
              "Point Of Sales",
              style: TextStyle(
                color: Color(0xff25282b),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height: 150.0,
                  width: 30.0,
                  child: InkWell(
                    onTap: () async {
                      dynamic cart = await Navigator.pushNamed(
                        context,
                        '/cart_pos',
                      );

                      if (cart == true) {
                        resource();
                      }
                    },
                    child: Stack(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Color(0xff25282b),
                          ),
                          onPressed: null,
                        ),
                        Positioned(
                          top: 0.0,
                          left: 0.0,
                          child: Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Colors.red[700],
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Center(
                              child: Text(
                                bloc.totalQtyKeranjang.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              PopupMenuButton(
                tooltip: 'Pengaturan',
                icon: Icon(FontAwesomeIcons.ellipsisV),
                itemBuilder: (BuildContext context) =>
                    ['Daftar Perangkat USB', 'Logout']
                        .map(
                          (e) => PopupMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                onSelected: (ini) {
                  switch (ini) {
                    case 'Logout':
                      showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                          backgroundColor: Color(0xfff85f73),
                          contentTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          titleTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          title: Text('Peringatan!'),
                          content: Text('Apa anda ingin keluar dari aplikasi?'),
                          actions: <Widget>[
                            RaisedButton(
                              onPressed: () async {
                                await Auth().logout(context);
                              },
                              child: Text('Ya'),
                              color: Colors.blue,
                              textColor: Colors.white,
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text('Tidak'),
                              color: Colors.white,
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                      );

                      break;
                    case 'Daftar Perangkat USB':
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CariPrint(),
                        ),
                      );
                      break;
                    default:
                  }
                },
              ),
            ],
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: _isLoading
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      FiturPOSLoading(),
                      SearchLoading(),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            POSTileVerticalLoading(),
                            POSTileVerticalLoading(),
                            POSTileVerticalLoading(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : _isError
                  ? ErrorOutputWidget(
                      errorMessage: _errorMessage,
                      onPress: () {
                        resource();
                      },
                    )
                  : RefreshIndicator(
                      onRefresh: () {
                        resource();
                        setState(() {
                          _searchControl.text = '';
                          _isCari = false;
                        });
                        return Future.value('');
                      },
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff4c1b37),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color(0xff76273c),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Fitur Point Of Sales',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    alignment: WrapAlignment.center,
                                    children: <Widget>[
                                      MenuTile(
                                        tooltip: 'Kelola Data Nota Kasir',
                                        icon: FontAwesomeIcons.clipboardList,
                                        namaMenu: 'Data Kasir',
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DaftarPenjualan(),
                                            ),
                                          );
                                        },
                                      ),
                                      MenuTile(
                                        icon: FontAwesomeIcons.tags,
                                        namaMenu: 'Golongan Harga',
                                        tooltip: 'Golongan Harga',
                                        onTap: () {
                                          navigatorKePengaturanHarga();
                                        },
                                      ),
                                      MenuTile(
                                        tooltip: 'Setting Session',
                                        icon: FontAwesomeIcons.store,
                                        namaMenu: 'Pilih Outlet',
                                        onTap: () {
                                          Navigator.pushNamed(context, '/comp');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.blueGrey[700],
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      suffixIcon: _isCari
                                          ? InkWell(
                                              child: Icon(Icons.close),
                                              onTap: () {
                                                setState(() {
                                                  _searchControl.text = '';
                                                  _isCari = false;
                                                });
                                              },
                                            )
                                          : null,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xfffbaf18),
                                          width: 2,
                                        ),
                                      ),
                                      hintText: "Pencarian",
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: Colors.blueGrey[500],
                                      ),
                                      hintStyle: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.blueGrey[400],
                                      ),
                                    ),
                                    maxLines: 1,
                                    controller: _searchControl,
                                    onChanged: (ini) {
                                      setState(() {
                                        _searchControl.value = TextEditingValue(
                                          text: ini,
                                          selection: _searchControl.selection,
                                        );
                                      });

                                      if (ini.length != 0) {
                                        setState(() {
                                          _isCari = true;
                                        });
                                      } else {
                                        setState(() {
                                          _isCari = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                DropdownButton(
                                  isDense: true,
                                  underline: Container(),
                                  items: bloc.listKategori
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Text(e.text),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  hint: Text('Pilih Kategori'),
                                  value: bloc.getSelectedKategoriItem,
                                  onChanged: (e) {
                                    bloc.setSelectedKategori(e);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 20.0,
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  bloc.cariItem(_searchControl.text).length != 0
                                      ? bloc
                                          .cariItem(_searchControl.text)
                                          .map(
                                            (MartabakModel e) =>
                                                POSTileVertical(
                                              id: e.id.toString(),
                                              desc: e.desc,
                                              gambar: e.img,
                                              nama: e.name,
                                              diskon: e.diskon,
                                              harga: e.price,
                                              onIncrease: () {
                                                bloc.addToCart(e);
                                              },
                                            ),
                                          )
                                          .toList()
                                      : <Widget>[
                                          ListTile(
                                            title: Text(
                                              'Tidak ada Data',
                                              textAlign: TextAlign.center,
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
    );
  }
}
