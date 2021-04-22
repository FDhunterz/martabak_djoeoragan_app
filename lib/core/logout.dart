import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/core/api.dart';

void logout(BuildContext context) {
  showDialog(
    context: context,
    builder: (c) => AlertDialog(
      backgroundColor: Color(0xfff85f73),
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      title: Text('Peringatan!'),
      content: Text('Apa anda ingin keluar dari aplikasi?'),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            await Auth().logout(context);
          },
          child: Text('Ya'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text('Tidak'),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
          ),
        ),
      ],
    ),
  );
}
