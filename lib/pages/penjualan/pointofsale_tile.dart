import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/core/env.dart';
import 'package:intl/intl.dart';
import 'package:martabakdjoeragan_app/pages/ImageToFile/ImageToFile.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:martabakdjoeragan_app/store/DataStore.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:provider/provider.dart';

class POSTileHorizontal extends StatefulWidget {
  final String id, nama, gambar, desc;
  final Function onTap;

  POSTileHorizontal({
    this.desc,
    this.gambar,
    this.id,
    this.nama,
    this.onTap,
  });

  @override
  _POSTileHorizontalState createState() => _POSTileHorizontalState();
}

class _POSTileHorizontalState extends State<POSTileHorizontal> {
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
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        child: Container(
          // height: 250,
          width: 160,
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  height: 70,
                  width: 70,
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
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    );
                  },
                  image: NetworkToFileImage(
                    url:
                        '${noapiurl}storage/app/public/project/upload/$holding/item/${widget.id}/${widget.gambar}',
                    file: fileFromDocsDir(widget.gambar),
                    debug: true,
                  ),
                ),
              ),
              SizedBox(height: 7),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.nama,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 3),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.desc,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.blueGrey[300],
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}

class POSTileVertical extends StatefulWidget {
  final String id, nama, gambar, desc, diskon, harga;
  final Function onTap;
  // final List<MartabakVarianModel> listVarian;
  final String listVarian;

  POSTileVertical({
    this.desc,
    this.diskon,
    this.gambar,
    this.harga,
    this.id,
    this.nama,
    this.onTap,
    this.listVarian,
  });

  @override
  _POSTileVerticalState createState() => _POSTileVerticalState();
}

class _POSTileVerticalState extends State<POSTileVertical> {
  final NumberFormat _numberFormat =
      NumberFormat.simpleCurrency(decimalDigits: 0, name: 'Rp. ');

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
    KasirBloc bloc = Provider.of<KasirBloc>(context);
    List<MartabakVarianModel> listVarian = List<MartabakVarianModel>();

    listVarian = List<MartabakVarianModel>();

    listVarian = bloc.decodeListVarian(widget.listVarian);

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    height: 70,
                    width: 70,
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
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      );
                    },
                    image: NetworkToFileImage(
                      url:
                          '${noapiurl}storage/app/public/project/upload/$holding/item/${widget.id}/${widget.gambar}',
                      file: fileFromDocsDir(widget.gambar),
                      debug: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width - 130,
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.nama,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.desc,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.blueGrey[300],
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: widget.diskon != null
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        _numberFormat.format(
                                          double.parse(widget.harga),
                                        ),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        _numberFormat.format(
                                          double.parse(widget.harga) -
                                              double.parse(widget.diskon),
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
                                : Container(
                                    child: Text(
                                      _numberFormat.format(
                                        double.parse(widget.harga),
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                      maxLines: 1,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                          ),
                          listVarian.isNotEmpty
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xfffbaf18),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    '${listVarian.length} varian',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 3,
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xff76273c),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    'Tambah',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String tooltip, namaMenu;
  final Function onTap;
  final IconData icon;

  MenuTile({
    this.icon,
    this.namaMenu,
    this.onTap,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        textStyle: TextStyle(
          color: Colors.white,
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 70,
            margin: EdgeInsets.all(5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Icon(
                    icon,
                    size: 18.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  child: Text(
                    namaMenu,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
