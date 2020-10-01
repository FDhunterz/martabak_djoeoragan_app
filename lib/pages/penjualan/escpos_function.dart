import 'package:escposprinter/escposprinter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

Future<Null> printKasir(String nota, BuildContext context) async {
  NumberFormat _numberFormat = NumberFormat.simpleCurrency(
    decimalDigits: 0,
    name: '',
  );

  KasirBloc blocX = context.read<KasirBloc>();

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
      double diskons =
          double.parse(data.diskon != null ? data.diskon : '0') * data.qty;

      await Escposprinter.printText("${data.name.padRight(46, ' ')}\n");

      double total = (double.parse(data.price) * data.qty);

      await Escposprinter.printText(data.qty.toString().padRight(5, ' '));
      await Escposprinter.printText(' X @ ');
      await Escposprinter.printText(
          _numberFormat.format(double.parse(data.price)).padLeft(11, ' '));
      await Escposprinter.printText(
          " ${_numberFormat.format(diskons.ceilToDouble()).padLeft(12, ' ')}");
      await Escposprinter.printText(_numberFormat.format(total).padLeft(13));
      await Escposprinter.printText("\n\n");

      subDiskon += diskons;
      totalK += double.parse(data.price) * data.qty - diskons;
      totalQty += data.qty;
    }

    await Escposprinter.printText(
        "----------------------------------------------\n");

    await Escposprinter.printText(totalQty.toInt().toString().padRight(5, ' '));
    await Escposprinter.printText("  Items       Total    : ");
    await Escposprinter.printText(
        _numberFormat.format(totalK.ceilToDouble()).padLeft(17, ' '));
    await Escposprinter.printText('\n');

    await Escposprinter.printText("Diskon".padLeft(24) + "    : ");
    await Escposprinter.printText(_numberFormat
        .format(blocX.totalDiskon.ceilToDouble())
        .padLeft(17, ' '));
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
        _numberFormat.format(blocX.ppn.ceilToDouble()).padLeft(17, ' '));
    await Escposprinter.printText("\n");

    await Escposprinter.printText(
        '----------------------------\n'.padLeft(46, ' '));

    await Escposprinter.printText("Grand Total".padLeft(24) + "    : ");
    await Escposprinter.printText(_numberFormat
        .format(blocX.totalHargaPenjualan.ceilToDouble())
        .padLeft(17, ' '));
    await Escposprinter.printText("\n");

    await Escposprinter.printText("Jumlah Dibayar".padLeft(24) + "    : ");
    await Escposprinter.printText(_numberFormat
        .format(
            double.parse(blocX.jumlahBayarController.text.replaceAll(',', ''))
                .ceilToDouble())
        .padLeft(17, ' '));
    await Escposprinter.printText('\n');

    await Escposprinter.printText("Kembalian".padLeft(24) + "    : ");
    await Escposprinter.printText(
        _numberFormat.format(blocX.kembalian.ceilToDouble()).padLeft(17, ' '));
    await Escposprinter.printText("\n");

    await Escposprinter.printText('\n\n\n\n\n');
    await Escposprinter.printText('\x1d\x56\x00'); // untuk potong kertas
  } on PlatformException {
    Fluttertoast.showToast(msg: 'Failed to get platform version.');
    //response = 'Failed to get platform version.';
  }
}
