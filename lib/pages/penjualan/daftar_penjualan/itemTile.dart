import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:martabakdjoeragan_app/pages/ImageToFile/ImageToFile.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_model.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:network_to_file_image/network_to_file_image.dart';

class ItemTile extends StatefulWidget {
  final Item item;

  ItemTile({
    this.item,
  });

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final NumberFormat numberFormat = NumberFormat.simpleCurrency(
    name: 'Rp. ',
    decimalDigits: 0,
  );

  String holding;
  void getHolding() async {
    DataStore store = DataStore();

    int holdingX = await store.getDataInteger('us_holding');

    setState(() {
      holding = holdingX.toString();
    });
  }

  @override
  void initState() {
    getHolding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image(
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              // Appropriate logging or analytics, e.g.
              // myAnalytics.recordError(
              //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
              //   exception,
              //   stackTrace,
              // );
              return Image.asset(
                'images/martabak1.jpg',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              );
            },
            image: NetworkToFileImage(
              url:
                  '${noapiurl}storage/app/public/project/upload/$holding/item/${widget.item.idItem}/${widget.item.gambar}',
              file: fileFromDocsDir(widget.item.gambar),
              debug: true,
            ),
          ),
          // FadeInImage.assetNetwork(
          //   placeholder: "images/martabak1.jpg",
          //   image:
          //       // 'https://media.caradvice.com.au/image/private/s--4tbE3-K1--/v1541554888/9cb9e4766a2ae35704a7fd7578a23918.jpg',
          //       '${noapiurl}storage/app/public/project/upload/$holding/item/${widget.item.idItem}/${widget.item.gambar}',
          //   height: 50,
          //   width: 50,
          //   fit: BoxFit.cover,
          // ),
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
                      widget.item.namaItem,
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
                    child: double.parse(widget.item.diskon) != 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                numberFormat.format(
                                  double.parse(widget.item.harga),
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
                                  double.parse(widget.item.harga) -
                                      double.parse(widget.item.diskon),
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
                              double.parse(widget.item.harga),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                  ),
                  Text('${widget.item.qty} Qty'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
