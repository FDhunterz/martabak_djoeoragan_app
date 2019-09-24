import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class ReturnPembelianPage extends StatefulWidget {
  @override
  _ReturnPembelianPageState createState() => _ReturnPembelianPageState();
}

class _ReturnPembelianPageState extends State<ReturnPembelianPage> {
  int _itemCount = 0;
  DateTime dates;

  List _ReturnMethod =
  ["Tukar Barang Baru", "Potong Nota"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentMethodRetrn;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentMethodRetrn = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String RM in _ReturnMethod) {
      items.add(new DropdownMenuItem(
          value: RM,
          child: new Text(RM)
      ));
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
                            labelText: 'Kode Return',
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
                            labelText: 'Alasan Return',
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
                          labelText: 'Metode Return',
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                          hintStyle: TextStyle(fontSize: 16.0),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(5.0)
                          ),
                        ),
                        child: Container(
                          height: 20.0,
                          child:DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: _currentMethodRetrn,
                              items: _dropDownMenuItems,
                              onChanged: changedDropDownItem,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 10.0,
                      ),
                      DateTimePickerFormField(
                        inputType: InputType.date,
                        format: DateFormat("yyyy-MM-dd"),
                        initialDate: DateTime(2019, 1, 1),
                        editable: false,
                        decoration: InputDecoration(
                          labelText: 'Tanggal Return',
                          hasFloatingPlaceholder: false,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                          ),
                        ),
                        onChanged: (dt) {
                          setState(() => dates = dt);
                          print('Selected date: $dates');
                        },
                      ),
                      Container(
                        height: 10.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Nota Pembelian',
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
                              'Detail Item',
                              style: TextStyle(
                                  color: Color(0xff25282b),
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.only(left: 10.0, top:5.0, bottom: 5.0),
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
                            'Nama Supplier :',
                            style: TextStyle(
                                color: Color(0xff25282b),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ),
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        ),
                        new Container(
                          child: new Text(
                            'ABS Packaging',
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
                            'Nilai Return :',
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
  void changedDropDownItem(String selectedMethodR) {
    setState(() {
      _currentMethodRetrn = selectedMethodR;
    });
  }
}
