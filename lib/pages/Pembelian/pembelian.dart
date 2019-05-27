import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:martabakdjoeragan_app/presentation/custom_icon_icons.dart';
import 'package:async/async.dart';

import 'package:martabakdjoeragan_app/pages/Pembelian/pemesanan_pembelian.dart' as tab1;
import 'package:martabakdjoeragan_app/pages/Pembelian/pembelian_pesanan.dart' as tab2;
import 'package:martabakdjoeragan_app/pages/Pembelian/return_pembelian.dart' as tab3;
import 'package:martabakdjoeragan_app/pages/Pembelian/pembayaran_supplier.dart' as tab4;

class PembelianPage extends StatefulWidget {
  @override
  _PembelianPageState createState() => _PembelianPageState();
}

class _PembelianPageState extends State<PembelianPage> with SingleTickerProviderStateMixin {
  TabController controller;


  @override
  void initState() {
    controller = new TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: new Text(
          "Pembelian",
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xfffbaf18),
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(CustomIcon.cart_plus),
            ),
            new Tab(
              icon: new Icon(CustomIcon.sticky_note_o),
            ),
            new Tab(
                icon: new Icon(CustomIcon.cw),
            ),
            new Tab(
              icon: new Icon(CustomIcon.credit_card_alt),
            )
          ],
        ),
      ),
      body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new tab1.PemesananPembelianPage(),
            new tab2.PembelianPesananPage(),
            new tab3.ReturnPembelianPage(),
            new tab4.PembayaranSupplierPage()
          ],
      ),
    );
  }
}


