import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:martabakdjoeragan_app/core/api.dart';
import 'package:martabakdjoeragan_app/pages/profile.dart';
import 'package:flutter/services.dart';
// import 'package:martabakdjoeragan_app/utils/Navigator.dart';
// import 'package:martabakdjoeragan_app/core/api.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: <Widget>[
        //       UserAccountsDrawerHeader(
        //         accountName: Text('Kim Jisoo'),
        //         accountEmail: Text('Jisoocu@gmail.com'),
        //         currentAccountPicture: CircleAvatar(
        //           backgroundImage: AssetImage('images/jisoocu.jpg'),
        //         ),
        //         decoration: BoxDecoration(
        //           color: Color(0xfffbaf18),
        //         ),
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.view_list),
        //         title: Text(
        //           'Data  Master',
        //           style: TextStyle(
        //             fontSize: 16.0,
        //             fontFamily: 'Roboto',
        //             color: Color(0xff25282b),
        //           ),
        //         ),
        //         onTap: () {
        //           // Navigator.pop(context);
        //           MyNavigator.goToMaster(context);
        //         },
        //       ),
        //       ListTile(
        //         leading: Icon(Icons.view_list),
        //         title: Text(
        //           'Pembelian',
        //           style: TextStyle(
        //             fontSize: 16.0,
        //             fontFamily: 'Roboto',
        //             color: Color(0xff25282b),
        //           ),
        //         ),
        //         onTap: () {
        //           // Navigator.pop(context);
        //           MyNavigator.goToPembelian(context);
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 56, 70, 1),
          title: Text('Dashboard'),
          actions: <Widget>[
            Material(
              // borderRadius: BorderRadius.all(Radius.circular(50.0)),
              color: Color.fromRGBO(41, 56, 70, 1),
              child: InkWell(
                // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                onTap: () {
                  popupbawah(Profile());
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Icon(Icons.person),
                ),
              ),
            ),
            // Material(
            //   // borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //   color: Color.fromRGBO(41, 56, 70, 1),
            //   child: InkWell(
            //     // borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //     onTap: () async {
            //       await Auth().logout();
            //       Navigator.pushReplacementNamed(context, '/splash');
            //     },
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       decoration: BoxDecoration(
            //         color: Colors.transparent,
            //         // borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //       ),
            //       child: Icon(Icons.exit_to_app),
            //     ),
            //   ),
            // ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3.0),
                                      topRight: Radius.circular(3.0),
                                      bottomRight: Radius.circular(3.0),
                                      bottomLeft: Radius.circular(3.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                      ),
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(26, 179, 148, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100.0),
                                          topRight: Radius.circular(100.0),
                                          bottomRight: Radius.circular(100.0),
                                          bottomLeft: Radius.circular(100.0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.attach_money,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Net Sales',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  99, 110, 114, 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            'Penjualan Bersih',
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 10),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3.0),
                                      topRight: Radius.circular(3.0),
                                      bottomRight: Radius.circular(3.0),
                                      bottomLeft: Radius.circular(3.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                      ),
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(35, 198, 200, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100.0),
                                          topRight: Radius.circular(100.0),
                                          bottomRight: Radius.circular(100.0),
                                          bottomLeft: Radius.circular(100.0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.access_alarm,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Penjualan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  99, 110, 114, 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            'Viewer',
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 10),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3.0),
                                      topRight: Radius.circular(3.0),
                                      bottomRight: Radius.circular(3.0),
                                      bottomLeft: Radius.circular(3.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                      ),
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(35, 198, 200, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100.0),
                                          topRight: Radius.circular(100.0),
                                          bottomRight: Radius.circular(100.0),
                                          bottomLeft: Radius.circular(100.0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.access_alarm,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Penjualan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  99, 110, 114, 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            'Viewer',
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 10),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(3.0),
                                      topRight: Radius.circular(3.0),
                                      bottomRight: Radius.circular(3.0),
                                      bottomLeft: Radius.circular(3.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                      ),
                                    ]),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(35, 198, 200, 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100.0),
                                          topRight: Radius.circular(100.0),
                                          bottomRight: Radius.circular(100.0),
                                          bottomLeft: Radius.circular(100.0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.access_alarm,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Penjualan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  99, 110, 114, 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            'Viewer',
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 10),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Wrap(
                      // alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/pos');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Kasir',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            color: Color.fromRGBO(41, 56, 70, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/diskon');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Diskon',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            color: Color.fromRGBO(41, 56, 70, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/inventory');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.library_books,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Inventory',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            color: Color.fromRGBO(41, 56, 70, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/pembelian');
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.library_books,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Pembelian',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            color: Color.fromRGBO(41, 56, 70, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          width: MediaQuery.of(context).size.width * 0.20,
                          height: MediaQuery.of(context).size.width * 0.20,
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/master');
                              },
                              child: Container(
                                child: Center(
                                  child: Icon(
                                    Icons.person_add,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            color: Color.fromRGBO(41, 56, 70, 1),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  popupbawah(Widget target) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) => target,
    );
    setState(() {});
  }
}
