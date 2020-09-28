import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/ImageToFile/ImageToFile.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:intl/intl.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class CartTile extends StatefulWidget {
  final MartabakModel cart;

  final Function onReduce, onIncrease, onTap;

  CartTile({
    this.cart,
    this.onIncrease,
    this.onReduce,
    this.onTap,
  });

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  NumberFormat numberFormat =
      NumberFormat.simpleCurrency(decimalDigits: 0, name: 'Rp. ');

  String holding;

  void getHolding() async {
    DataStore store = DataStore();

    int holdingX = await store.getDataInteger('us_holding');

    setState(() {
      holding = holdingX.toString();
    });
  }

  Widget selectedTopping() {
    if (widget.cart.listTopping.length != 0) {
      String selectedTopping = '';
      for (var data in widget.cart.listTopping) {
        for (int i = 0; i < data.listTopping.length; i++) {
          var dataD = data.listTopping[i];
          if (dataD.isSelected) {
            if (i == 0) {
              selectedTopping += dataD.namaTopping;
            } else {
              selectedTopping += ', ${dataD.namaTopping}';
            }
          }
        }
      }

      return Column(
        children: <Widget>[
          Text(
            selectedTopping,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 14,
            ),
          ),
        ],
      );
    }

    return Container();
  }

  @override
  void initState() {
    getHolding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String namaVarianSelected = '';
    for (var data in widget.cart.listVarian) {
      if (data.isSelected) {
        namaVarianSelected = ' (${data.namaVarian})';
        break;
      }
    }
    double harga = 0;
    double listHargaVarian = 0;
    double listHargaTopping = 0;

    if (widget.cart.listVarian.length == 0) {
      harga = double.parse(widget.cart.price);
    }

    for (var data in widget.cart.listVarian) {
      if (data.isSelected) {
        listHargaVarian += data.hargaVarian;
      }
    }

    for (var dataT in widget.cart.listTopping) {
      for (var dataTD in dataT.listTopping) {
        if (dataTD.isSelected) {
          listHargaTopping += dataTD.hargaTopping;
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace stackTrace) {
                    // Appropriate logging or analytics, e.g.
                    // myAnalytics.recordError(
                    //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                    //   exception,
                    //   stackTrace,
                    // );
                    return Image.asset(
                      'images/martabak1.jpg',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    );
                  },
                  image: NetworkToFileImage(
                    url:
                        '${noapiurl}storage/app/public/project/upload/$holding/item/${widget.cart.id}/${widget.cart.img}',
                    file: fileFromDocsDir(widget.cart.img),
                    debug: true,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Container(
                // height: 80,
                width: MediaQuery.of(context).size.width - 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: widget.cart.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: namaVarianSelected,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    selectedTopping(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: widget.cart.diskon != null
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      numberFormat.format(
                                        harga +
                                            listHargaTopping +
                                            listHargaVarian,
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      numberFormat.format(
                                        harga +
                                            listHargaTopping +
                                            listHargaVarian -
                                            double.parse(widget.cart.diskon),
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                )
                              : Text(
                                  numberFormat.format(
                                    harga + listHargaTopping + listHargaVarian,
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Card(
                              color: Colors.white,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: widget.onReduce,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        FontAwesomeIcons.minus,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(7),
                                    child: Text(
                                      widget.cart.qty.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: widget.onIncrease,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Icon(
                                        FontAwesomeIcons.plus,
                                        size: 15,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
