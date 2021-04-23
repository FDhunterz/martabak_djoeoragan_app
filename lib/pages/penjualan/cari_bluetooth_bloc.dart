import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/kasir_bloc.dart';

class CariBluetoothBloc extends ChangeNotifier {
  PrinterBluetooth selectedPrinterBluetooth;
  List<PrinterBluetooth> listPrinterBluetooth = [];
  bool firstTime = true;

  PrinterBluetoothManager printerManager = PrinterBluetoothManager();

  void initial() {
    printerManager.scanResults.listen((devices) async {
      listPrinterBluetooth = devices;

      notifyListeners();
    });
  }

  void startScan() {
    listPrinterBluetooth.clear();
    firstTime = false;
    notifyListeners();

    printerManager.startScan(Duration(seconds: 5));
  }

  void cancelScan() {
    printerManager.stopScan();
  }

  void printPOS(BuildContext context, String nota) async {
    Fluttertoast.showToast(msg: 'Sedang membaca printer');
    printerManager.selectPrinter(selectedPrinterBluetooth);

    // TODO Don't forget to choose printer's paper
    const PaperSize paper = PaperSize.mm58;

    // TEST PRINT
    // final PosPrintResult res =
    //     await printerManager.printTicket(await testTicket(paper));

    // DEMO RECEIPT
    final PosPrintResult res = await printerManager
        .printTicket(await demoReceipt(paper, context, nota));

    Fluttertoast.showToast(msg: res.msg);
  }
}

/// menggunakan package:
///
/// package:esc_pos_utils/esc_pos_utils.dart
Future<Ticket> demoReceipt(
    PaperSize paper, BuildContext context, String nota) async {
  final Ticket ticket = Ticket(paper);
  KasirBloc blocX = context.read<KasirBloc>();
  NumberFormat _numberFormat = NumberFormat.simpleCurrency(
    decimalDigits: 0,
    name: '',
  );

  double totalK = 0;
  // ignore: unused_local_variable
  double subDiskon = 0;
  // ignore: unused_local_variable
  double totalQty = 0;

  ticket.text('Martabak Djoeragan',
      styles: PosStyles(
        align: PosAlign.center,
        height: PosTextSize.size2,
        width: PosTextSize.size1,
      ),
      linesAfter: 1);

  ticket.hr();

  ticket.row([
    PosColumn(width: 4, text: 'Nomor Nota'),
    PosColumn(width: 1, text: ':'),
    PosColumn(width: 7, text: nota),
  ]);

  ticket.row([
    PosColumn(width: 4, text: 'Tanggal'),
    PosColumn(width: 1, text: ':'),
    PosColumn(
      width: 7,
      text: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    ),
  ]);

  ticket.row([
    PosColumn(width: 4, text: 'Customer'),
    PosColumn(width: 1, text: ':'),
    PosColumn(
        width: 7,
        text: blocX.selectedCustomer != null
            ? blocX.selectedCustomer.namaCustomer
            : '(Tanpa Nama)'),
  ]);

  ticket.hr();

  ticket.text(
    'Daftar Item',
    styles: PosStyles(
      align: PosAlign.center,
      width: PosTextSize.size2,
      bold: true,
    ),
  );

  ticket.hr();

  for (var data in blocX.cart) {
    double diskons =
        double.parse(data.diskon != null ? data.diskon : '0') * data.qty;

    List<ToppingMartabakModel> listTopping =
        blocX.decodeListTopping(data.listTopping);

    double total = (blocX.hargaItem(data) * data.qty);

    String namaTopping = '';

    for (var topping in listTopping) {
      for (var toppingDt in topping.listTopping) {
        if (toppingDt.isSelected) {
          if (namaTopping == '') {
            namaTopping += toppingDt.namaTopping;
          } else {
            namaTopping += ', ${toppingDt.namaTopping}';
          }
        }
      }
    }

    ticket.text(
      blocX.namaItem(data),
      styles: PosStyles(
        bold: true,
      ),
    );
    if (namaTopping != '') {
      ticket.text(namaTopping);
    }

    String textDiskon = '';

    if (diskons != 0) {
      textDiskon = ' - ${_numberFormat.format(diskons.ceilToDouble())}';
    }

    ticket.text(
        '${data.qty} x @ ${_numberFormat.format(blocX.hargaItem(data))}$textDiskon');

    ticket.text(
      _numberFormat.format(total),
      styles: PosStyles(align: PosAlign.right),
    );

    subDiskon += diskons;
    totalK += blocX.hargaItem(data) * data.qty - diskons;
    totalQty += data.qty;
  }

  ticket.hr();

  ticket.row([
    PosColumn(
      text: 'Total',
      width: 5,
      styles: PosStyles(align: PosAlign.right),
    ),
    PosColumn(
      text: _numberFormat.format(totalK.ceilToDouble()),
      width: 7,
      styles: PosStyles(align: PosAlign.right),
    ),
  ]);
  ticket.hr(ch: '=');
  ticket.row([
    PosColumn(
      text: 'Diskon',
      width: 5,
    ),
    PosColumn(text: ':', width: 1),
    PosColumn(
      text: _numberFormat.format(blocX.totalDiskon),
      width: 6,
    ),
  ]);
  if (blocX.getSettingPpn != 0) {
    ticket.row([
      PosColumn(
        text: 'PPN',
        width: 5,
      ),
      PosColumn(text: ':', width: 1),
      PosColumn(
        text: _numberFormat.format(blocX.ppn.ceilToDouble()),
        width: 6,
      ),
    ]);
  }

  ticket.row([
    PosColumn(
      text: 'Grand Total',
      width: 5,
    ),
    PosColumn(text: ':', width: 1),
    PosColumn(
      text: _numberFormat.format(blocX.totalHargaPenjualan.ceilToDouble()),
      width: 6,
    ),
  ]);

  ticket.row([
    PosColumn(
      text: 'Jumlah Bayar',
      width: 5,
    ),
    PosColumn(text: ':', width: 1),
    PosColumn(
      text: _numberFormat.format(
          double.parse(blocX.jumlahBayarController.text.replaceAll(',', ''))
              .ceilToDouble()),
      width: 6,
    ),
  ]);

  ticket.row([
    PosColumn(
      text: 'Kembalian',
      width: 5,
    ),
    PosColumn(text: ':', width: 1),
    PosColumn(
      text: _numberFormat.format(blocX.kembalian.ceilToDouble()),
      width: 6,
    ),
  ]);

  // ticket.feed(2);
  ticket.cut();
  return ticket;
}

