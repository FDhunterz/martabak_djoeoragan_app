import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:intl/intl.dart';

class POSTileHorizontal extends StatelessWidget {
  final String id, nama, gambar, desc;
  final Function onTap;

  POSTileHorizontal({
    this.desc,
    this.gambar,
    this.id,
    this.nama,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        child: Container(
          // height: 250,
          width: 160,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  image:
                      '${noapiurl}storage/app/public/project/upload/1/item/$id/$gambar',
                  placeholder: 'images/martabak1.jpg',
                  height: 178,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 7),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  desc,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.blueGrey[300],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class POSTileVertical extends StatelessWidget {
  final String id, nama, gambar, desc, diskon, harga;
  final Function onIncrease;

  final NumberFormat _numberFormat =
      NumberFormat.simpleCurrency(decimalDigits: 0, name: 'Rp. ');

  POSTileVertical({
    this.desc,
    this.diskon,
    this.gambar,
    this.harga,
    this.id,
    this.nama,
    this.onIncrease,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'images/martabak1.jpg',
                    image:
                        '${noapiurl}storage/app/public/project/upload/1/item/$id/$gambar',
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width - 130,
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          nama,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          desc,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.blueGrey[300],
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: diskon != null
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        _numberFormat.format(
                                          double.parse(harga),
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        _numberFormat.format(
                                          double.parse(harga) -
                                              double.parse(diskon),
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
                                : Container(
                                    child: Text(
                                      _numberFormat.format(
                                        double.parse(harga),
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                          ),
                          ButtonTheme(
                            minWidth: 25.0,
                            height: 25.0,
                            buttonColor: Color(0xfffbaf18),
                            child: RaisedButton(
                              onPressed: onIncrease,
                              child: const Text(
                                'Tambah',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: onIncrease,
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String tooltip, namaMenu;
  final Function onTap;
  final IconData icon;

  MenuTile({
    this.icon,
    this.namaMenu,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        textStyle: TextStyle(
          color: Colors.white,
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 70,
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Icon(
                    icon,
                    size: 18.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Text(
                    namaMenu,
                    textAlign: TextAlign.center,
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
