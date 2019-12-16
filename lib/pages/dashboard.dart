import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/utils/Navigator.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('Kim Jisoo'),
                  accountEmail: Text('Jisoocu@gmail.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('images/jisoocu.jpg'),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xfffbaf18),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.view_list),
                  title: Text(
                    'Data  Master',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                      color: Color(0xff25282b),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    MyNavigator.goToMaster(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.view_list),
                  title: Text(
                    'Pembelian',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Roboto',
                      color: Color(0xff25282b),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    MyNavigator.goToPembelian(context);
                  },
                ),
              ],
            ),
          ),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(41, 56, 70, 1),
          title: Text('Dashboard'),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
          ),
          child:   SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          Container(
                          padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
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
                                      offset:Offset(0.0 ,0.0),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                ),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(253 , 200 , 110 , 1),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100.0),
                                          topRight: Radius.circular(100.0),
                                          bottomRight: Radius.circular(100.0),
                                          bottomLeft: Radius.circular(100.0),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.accessibility_new,
                                        color: Colors.white,
                                      ),
                                    ),

                                    SizedBox(width: 10,),

                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.20,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Penjualan',
                                            style: TextStyle(
                                              color: Color.fromRGBO(99 , 110 , 114 , 1),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text('Viewer',
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 10
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(width: 10,),

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
                                      offset:Offset(0.0 ,0.0),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                ),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(35 , 198 , 200 , 1),
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

                                    SizedBox(width: 10,),

                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.20,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Penjualan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(99 , 110 , 114 , 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text('Viewer',
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 10
                                            ),
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
                          padding: EdgeInsets.only(left: 10 , right: 10 , bottom: 10),
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
                                      offset:Offset(0.0 ,0.0),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                ),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(35 , 198 , 200 , 1),
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

                                    SizedBox(width: 10,),

                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.20,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Penjualan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(99 , 110 , 114 , 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text('Viewer',
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 10
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              SizedBox(width: 10,),

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
                                      offset:Offset(0.0 ,0.0),
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                ),
                                width: MediaQuery.of(context).size.width * 0.45,
                                padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(35 , 198 , 200 , 1),
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

                                    SizedBox(width: 10,),

                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.20,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text('Penjualan',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(99 , 110 , 114 , 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text('Viewer',
                                            style: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 10
                                            ),
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
                    width: double.infinity,
                    // margin: EdgeInsets.only(horizontal: 10 , vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(3.0),
                              topRight: Radius.circular(3.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset:Offset(0.0 ,0.0),
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ]
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text('Action Activity',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromRGBO(99 , 110 , 114, 1)
                                  ),
                                ),
                              ),

                              Icon(Icons.add,
                                color: Color.fromRGBO(99 , 110 , 114, 1)
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.92,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(width: 1.0, color: Colors.black26),
                              top: BorderSide(width: 1.0, color: Colors.black26),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset:Offset(0.0 ,0.0),
                                blurRadius: 1,
                                spreadRadius: 1,
                              ),
                            ]
                          ),
                          child: Text('a'),
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
}
