import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InventoryTab1 extends StatefulWidget{
  @override
  _InventoryTab1 createState()=> _InventoryTab1();
}

class _InventoryTab1 extends State<InventoryTab1>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                      color: Color.fromRGBO(26 , 179 , 148 , 1),
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

                                  SizedBox(width: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Net Sales',
                                          style: TextStyle(
                                            color: Color.fromRGBO(99 , 110 , 114 , 1),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text('Penjualan Bersih',
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
                        padding: EdgeInsets.only(left: 10 , right: 10,bottom : 10),
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
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}