import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'dart:async';

import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:provider/provider.dart';

class CariCustomer extends StatefulWidget {
  final Customer customer;

  CariCustomer({Key key, this.customer}) : super(key: key);

  @override
  _CariCustomerState createState() => _CariCustomerState();
}

class _CariCustomerState extends State<CariCustomer> {
  Timer timer;
  int delayRequest;

  Customer customerState;
  bool _isCari;

  String tokenType, accessToken;
  Map<String, String> requestHeaders = Map();
  GlobalKey<ScaffoldState> _scaffoldKeyCustomer = GlobalKey<ScaffoldState>();

  FocusNode cariFocus = FocusNode();
  TextEditingController cariController = TextEditingController();

  @override
  void initState() {
    delayRequest = 0;
    _isCari = false;

    customerState = widget.customer == null
        ? Customer(
            idCustomer: '',
            namaCustomer: '',
            alamat: '',
          )
        : widget.customer;

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    cariController.dispose();
    cariFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    KasirBloc bloc = Provider.of<KasirBloc>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKeyCustomer,
        appBar: AppBar(
          backgroundColor: _isCari ? Colors.white : Colors.orange[300],
          iconTheme: _isCari
              ? IconThemeData(
                  color: Colors.black,
                )
              : null,
          title: _isCari == true
              ? TextField(
                  decoration: InputDecoration(hintText: 'Cari Nama/HP/Alamat'),
                  controller: cariController,
                  autofocus: true,
                  focusNode: cariFocus,
                  onChanged: (ini) {
                    setState(() {
                      cariController.value = TextEditingValue(
                        text: ini,
                        selection: cariController.selection,
                      );
                    });
                  },
                )
              : Text(customerState != null ? customerState.namaCustomer : ''),
          actions: <Widget>[
            _isCari == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _isCari = true;
                        cariController.clear();
                      });
                    },
                    icon: Icon(Icons.search),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        _isCari = false;
                        cariController.clear();
                      });
                    },
                    icon: Icon(Icons.close),
                  )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            customerState != null
                ? customerState.isNew
                    ? 'Edit Customer'
                    : 'Buat Customer Baru'
                : 'Buat Customer Baru',
          ),
          onPressed: () async {
            Customer cusX = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateCustomer(
                  customer: customerState.isNew ? customerState : null,
                ),
              ),
            );

            if (cusX != null) {
              Navigator.pop(context, cusX);
            }
          },
          icon: Icon(
            customerState != null
                ? customerState.isNew
                    ? Icons.edit
                    : Icons.add
                : Icons.add,
          ),
        ),
        body: Scrollbar(
          child: ListView(
              children: bloc.cariCustomer(cariController.text).isEmpty
                  ? [
                      ListTile(
                        title: Text(
                          'Tidak ada Data',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]
                  : bloc
                      .cariCustomer(cariController.text)
                      .map(
                        (e) => Container(
                          margin: EdgeInsets.only(
                            top: 3.0,
                            bottom: 3.0,
                            left: 5.0,
                            right: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: e.idCustomer == customerState.idCustomer
                                ? Colors.green[100].withOpacity(0.5)
                                : Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                                color: Colors.grey.withOpacity(0.2),
                                offset: Offset(1.0, 1.0),
                              )
                            ],
                          ),
                          child: ListTile(
                            leading: Icon(FeatherIcons.user),
                            title: Text(e.namaCustomer),
                            subtitle: Text(e.alamat),
                            trailing: Text(e.noTelp),
                            onTap: () {
                              setState(() {
                                customerState = e;
                                _isCari = false;
                                cariController.clear();
                              });
                              Navigator.pop(context, customerState);
                            },
                          ),
                        ),
                      )
                      .toList()),
        ),
      ),
    );
  }
}

class CreateCustomer extends StatefulWidget {
  final Customer customer;

  const CreateCustomer({Key key, this.customer}) : super(key: key);
  @override
  _CreateCustomerState createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  TextEditingController namaCustomer, nomorTelp, alamat;
  FocusNode namaFocus, nomorFocus, alamatFocus;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    namaCustomer = TextEditingController(
      text: widget.customer != null ? widget.customer.namaCustomer : '',
    );
    nomorTelp = TextEditingController(
      text: widget.customer != null ? widget.customer.noTelp : '',
    );
    alamat = TextEditingController(
      text: widget.customer != null ? widget.customer.alamat : '',
    );
    namaFocus = FocusNode();
    nomorFocus = FocusNode();
    alamatFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    namaFocus.dispose();
    nomorFocus.dispose();
    alamatFocus.dispose();
    namaCustomer.dispose();
    nomorTelp.dispose();
    alamat.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange[300],
          title: Text('Form Customer'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (namaCustomer.text.isEmpty) {
              Fluttertoast.showToast(msg: 'Nama Customer tidak boleh kosong');
            } else if (nomorTelp.text.isEmpty) {
              Fluttertoast.showToast(msg: 'Nomor telepon tidak boleh kosong');
            } else {
              Navigator.pop(
                context,
                Customer(
                  namaCustomer: namaCustomer.text,
                  alamat: alamat.text,
                  noTelp: nomorTelp.text,
                  isNew: true,
                ),
              );
            }
          },
          label: Text('Simpan'),
          icon: Icon(Icons.check),
        ),
        body: Scrollbar(
          child: ListView(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            children: [
              CustomerTextField(
                autoFocus: true,
                controller: namaCustomer,
                focusNode: namaFocus,
                label: 'Nama Customer',
                isRequired: true,
                onChanged: (ini) {},
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(nomorFocus);
                },
              ),
              Divider(),
              CustomerTextField(
                keyboardType: TextInputType.number,
                controller: nomorTelp,
                focusNode: nomorFocus,
                label: 'Telp Customer',
                isRequired: true,
                onChanged: (ini) {},
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(alamatFocus);
                },
              ),
              Divider(),
              CustomerTextField(
                controller: alamat,
                focusNode: alamatFocus,
                label: 'Alamat Customer',
                maxLines: 3,
                isRequired: false,
                onChanged: (ini) {},
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerTextField extends StatelessWidget {
  final String label, hintText;
  final TextEditingController controller;
  final bool isRequired, autoFocus;
  final Function(String) onChanged;
  final Function onEditingComplete;
  final FocusNode focusNode;
  final int maxLines;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const CustomerTextField({
    Key key,
    this.label,
    this.controller,
    this.isRequired,
    this.onChanged,
    this.onEditingComplete,
    this.hintText,
    this.focusNode,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.autoFocus = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text.rich(
            TextSpan(
              text: '$label ',
              children: [
                TextSpan(
                  text: isRequired ? '*' : '',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
        TextField(
          autofocus: autoFocus,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            hintText: hintText,
            border: InputBorder.none,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange[300],
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.orange[300],
                width: 3,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
