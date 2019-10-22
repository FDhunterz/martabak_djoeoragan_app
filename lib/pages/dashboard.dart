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
        body: Stack(
          children: <Widget>[
            ListView(
            children: <Widget>[
              Container(
              padding: EdgeInsets.only(top: 10, left: 20),
              height: 40,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    color: Color(0xff25282b),
                    onPressed: () => scaffoldKey.currentState.openDrawer(),
                  ),
                ],
              ),
            ),
            
              Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),

                  child: TextField(
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.blueGrey[700],
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.white,),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white,),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Pencarian",
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.blueGrey[500],
                      ),
                      hintStyle: TextStyle(
                        fontSize: 15.0,
                        color: Colors.blueGrey[400],
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10, left: 20),
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {

                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        child: Container(
                          height: 178,
                          width: 450,
    //                      color: Colors.green,
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "images/martabak4.jpg",
                                  height: 178,
                                  width: 450,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: null,
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10, left: 20),
                height: 90,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      child: Container(
                        height: 178,
                        width: 450,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                "images/martabak4.jpg",
                                height: 68,
                                color: Colors.green,
                                width: 450,
                                fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: null,
                      ),
                    ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10, left: 20),
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemCount: 9,
                  itemBuilder: (BuildContext context, int index) {

                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        child: Container(
                          height: 68,
                          width: 68,
    //                      color: Colors.green,
                          child: Column(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "images/martabak4.jpg",
                                  color: Colors.black26,
                                  height: 68,
                                  width: 68,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('Menu'),
                            ],
                          ),
                        ),
                        onTap: null,
                      ),
                    );
                  },
                ),
              ),

              Container(
                width: 400,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 10,left: 10),
                margin: EdgeInsets.only(bottom:20),
                child : ListView.builder(
                  itemCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        child: Container(
                          height: 300,
                          width: 240,
                          child: Wrap(
                            direction: Axis.vertical,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "images/martabak4.jpg",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('Menu'),
                              Text('Deskripsi'),
                                  ],
                                ),

                              ),

                              Padding(
                                padding: EdgeInsets.only(top: 10, left: 20),
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "images/martabak4.jpg",
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text('Menu'),
                                  ],
                                ),

                              ),

                            ],
                          ),
                        ),
                        onTap: null,
                      ),
                    );
                 },
                ),
              ),
             ],
            ),
          ],
        ),
      ),
    );
  }
}
