import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/core/api.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_bloc.dart';
// import 'package:martabakdjoeragan_app/utils/Navigator.dart';

import 'dart:async';

import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  redirect() async {
    List head = ['access_token'];
    dynamic login = await Auth(getDataString: head).getsession();

    DataStore store = DataStore();

    CompBloc bloc = Provider.of<CompBloc>(context);

    String comp = bloc.selectedOutlet != null
        ? bloc.selectedOutlet.id
        : 'Tidak ditemukan';

    print(login['access_token']);
    if (login['access_token'] != 'Tidak ditemukan' &&
        comp != 'Tidak ditemukan') {
      Timer(Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, "/pos"));
    } else if (comp == 'Tidak ditemukan' &&
        login['access_token'] != 'Tidak ditemukan') {
      Timer(Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, "/comp"));
    } else {
      Timer(Duration(seconds: 2),
          () => Navigator.pushReplacementNamed(context, "/login"));
    }
  }

  @override
  void initState() {
    redirect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Text(
                      "Martabak Djoeragan",
                      style: TextStyle(
                          color: Color(0xfffbaf18),
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
