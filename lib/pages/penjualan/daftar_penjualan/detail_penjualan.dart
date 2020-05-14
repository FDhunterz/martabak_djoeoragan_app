import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_model.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/itemTile.dart';
import 'package:intl/intl.dart';

GlobalKey<ScaffoldState> _scaffoldKeyDaftarPenjualan;

class DetailPenjualan extends StatefulWidget {
  final NotaPenjualan nota;

  DetailPenjualan({
    this.nota,
  });

  @override
  _DetailPenjualanState createState() => _DetailPenjualanState();
}

class _DetailPenjualanState extends State<DetailPenjualan> {
  NumberFormat numberFormat = NumberFormat.simpleCurrency(
    name: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    _scaffoldKeyDaftarPenjualan = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKeyDaftarPenjualan,
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text('Detail Nota'),
        iconTheme: IconThemeData(
          color: Color(0xff25282b),
        ),
        textTheme: TextTheme(
          // title: TextStyle(
          //   color: Colors.white,
          //   fontSize: 18.0,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
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
                        text: 'Nota ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.nota.nota,
                    ),
                  ),
                  Divider(),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: 'Tanggal Pembelian ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.nota.tanggal,
                    ),
                  ),
                  Divider(),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: 'Nama Customer ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.nota.customer,
                    ),
                  ),
                  Divider(),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: 'Telepon Customer ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.nota.telpon,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.nota.alamat,
                    ),
                  ),
                  Divider(),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: 'User Yang Melayani ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.nota.kasir,
                    ),
                  ),
                  Divider(),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: 'Kelompok Harga ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.nota.harga,
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Item(s)",
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
                    // height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.nota.detailNotaPenjualan.length != 0
                          ? widget.nota.detailNotaPenjualan
                              .map(
                                (f) => ItemTile(
                                  item: f,
                                ),
                              )
                              .toList()
                          : [
                              ListTile(
                                title: Text(
                                  'Tidak Ada Data',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                    ),
                  ),
                ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                numberFormat
                                    .format(double.parse(widget.nota.subTotal)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "PPN(10%)",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                numberFormat
                                    .format(double.parse(widget.nota.pajak)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                numberFormat.format(
                                    double.parse(widget.nota.diskonPlus)),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                numberFormat.format(
                                    double.parse(widget.nota.grandTotal)),
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
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Jumlah Bayar",
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14.0,
                              color: Color(0xff25282b),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          numberFormat.format(double.parse(widget.nota.bayar)),
                          style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14.0,
                              color: Color(0xff25282b),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
