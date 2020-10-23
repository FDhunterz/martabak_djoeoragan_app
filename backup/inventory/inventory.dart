import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:martabakdjoeragan_app/pages/inventory/tab_3.dart';
import 'tab_1.dart';
import 'tab_2.dart';
import 'tab_3.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  // var scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;

  List _widgetOptions = [
    InventoryTab1(),
    InventoryTab2(),
    InventoryTab3(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 56, 70, 1),
          title: Text('Inventory'),
          leading: Material(
            color: Color.fromRGBO(41, 56, 70, 1),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/dashboard', (Route<dynamic> route) => false);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 0.0),
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ]),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: ('Laporan'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.listAlt),
                label: ('Data Stok'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.clipboard),
                label: ('Opname'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