Future<Ticket> testTicket(PaperSize paper) async {
  final Ticket ticket = Ticket(paper);

  ticket.text(
      'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
      styles: PosStyles(codeTable: PosCodeTable.westEur));
  ticket.text('Special 2: blåbærgrød',
      styles: PosStyles(codeTable: PosCodeTable.westEur));

  ticket.text('Bold text', styles: PosStyles(bold: true));
  ticket.text('Reverse text', styles: PosStyles(reverse: true));
  ticket.text('Underlined text',
      styles: PosStyles(underline: true), linesAfter: 1);
  ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
  ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
  ticket.text('Align right',
      styles: PosStyles(align: PosAlign.right), linesAfter: 1);

  ticket.row([
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col6',
      width: 6,
      styles: PosStyles(align: PosAlign.center, underline: true),
    ),
    PosColumn(
      text: 'col3',
      width: 3,
      styles: PosStyles(align: PosAlign.center, underline: true),
    ),
  ]);

  ticket.text('Text size 200%',
      styles: PosStyles(
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ));

  // # Print image
  // final ByteData data = await rootBundle.load('images/djoeragan.png');
  // final Uint8List bytes = data.buffer.asUint8List();
  // final Image image = decodeImage(bytes);
  // ticket.image(image);
  // Print image using alternative commands
  // ticket.imageRaster(image);
  // ticket.imageRaster(image, imageFn: PosImageFn.graphics);

  // # Print barcode
  // final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
  // ticket.barcode(Barcode.upcA(barData));

  // # Print mixed (chinese + latin) text. Only for printers supporting Kanji mode
  // ticket.text(
  //   'hello ! 中文字 # world @ éphémère &',
  //   styles: PosStyles(codeTable: PosCodeTable.westEur),
  //   containsChinese: true,
  // );

  ticket.feed(2);

  ticket.cut();
  return ticket;
}
