import 'package:flutter/material.dart';
// import 'package:martabakdjoeragan_app/presentation/custom_icon_icons.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class PemesananPembelianPage extends StatefulWidget {
  @override
  _PemesananPembelianPageState createState() => _PemesananPembelianPageState();
}

class _PemesananPembelianPageState extends State<PemesananPembelianPage> {
  int _itemCount = 0;
  DateTime dates;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Kode Pesanan',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Catatan Pesanan',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      DateTimeField(
                        maxLength: 10,
                        format: DateFormat("yyyy-MM-dd"),
                        initialValue: dates,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                            firstDate: DateTime(
                              DateTime.now().year,
                            ),
                            initialDate: currentValue ?? DateTime.now(),
                            context: context,
                            lastDate: DateTime(DateTime.now().year + 30),
                          );
                        },
                        decoration: InputDecoration(
                          labelText: 'Pilih Tanggal',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        readOnly: true,
                        onChanged: (ini) {
                          setState(() {
                            dates = ini;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          ButtonTheme(
                            height: 30.0,
                            buttonColor: Color(0xfffbaf18),
                            child: RaisedButton(
                              onPressed: () {},
                              child: Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'Order',
                              style: TextStyle(
                                  color: Color(0xff25282b),
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 50.0,
                                height: 20.0,
                                buttonColor: Color(0xfffbaf18),
                                child: RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Container(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ]),
                    Container(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                          )),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Tepung Gandum Freshlag',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        ),
                        IconButton(
                          icon: new IconTheme(
                            data: new IconThemeData(
                              color: Color(0xffE52A34),
                            ),
                            child: new Icon(Icons.delete),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Rp.12.000.00',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, top: 3.0),
                        ),
                        Container(
                          child: new Row(
                            children: <Widget>[
                              _itemCount != 0
                                  ? new IconButton(
                                      icon: new Icon(Icons.remove),
                                      onPressed: () =>
                                          setState(() => _itemCount--),
                                    )
                                  : new Container(),
                              new Text(_itemCount.toString()),
                              new IconButton(
                                  icon: new Icon(Icons.add),
                                  onPressed: () => setState(() => _itemCount++))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              new Card(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            'Total Harga :',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        ),
                        new Container(
                          child: new Text(
                            '40,000.00',
                            style: TextStyle(
                              color: Color(0xff25282b),
                              fontSize: 15.0,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            'Total Stok :',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(
                              left: 10.0, top: 10.0, bottom: 10.0),
                        ),
                        new Container(
                          child: new Text(
                            '20',
                            style: TextStyle(
                              color: Color(0xff25282b),
                              fontSize: 15.0,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: 10.0, top: 10.0, bottom: 10.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
