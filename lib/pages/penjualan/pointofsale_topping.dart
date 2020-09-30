import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

enum TipeTombol {
  tambah,
  edit,
}

class PilihTopping extends StatefulWidget {
  // final String name;
  // final List<MartabakVarianModel> listVarian;
  // final List<ToppingMartabakModel> listTopping;
  // final int qty;
  final MartabakModel martabak;

  /// Jika @params tipe = TipeTombol.edit, maka @params index wajib di isi
  final int index;
  final TipeTombol tipe;
  PilihTopping({
    this.martabak,
    // this.qty,
    // this.listTopping,
    // this.listVarian,
    // this.name,
    this.index,
    @required this.tipe,
    Key key,
  }) : super(key: key);
  @override
  _PilihToppingState createState() => _PilihToppingState();
}

class _PilihToppingState extends State<PilihTopping> {
  TextEditingController qtyController;
  FocusNode qtyFocus;

  List<ToppingMartabakModel> _listTopping = List<ToppingMartabakModel>();

  List<MartabakVarianModel> _listVarian = List<MartabakVarianModel>();

  @override
  void initState() {
    qtyController = TextEditingController(
      text:
          widget.tipe == TipeTombol.edit ? widget.martabak.qty.toString() : '1',
    );
    qtyFocus = FocusNode();
    _listTopping = List<ToppingMartabakModel>();
    _listVarian = List<MartabakVarianModel>();

    KasirBloc blocX = context.read<KasirBloc>();
    _listTopping = blocX.decodeListTopping(widget.martabak.listTopping);
    _listVarian = blocX.decodeListVarian(widget.martabak.listVarian);
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text(widget.martabak.name),
          actions: widget.tipe == TipeTombol.edit
              ? <Widget>[
                  IconButton(
                    tooltip: 'Hapus',
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('Peringatan!'),
                          content: Text(
                              'Apa anda yakin ingin menghapus item dari keranjang?'),
                          actions: <Widget>[
                            FlatButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              onPressed: () {
                                KasirBloc bloc = Provider.of<KasirBloc>(context,
                                    listen: false);
                                bloc.deleteCart(widget.index);
                                Navigator.popUntil(
                                  context,
                                  ModalRoute.withName('/cart_pos'),
                                );
                              },
                              child: Text('Ya'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Tidak'),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ]
              : null,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            List<String> validasi = List();
            bool isVarianSelected = false;

            for (var data in _listVarian) {
              if (data.isSelected) {
                isVarianSelected = true;
                break;
              }
            }

            if (!isVarianSelected && _listVarian.length != 0) {
              validasi.add('Pilih Varian terlebih dahulu');
            }

            if (qtyController.text.isEmpty) {
              validasi.add('Input jumlah tidak boleh kosong');
            }

            if (validasi.length == 0) {
              print('true');
              Map mapX = {
                'tipe': widget.tipe,
                'listTopping': json.encode(_listTopping),
                'listVarian': json.encode(_listVarian),
                'qty': int.parse(qtyController.text)
              };

              Navigator.pop(context, mapX);
            } else {
              for (var data in validasi) {
                Fluttertoast.showToast(msg: data);
              }
            }
          },
          label: Text(widget.tipe == TipeTombol.tambah ? 'Pilih' : 'Simpan'),
          icon: Icon(Icons.check),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _listVarian.length == 0
                      ? Container()
                      : Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.orange,
                              child: Text(
                                'Varian',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Column(
                              children: _listVarian.length == 0
                                  ? <Widget>[
                                      Container(),
                                    ]
                                  : _listVarian.map(
                                      (e) {
                                        return VarianTile(
                                          text: e.namaVarian,
                                          price: e.hargaVarian,
                                          isSelected: e.isSelected,
                                          onTap: () {
                                            for (var data in _listVarian) {
                                              if (data.idVarian != e.idVarian) {
                                                setState(() {
                                                  data.isSelected = false;
                                                });
                                              } else if (data.idVarian ==
                                                  e.idVarian) {
                                                setState(() {
                                                  data.isSelected =
                                                      !data.isSelected;
                                                });
                                              }
                                            }
                                          },
                                        );
                                      },
                                    ).toList(),
                            ),
                          ],
                        ),
                  _listTopping.length == 0
                      ? Container()
                      : Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              color: Colors.orange,
                              child: Text(
                                'Topping',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Column(
                              children: _listTopping.length == 0
                                  ? <Widget>[
                                      Container(),
                                    ]
                                  : _listTopping.map(
                                      (e) {
                                        return Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              child: Text(
                                                e.namaTopping,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                children: e.listTopping
                                                            .length ==
                                                        0
                                                    ? [
                                                        Container(),
                                                      ]
                                                    : e.listTopping.map(
                                                        (ed) {
                                                          return ToppingTile(
                                                            price:
                                                                ed.hargaTopping,
                                                            text:
                                                                ed.namaTopping,
                                                            isSelected:
                                                                ed.isSelected,
                                                            onTap: () {
                                                              setState(() {
                                                                ed.isSelected =
                                                                    !ed.isSelected;
                                                              });
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ).toList(),
                            ),
                          ],
                        ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Jumlah',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          padding: EdgeInsets.all(12),
                          onPressed: () {
                            String ini = qtyController.text != ''
                                ? qtyController.text
                                : '0';
                            String decrement =
                                (int.parse(ini) == 1 ? 1 : (int.parse(ini) - 1))
                                    .toString();

                            setState(() {
                              qtyController.text = decrement;
                            });
                          },
                          color: Colors.orange,
                          textColor: Colors.white,
                          child: Icon(
                            FontAwesomeIcons.minus,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Jumlah',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            controller: qtyController,
                            focusNode: qtyFocus,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly,
                            ],
                            keyboardType: TextInputType.number,
                            onChanged: (ini) {
                              qtyController.value = TextEditingValue(
                                selection: qtyController.selection,
                                text: ini,
                              );
                            },
                          ),
                        ),
                        FlatButton(
                          padding: EdgeInsets.all(12),
                          onPressed: () {
                            String ini = qtyController.text != ''
                                ? qtyController.text
                                : '0';
                            String increment =
                                ((int.parse(ini) + 1)).toString();

                            setState(() {
                              qtyController.text = increment;
                            });
                          },
                          color: Colors.orange,
                          textColor: Colors.white,
                          child: Icon(
                            FontAwesomeIcons.plus,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToppingTile extends StatelessWidget {
  final String text;
  final double price;
  final Function onTap;
  final bool isSelected;

  final NumberFormat _numberFormat = NumberFormat.simpleCurrency(
    decimalDigits: 0,
    name: 'Rp. ',
  );

  ToppingTile({
    this.price,
    this.onTap,
    this.text,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: isSelected
            ? null
            : Border.all(
                color: Colors.black54,
                width: 1,
              ),
        borderRadius: BorderRadius.circular(5),
        color: isSelected ? Colors.orangeAccent : Colors.white,
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              Text(
                _numberFormat.format(price),
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VarianTile extends StatelessWidget {
  final String text;
  final double price;
  final Function onTap;
  final bool isSelected;

  final NumberFormat _numberFormat = NumberFormat.simpleCurrency(
    decimalDigits: 0,
    name: 'Rp. ',
  );

  VarianTile({
    this.price,
    this.onTap,
    this.text,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? Colors.orange : Colors.black,
                ),
              ),
              Text(
                _numberFormat.format(price),
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? Colors.orange : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
