import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_model.dart';

class ItemTile extends StatelessWidget {
  final Item item;

  ItemTile({
    this.item,
  });

  final NumberFormat numberFormat = NumberFormat.simpleCurrency(
    name: 'Rp. ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage.assetNetwork(
            placeholder: "images/martabak1.jpg",
            image:
                // 'https://media.caradvice.com.au/image/private/s--4tbE3-K1--/v1541554888/9cb9e4766a2ae35704a7fd7578a23918.jpg',
                '${noapiurl}storage/app/public/project/upload/1/item/${item.idItem}/${item.gambar}',
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 15),
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width - 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item.namaItem,
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
                    child: double.parse(item.diskon) != 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                numberFormat.format(
                                  double.parse(item.harga),
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
                                  double.parse(item.harga) -
                                      double.parse(item.diskon),
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
                              double.parse(item.harga),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                  ),
                  Text('${item.qty} Qty'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
