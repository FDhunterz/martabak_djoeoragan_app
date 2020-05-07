import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/dashboard.dart';
import 'package:martabakdjoeragan_app/pages/diskon/diskon.dart';
import 'package:martabakdjoeragan_app/pages/diskon/tambahDiskon.dart';
import 'package:martabakdjoeragan_app/pages/login.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/cart.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_bloc.dart';
import 'package:martabakdjoeragan_app/pages/splash_screen.dart';
import 'package:martabakdjoeragan_app/pages/master.dart';
import 'package:martabakdjoeragan_app/pages/Pembelian/pembelian.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/pointofsale.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:provider/provider.dart';
import 'pages/inventory/inventory.dart';
import 'pages/inventory/tambah_opname.dart';

var routes = <String, WidgetBuilder>{
  "/dashboard": (BuildContext context) => DashboardPage(),
  "/login": (BuildContext context) => LoginPage(),
  "/master": (BuildContext context) => MasterPage(),
  "/pembelian": (BuildContext context) => PembelianPage(),
  "/pos": (BuildContext context) => Pointofsales(),
  "/cart_pos": (BuildContext context) => CartPage(),
  "/inventory": (BuildContext context) => Inventory(),
  "/opname": (BuildContext context) => TambahOpname(),
  "/splash": (BuildContext context) => SplashScreen(),
  "/diskon": (BuildContext context) => ViewDiskon(),
  "/tambah_diskon": (BuildContext context) => TambahDiskon(),
};

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<KasirBloc>(builder: (context) => KasirBloc()),
        ChangeNotifierProvider<DaftarPenjualanBloc>(
            builder: (context) => DaftarPenjualanBloc()),
      ],
      child: MaterialApp(
        title: "Martabak Djoeragan",
        theme: buildDarkTheme(),
        home: new SplashScreen(),
        debugShowCheckedModeBanner: false,
        routes: routes,
      ),
    );
  }
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData(
      // fontFamily: 'TitilliumWeb',
      );
  return base.copyWith(
    primaryColor: Color(0xff25282b),
    accentColor: Color(0xfffbaf18),
    scaffoldBackgroundColor: Colors.white,
    buttonColor: Color(0xfffbaf18),
    // hintColor: Color(0xfffbaf18),

    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.grey,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1.0,
          color: Colors.grey,
        ),
      ),
      labelStyle: TextStyle(
        color: Color(0xff25282b),
        fontSize: 14,
      ),
      hintStyle: TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    ),
  );
}
