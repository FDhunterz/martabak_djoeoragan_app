import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:intl/intl.dart';

class CartTile extends StatefulWidget {
  final MartabakModel cart;

  final Function onReduce, onIncrease;

  CartTile({
    this.cart,
    this.onIncrease,
    this.onReduce,
  });

  @override
  _CartTileState createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  NumberFormat numberFormat = NumberFormat.simpleCurrency(decimalDigits: 0,name: 'Rp. ');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage.assetNetwork(
                placeholder: "images/martabak1.jpg",
                image:
                    '${noapiurl}storage/app/public/project/upload/1/item/${widget.cart.id}/${widget.cart.img}',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width - 90,
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
                          widget.cart.name,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: widget.cart.diskon != null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    numberFormat.format(
                                      double.parse(widget.cart.price),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    numberFormat.format(
                                      double.parse(widget.cart.price) -
                                          double.parse(widget.cart.diskon),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )
                            : Text(
                                numberFormat.format(
                                  double.parse(widget.cart.price),
                                ),
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
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: GestureDetector(
                                    onTap: widget.onReduce,
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xfffbaf18),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 15.0, left: 15.0),
                                  child: Text(
                                    widget.cart.qty.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.0),
                                  child: GestureDetector(
                                    onTap: widget.onIncrease,
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xfffbaf18),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
  }
}
