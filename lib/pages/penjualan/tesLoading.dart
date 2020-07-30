import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_loading.dart';
// ignore: unused_import
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_loading.dart';
// ignore: unused_import
import 'package:martabakdjoeragan_app/pages/penjualan/pointofsales_loading.dart';

class TesLoading extends StatefulWidget {
  @override
  _TesLoadingState createState() => _TesLoadingState();
}

class _TesLoadingState extends State<TesLoading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tes Loading'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CompHeaderLoading(),
            CompContentLoading(),
            CompFooterLoading(),
          ],
        ),
      ),
    );
  }
}
