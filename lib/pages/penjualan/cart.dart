import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/cart_bloc.dart';
import 'package:provider/provider.dart';
import 'package:martabakdjoeragan_app/pages/cameo/empty_cart.dart';
import 'package:martabakdjoeragan_app/utils/foods.dart';

class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff25282b),
        ),
        title: Text(
          cart.isEmpty ? "Tidak Item" : "Cart",
        style: TextStyle(
          color: Color(0xff25282b),
        )),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: cart.isEmpty ? emptyCart() : ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Order Item(s)", style: TextStyle(fontSize: 18.0, color: Color(0xff25282b), fontWeight: FontWeight.bold),),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/pos");
                  },
                  child: Text("+ Tambah", style: TextStyle(fontSize: 15.0, color: Color(0xfffbaf18),),),
                )
              ],
            ),
          ),
          Container(
            child: Text(
                "-----------------------------------------------------------",
              style: TextStyle(color: Colors.grey[300]),
            ),
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: cart.length,
              itemBuilder: (context, index) {
                int itemIndex = cart.keys.toList()[index];
                int count = cart[itemIndex];
                Map food = foods[itemIndex];
                return Padding(
                  padding: const EdgeInsets.only(bottom:15.0),
                    child: Container(
                      height: 60,
//                    color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              "images/martabak${itemIndex + 1}.jpg",
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),

                          SizedBox(width: 15),

                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width-90,
                            child: ListView(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${food["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "$count Item",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${food["price"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 25.0,
                                        height: 25.0,
                                        buttonColor: Color(0xffe52a34),
                                        child: RaisedButton(
                                          onPressed: () {
                                            bloc.clear(itemIndex);
                                          },
                                          child: const Text(
                                              'Hapus',
                                              style: TextStyle(fontSize: 13, color: Colors.white)
                                          ),
                                          elevation: 0.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                );
              },
            ),
          ),
        ],
      ),

      bottomNavigationBar: cart.isEmpty ? emptyCart() : Container(
        height: 270.0,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(height:8.0,color: Colors.grey[200],),
            Container(height:1.0,color: Colors.grey[300],),
            Padding (
              padding: EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Payment details", style: TextStyle(fontSize: 18.0, color: Color(0xff25282b), fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0, left: 10.0),
              child: Container(
                child: Text(
                    "-----------------------------------------------------------",
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Price(estimated)", style: TextStyle(fontFamily: "Roboto", fontSize: 14.0, color: Color(0xff25282b), fontWeight: FontWeight.w500),),
                  Text("10.000", style: TextStyle(fontFamily: "Roboto", fontSize: 14.0, color: Color(0xff25282b), fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("PPN", style: TextStyle(fontFamily: "Roboto", fontSize: 14.0, color: Color(0xff25282b), fontWeight: FontWeight.w500),),
                  Text("1.000", style: TextStyle(fontFamily: "Roboto", fontSize: 14.0, color: Color(0xff25282b), fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.0, left: 10.0),
              child: Container(
                child: Text(
                    "-----------------------------------------------------------",
                  style: TextStyle(color: Colors.grey[300]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total Payment", style: TextStyle(fontFamily: "Roboto", fontSize: 14.0, color: Color(0xff25282b), fontWeight: FontWeight.w500),),
                  Text("11.000", style: TextStyle(fontFamily: "Roboto", fontSize: 14.0, color: Color(0xff25282b), fontWeight: FontWeight.w500),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width,
                height: 50.0,
                buttonColor: Color(0xfffbaf18),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/pos");
                  },
                  child: const Text(
                      'Order Sekarang',
                      style: TextStyle(fontSize: 18, color: Colors.white)
                  ),
                  elevation: 0.0,
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

