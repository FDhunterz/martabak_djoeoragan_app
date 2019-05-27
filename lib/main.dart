import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/dashboard.dart';
import 'package:martabakdjoeragan_app/pages/login.dart';
import 'package:martabakdjoeragan_app/pages/splash_screen.dart';
import 'package:martabakdjoeragan_app/pages/master.dart';
import 'package:martabakdjoeragan_app/pages/Pembelian/pembelian.dart';

var routes1 = <String, WidgetBuilder>{
  "/login": (BuildContext context) => LoginPage(),
  "/dashboard": (BuildContext context) => DashboardPage(),
  "/master": (BuildContext context) => MasterPage(),
  "/pembelian" : (BuildContext context) => PembelianPage(),
};

void main() {
  runApp(new MaterialApp(
    title: "Martabak Djoeragan",
    home: new SplashScreen(),
    theme: new ThemeData(fontFamily: 'Roboto'),
    debugShowCheckedModeBanner: false,
    routes: routes1,
  ));
}

ThemeData buildDarkTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    primaryColor: Color(0xff25282b),
    accentColor: Color(0xfffbaf18),
    scaffoldBackgroundColor: Colors.white,
    buttonColor: Color(0xfffbaf18),
    hintColor: Color(0xfffbaf18),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      labelStyle: TextStyle(
          color: Color(0xff25282b),
          fontSize: 24.0
      ),
    ),
  );
}

