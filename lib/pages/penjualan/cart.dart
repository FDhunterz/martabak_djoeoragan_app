import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/cart_bloc.dart';
import 'package:provider/provider.dart';
import 'package:martabakdjoeragan_app/pages/cameo/empty_cart.dart';

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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                int itemIndex = cart.keys.toList()[index];
                int count = cart[itemIndex];
                return ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/martabak${itemIndex + 1}.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  title: Text('Item $count'),
                  trailing: ButtonTheme(
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
                );
              },
            ),
          )
        ],
      ),

      bottomNavigationBar: cart.isEmpty ? emptyCart() : Container(
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 20.0, bottom: 10.0),
        child: ButtonTheme(
          minWidth: 100.0,
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
      ),
    );
  }
}

