import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/hargaPenjualan.dart';

import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'package:provider/provider.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

List<MartabakModel> foods, foodsBackup;
String _errorMessage, _perusahaan;
Map<String, String> requestHeaders = Map();
bool _isError, _isLoading, _isCari;
KasirBloc bloc;
String dataResponseItem, dataResponseResource;

class Pointofsales extends StatefulWidget {
  Pointofsales({Key key}) : super(key: key);

  @override
  _PointofsalesState createState() => _PointofsalesState();
}

class _PointofsalesState extends State<Pointofsales> {
  final TextEditingController _searchControl = new TextEditingController();
  final NumberFormat _numberFormat =
      NumberFormat.simpleCurrency(decimalDigits: 2, name: 'Rp. ');

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

  getUserCabang() async {
    DataStore store = DataStore();
    int perusahaan = await store.getDataInteger('us_perusahaan');

    _perusahaan = perusahaan.toString();
  }

  void search() {
    foods = foodsBackup;
    List<MartabakModel> ax = List<MartabakModel>();

    for (var data in foods) {
      if (data.name.toLowerCase().contains(_searchControl.text.toLowerCase())) {
        ax.add(data);
      }
    }
    print('filter');
    print(ax);

    setState(() {
      foods = ax;
    });
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
      // get item

      final response = await http.get(
        '${url}penjualan/kasir/get/item',
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        dataResponseItem = response.body;

        bloc.clearCart();

        print(responseJson);
        foods = List<MartabakModel>();
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
          foods.add(
            MartabakModel(
              id: int.parse(data['i_id'].toString()),
              name: data['i_nama'],
              img: data['i_gambar1'],
              price: data['i_harga_jual'].toString(),
              sysprice: data['i_harga_jual'].toString(),
              desc: data['i_kode'],
              qty: 1,
              details: data['i_kode'],
              diskon: data['diskon'] != null
                  ? data['diskon']['diskon'].toString()
                  : null,
              listHargaPenjualan: _listX,
            ),
          );
        }

        foodsBackup = foods;

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

          blocX.clearKupon();

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

  void resetItemSetelahGantiGroupHarga() {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    try {
      var responseJson = jsonDecode(dataResponseItem);

      foods = List<MartabakModel>();
      for (var data in responseJson['item']) {
        var diskonX;
        var priceX;

        if (bloc.selectedHargaPenjualan != null) {
          if (bloc.selectedHargaPenjualan.id == '99999') {
            diskonX = data['diskon'] != null
                ? data['diskon']['diskon'].toString()
                : null;
            priceX = data['i_harga_jual'].toString();
          } else {
            diskonX = null;

            priceX = data['i_harga_jual'].toString();

            for (var dataS in data['harga_jual']) {
              if (data['i_id'].toString() == dataS['ghdt_item'].toString()) {
                priceX = dataS['ghdt_harga'].toString();
              }
            }
          }
        } else {
          diskonX = data['diskon'] != null
              ? data['diskon']['diskon'].toString()
              : null;

          priceX = data['i_harga_jual'].toString();
        }

        foods.add(
          MartabakModel(
            id: int.parse(data['i_id'].toString()),
            name: data['i_nama'],
            img: data['i_gambar1'],
            price: priceX,
            sysprice: priceX,
            desc: data['i_kode'],
            qty: 1,
            details: data['i_kode'],
            diskon: diskonX,
          ),
        );
      }

      foodsBackup = foods;
      Future.delayed(const Duration(milliseconds: 500), () {
        // Here you can write your code

        setState(() {
          _isLoading = false;
        });
      });
    } catch (e) {
      setState(() {
        _isError = true;
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

    resetItemSetelahGantiGroupHarga();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<KasirBloc>(context);
    // bloc.cart.clear();
    int totalCount = 0;
    if (bloc.cart.length > 0) {
      for (int i = 0; i < bloc.cart.length; i++) {
        totalCount += bloc.cart[i].qty;
      }
    }

    return GestureDetector(
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
            Tooltip(
              message: 'Setting Session',
              child: Material(
                // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                color: Colors.transparent,
                child: InkWell(
                  // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  onTap: () async {
                    Navigator.pushNamed(context, '/comp');
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    child: Icon(
                      FontAwesomeIcons.store,
                      size: 16.0,
                    ),
                  ),
                ),
              ),
            ),
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
                              '$totalCount',
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
            )
          ],
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
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
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                            top: 20.0,
                          ),
                          child: FlatButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DaftarPenjualan(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Icon(Icons.table_chart),
                                ),
                                Text('Kelola Data Nota Kasir')
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: FlatButton(
                            color: Colors.orange,
                            textColor: Colors.white,
                            onPressed: () {
                              navigatorKePengaturanHarga();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Icon(Icons.table_chart),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                          bloc.selectedHargaPenjualan != null
                                              ? FontWeight.bold
                                              : null,
                                    ),
                                    text: bloc.selectedHargaPenjualan != null
                                        ? bloc.selectedHargaPenjualan.nama
                                        : '',
                                    children: bloc.selectedHargaPenjualan !=
                                            null
                                        ? null
                                        : [
                                            TextSpan(
                                              text: '( Pilih Kelompok Harga )',
                                              style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
                            child: TextField(
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.blueGrey[700],
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                suffixIcon: _isCari
                                    ? InkWell(
                                        child: Icon(Icons.close),
                                        onTap: () {
                                          _searchControl.text = '';
                                          setState(() {
                                            _isCari = false;
                                            foods = foodsBackup;
                                          });
                                        },
                                      )
                                    : null,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
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
                                _searchControl.value = TextEditingValue(
                                  text: ini,
                                  selection: _searchControl.selection,
                                );

                                search();

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
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 20,
                            right: 20,
                          ),
                          // height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: foods.length != 0
                                  ? foods.map(
                                      (MartabakModel foods) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: InkWell(
                                            child: Container(
                                              // height: 250,
                                              width: 160,
                                              child: Column(
                                                children: <Widget>[
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: FadeInImage
                                                        .assetNetwork(
                                                      image:
                                                          '${noapiurl}storage/app/public/project/upload/1/item/${foods.id}/${foods.img}',
                                                      placeholder: foods.img,
                                                      height: 178,
                                                      width: 160,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(height: 7),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      foods.name,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                      ),
                                                      maxLines: 2,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  SizedBox(height: 3),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      foods.desc,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 13,
                                                        color: Colors
                                                            .blueGrey[300],
                                                      ),
                                                      maxLines: 1,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: null,
                                          ),
                                        );
                                      },
                                    ).toList()
                                  : [],
                            ),
                          ),
                        ),
                        Divider(
                          height: 20.0,
                          thickness: 1,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: ListView.builder(
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: foods.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: InkWell(
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'images/martabak1.jpg',
                                              image:
                                                  '${noapiurl}storage/app/public/project/upload/1/item/${foods[index].id}/${foods[index].img}',
                                              height: 70,
                                              width: 70,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 15),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                130,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    foods[index].name,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16,
                                                    ),
                                                    maxLines: 2,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    foods[index].desc,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color:
                                                          Colors.blueGrey[300],
                                                    ),
                                                    maxLines: 1,
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child:
                                                          foods[index].diskon !=
                                                                  null
                                                              ? Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: <
                                                                      Widget>[
                                                                    Text(
                                                                      _numberFormat
                                                                          .format(
                                                                        double.parse(
                                                                            foods[index].price),
                                                                      ),
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            14,
                                                                        decoration:
                                                                            TextDecoration.lineThrough,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                    Text(
                                                                      _numberFormat
                                                                          .format(
                                                                        double.parse(foods[index].price) -
                                                                            double.parse(foods[index].diskon),
                                                                      ),
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                      maxLines:
                                                                          1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                    ),
                                                                  ],
                                                                )
                                                              : Text(
                                                                  _numberFormat
                                                                      .format(
                                                                    double.parse(
                                                                        foods[index]
                                                                            .price),
                                                                  ),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                    ),
                                                    Container(
                                                      child: ButtonTheme(
                                                        minWidth: 25.0,
                                                        height: 25.0,
                                                        buttonColor:
                                                            Color(0xfffbaf18),
                                                        child: RaisedButton(
                                                          onPressed: () {
                                                            bloc.addToCart(
                                                                foods[index]);
                                                          },
                                                          child: const Text(
                                                              'Tambah',
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .white)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      bloc.addToCart(foods[index]);
                                    }),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
