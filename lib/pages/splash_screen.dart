import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/utils/Navigator.dart';

import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () => MyNavigator.goToLogin(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
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
                        fontSize: 30.0
                      ),
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