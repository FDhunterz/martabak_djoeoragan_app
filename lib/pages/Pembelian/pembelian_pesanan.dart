import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class PembelianPesananPage extends StatefulWidget {
  @override
  _PembelianPesananPageState createState() => _PembelianPesananPageState();
}

class _PembelianPesananPageState extends State<PembelianPesananPage> {
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
                            labelText: 'Kode Pembelian',
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
                          hasFloatingPlaceholder: false,
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
                      Container(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Pilih Supplier',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
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
                              'Detail Order',
                              style: TextStyle(
                                  color: Color(0xff25282b),
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.only(
                                left: 10.0, top: 5.0, bottom: 5.0),
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
                            'RO-1902/01/001',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Gulaku 500gr Hijau',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(
                              left: 10.0, top: 3.0, bottom: 5.0),
                        ),
                        Container(
                          child: new Text(
                            '20',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(
                              right: 10.0, top: 3.0, bottom: 5.0),
                        ),
                      ],
                    ),
                    Container(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 1,
                          )),
                    ),
                    Container(
                      child: Text(
                        'RO-1902/01/002',
                        style: TextStyle(
                            color: Color(0xff25282b),
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Gulaku 500gr Hijau',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(
                              left: 10.0, top: 3.0, bottom: 5.0),
                        ),
                        Container(
                          child: new Text(
                            '8',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(
                              right: 10.0, top: 3.0, bottom: 5.0),
                        ),
                      ],
                    ),
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
                            'Kredit Saat Ini :',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        ),
                        new Container(
                          child: new Text(
                            '0.00',
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
                            'Mata Uang :',
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
                            'Rupiah',
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
