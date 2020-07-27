import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class PembayaranSupplierPage extends StatefulWidget {
  @override
  _PembayaranSupplierPageState createState() => _PembayaranSupplierPageState();
}

class _PembayaranSupplierPageState extends State<PembayaranSupplierPage> {
  DateTime dates;

  List _payMethod = ["Pembayaran Tunai", "Pembayaran Transfer"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentMethodPay;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentMethodPay = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String PM in _payMethod) {
      items.add(new DropdownMenuItem(value: PM, child: new Text(PM)));
    }
    return items;
  }

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
                            labelText: 'No. Pembayaran',
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
                            labelText: 'Catatan Pembayaran',
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
                          labelText: 'Tanggal Pembayaran',
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
                      Container(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Nota Transaksi',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            )),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Metode Pembayaran',
                          errorStyle: TextStyle(
                              color: Colors.redAccent, fontSize: 16.0),
                          hintStyle: TextStyle(fontSize: 16.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                        child: Container(
                          height: 20.0,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _currentMethodPay,
                              items: _dropDownMenuItems,
                              onChanged: changedDropDownItem,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Nominal Bayar',
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
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            'Total Tagihan :',
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
                            'Sudah Dibayar :',
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
                            '0.00',
                            style: TextStyle(
                              color: Color(0xff25282b),
                              fontSize: 15.0,
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: 10.0, top: 10.0, bottom: 5.0),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            'Akan Dibayar :',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                        ),
                        new Container(
                          child: new Text(
                            '0.00',
                            style: TextStyle(
                              color: Color(0xff25282b),
                              fontSize: 15.0,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                        ),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Container(
                          child: new Text(
                            'Sisa Tagihan :',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                        ),
                        new Container(
                          child: new Text(
                            '0.00',
                            style: TextStyle(
                              color: Color(0xff25282b),
                              fontSize: 15.0,
                            ),
                          ),
                          padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
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
                            'Kas Kecil :',
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
                            'Hutang Usaha :',
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
                            '0.00',
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

  void changedDropDownItem(String selectedMethodP) {
    setState(() {
      _currentMethodPay = selectedMethodP;
    });
  }
}
