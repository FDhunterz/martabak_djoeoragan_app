import 'package:flutter/material.dart';

class MyNavigator {
  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }
  static void goToDashboard(BuildContext context) {
    Navigator.pushNamed(context, "/dashboard");
  }
  static void goToMaster(BuildContext context) {
    Navigator.pushNamed(context, "/master");
  }
  static void goToPembelian(BuildContext context) {
    Navigator.pushNamed(context, "/pembelian");
  }
  static void goToPOS(BuildContext context) {
    Navigator.pushNamed(context, "/pos");
  }

}