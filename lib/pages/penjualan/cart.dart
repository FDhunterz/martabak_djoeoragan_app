import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/cart_bloc.dart';
import 'package:provider/provider.dart';
import 'package:martabakdjoeragan_app/pages/cameo/empty_cart.dart';
// import 'package:martabakdjoeragan_app/utils/foods.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<CartBloc>(context);
    var cart = bloc.cart;

    NumberFormat numberFormat =
        NumberFormat.simpleCurrency(decimalDigits: 2, name: 'Rp .');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xff25282b),
        ),
        title: Text(
          cart.isEmpty ? "Tidak Ada Item" : "Cart",
          style: TextStyle(
            color: Color(0xff25282b),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: cart.isEmpty
          ? EmptyCart()
          : ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Order Item(s)",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Color(0xff25282b),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "+ Tambah",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Color(0xfffbaf18),
                                ),
                              ),
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
                            int count = cart[index].qty;

                            double countPrice =
                                double.parse(cart[index].sysprice) * count;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Container(
                                height: 60,
//                    color: Colors.red,
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        "images/martabak${cart[index].id}.jpg",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    Container(
                                      height: 80,
                                      width: MediaQuery.of(context).size.width -
                                          90,
                                      child: ListView(
                                        primary: false,
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  cart[index].name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  cart[index].price,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                  maxLines: 1,
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Card(
                                                      color: Colors.white,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10.0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                bloc.reduceQty(
                                                                    cart[
                                                                        index]);
                                                              },
                                                              child: const Text(
                                                                  '-',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xfffbaf18))),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 15.0,
                                                                    left: 15.0),
                                                            child: Text(
                                                              "$count",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                              maxLines: 2,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        10.0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                bloc.addToCart(
                                                                    cart[
                                                                        index]);
                                                              },
                                                              child: const Text(
                                                                  '+',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Color(
                                                                          0xfffbaf18))),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                ],
                                              )
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
                ),
              ],
            ),
      bottomNavigationBar: cart.isEmpty
          ? EmptyCart()
          : Container(
              height: 270,
              margin: EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 8.0,
                          color: Colors.grey[200],
                        ),
                        Container(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, left: 10.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Payment details",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.bold),
                              ),
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
                              Text(
                                "Price(estimated)",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                numberFormat.format(bloc.totalHarga),
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "PPN",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                numberFormat.format(bloc.ppn),
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.w500),
                              )
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
                              Text(
                                "Total Payment",
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                numberFormat.format(bloc.totalHargaPenjualan),
                                style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14.0,
                                    color: Color(0xff25282b),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
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
                          Navigator.pop(context);
                        },
                        child: const Text('Order Sekarang',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        elevation: 0.0,
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
