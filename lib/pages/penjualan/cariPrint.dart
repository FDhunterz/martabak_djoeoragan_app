import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:escposprinter/escposprinter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CariPrint extends StatefulWidget {
  @override
  _CariPrintState createState() => new _CariPrintState();
}

class _CariPrintState extends State<CariPrint> {
  List devices = [];
  bool connected = false;
  NumberFormat _numberFormat = NumberFormat.simpleCurrency(
    decimalDigits: 2,
    name: '',
  );

  @override
  initState() {
    super.initState();
    _list();
  }

  _list() async {
    List returned;
    try {
      returned = await Escposprinter.getUSBDeviceList;
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    setState(() {
      devices = returned;
    });
  }

  _connect(int vendor, int product) async {
    bool returned;
    try {
      returned = await Escposprinter.connectPrinter(vendor, product);
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    if (returned) {
      setState(() {
        connected = true;
      });
    }
  }

  // ignore: unused_element
  _print() async {
    try {
      await Escposprinter.printText("Testing ESC POS printer...\n");
      await Escposprinter.printText("Testing ESC POS printer...\n");
      await Escposprinter.printText("Testing ESC POS printer...\n");
      await Escposprinter.printText("Testing ESC POS printer...\n");
      await Escposprinter.printText("Testing ESC POS printer...\n");
      await Escposprinter.printText("\n\n\n\n\n");
      await Escposprinter.printText("\x1d\x56\x00");
    } on PlatformException {
      //response = 'Failed to get platform version.';
    } catch (e) {
      print(e);
    }
  }

  void printKasir(String nota) async {
    KasirBloc blocX = Provider.of<KasirBloc>(context);

    double totalK = 0;
    // ignore: unused_local_variable
    double subDiskon = 0;
    double totalQty = 0;

    try {
      // await Escposprinter.printText("Hello World 1\n");
      await Escposprinter.printText("Martabak Djoeragan\n");
      await Escposprinter.printText(
          "----------------------------------------------\n");
      await Escposprinter.printText(
          "Nomor Nota".padRight(16, ' ') + " : " + "$nota".padRight(27, ' '));

      await Escposprinter.printText('\n');
      await Escposprinter.printText("Tanggal".padRight(16, ' ') +
          " : " +
          "${DateFormat('dd MMMM yyyy').format(DateTime.now())}"
              .padRight(27, ' '));
      await Escposprinter.printText('\n');
      await Escposprinter.printText("Customer".padRight(16, ' ') +
          " : " +
          "${blocX.selectedCustomer != null ? blocX.selectedCustomer.namaCustomer : '(Tanpa Nama)'}"
              .padRight(27, ' '));
      await Escposprinter.printText('\n');
      await Escposprinter.printText(
          "----------------------------------------------\n");
      await Escposprinter.printText(
          "  ITEMS       PRICE       DISCOUNT     TOTAL  \n");
      await Escposprinter.printText(
          "----------------------------------------------\n");

      for (var data in blocX.cart) {
        double diskons = double.parse(data.diskon != null ? data.diskon : '0');

        await Escposprinter.printText("${data.name.padRight(46, ' ')}\n");

        double total = (double.parse(data.price) * data.qty);

        await Escposprinter.printText(data.qty.toString().padRight(5, ' '));
        await Escposprinter.printText(' X @ '.padLeft(0, ' '));
        await Escposprinter.printText(
            _numberFormat.format(double.parse(data.price)).padLeft(11, ' '));
        await Escposprinter.printText(
            " ${_numberFormat.format(diskons).padLeft(12, ' ')}");
        await Escposprinter.printText(_numberFormat.format(total).padLeft(13));
        await Escposprinter.printText("\n\n");

        subDiskon += diskons;
        totalK += double.parse(data.price) * data.qty;
        totalQty += data.qty;
      }

      await Escposprinter.printText(
          "----------------------------------------------\n");

      await Escposprinter.printText(
          totalQty.toInt().toString().padRight(5, ' '));
      await Escposprinter.printText("  Items       Total    : ");
      await Escposprinter.printText(
          _numberFormat.format(totalK).padLeft(17, ' '));
      await Escposprinter.printText('\n');

      await Escposprinter.printText("Diskon".padLeft(24) + "    : ");
      await Escposprinter.printText(
          _numberFormat.format(blocX.totalDiskon).padLeft(17, ' '));
      await Escposprinter.printText("\n");

      // await Escposprinter.printText(
      //     '---------------------------\n'.padLeft(46, ' '));

      // await Escposprinter.printText("               SUB Total    :  ");
      // await Escposprinter.printText(
      //     _numberFormat.format(totalK).padLeft(17, ' '));
      // await Escposprinter.printText("\n");

      // double ppn = (totalK - subDiskon) * 10 / 110;
      await Escposprinter.printText("PPN".padLeft(24) + "    : ");
      await Escposprinter.printText(
          _numberFormat.format(blocX.ppn).padLeft(17, ' '));
      await Escposprinter.printText("\n");

      await Escposprinter.printText(
          '----------------------------\n'.padLeft(46, ' '));

      await Escposprinter.printText("Grand Total".padLeft(24) + "    : ");
      await Escposprinter.printText(
          _numberFormat.format(blocX.totalHargaPenjualan).padLeft(17, ' '));
      await Escposprinter.printText("\n");

      await Escposprinter.printText("Jumlah Dibayar".padLeft(24) + "    : ");
      await Escposprinter.printText(_numberFormat
          .format(double.parse(
              blocX.jumlahBayarController.text.replaceAll(',', '')))
          .padLeft(17, ' '));
      await Escposprinter.printText('\n');

      await Escposprinter.printText("Kembalian".padLeft(24) + "    : ");
      await Escposprinter.printText(
          _numberFormat.format(blocX.kembalian).padLeft(17, ' '));
      await Escposprinter.printText("\n");

      await Escposprinter.printText('\n\n\n\n\n');
      await Escposprinter.printText('\x1d\x56\x00'); // untuk potong kertas
    } on PlatformException {
      Fluttertoast.showToast(msg: 'Failed to get platform version.');
      //response = 'Failed to get platform version.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Daftar Perangkat USB'),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new FloatingActionButton(
              child: new Icon(Icons.refresh),
              onPressed: () {
                _list();
              }),
          connected == true
              ? Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: new FloatingActionButton(
                    child: new Icon(Icons.print),
                    onPressed: () {
                      printKasir('Nota/percobaan/001');
                    },
                  ),
                )
              : new Container(
                  width: 0.0,
                  height: 0.0,
                ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          _list();
          return Future.value({});
        },
        child: new ListView(
          scrollDirection: Axis.vertical,
          children: _buildList(devices),
        ),
      ),
    );
  }

  List<Widget> _buildList(List devices) {
    return devices.length != 0
        ? devices
            .map(
              (device) => new ListTile(
                onTap: () {
                  _connect(int.parse(device['vendorid']),
                      int.parse(device['productid']));
                },
                leading: new Icon(Icons.usb),
                title:
                    new Text(device['manufacturer'] + " " + device['product']),
                subtitle:
                    new Text(device['vendorid'] + " " + device['productid']),
              ),
            )
            .toList()
        : [
            ListTile(
              title: Text(
                'Daftar Perangkat Kosong',
                textAlign: TextAlign.center,
              ),
            ),
          ];
  }
}
