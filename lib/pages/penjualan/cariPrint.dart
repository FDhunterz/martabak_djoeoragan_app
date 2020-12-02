// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:escposprinter/escposprinter.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import 'escpos_function.dart';

// class CariPrint extends StatefulWidget {
//   @override
//   _CariPrintState createState() => new _CariPrintState();
// }

// class _CariPrintState extends State<CariPrint> {
//   List devices = [];
//   bool connected = false;

//   @override
//   initState() {
//     super.initState();
//     _list();
//   }

//   _list() async {
//     List returned;
//     try {
//       returned = await Escposprinter.getUSBDeviceList;
//     } on PlatformException {
//       //response = 'Failed to get platform version.';
//     }
//     setState(() {
//       devices = returned;
//     });
//   }

//   _connect(int vendor, int product) async {
//     bool returned;
//     try {
//       returned = await Escposprinter.connectPrinter(vendor, product);
//     } on PlatformException {
//       Fluttertoast.showToast(msg: 'Failed to get platform version.');
//     }
//     if (returned) {
//       setState(() {
//         connected = true;
//       });
//     } else {
//       setState(() {
//         connected = false;
//       });
//     }
//   }

//   // ignore: unused_element
//   _print() async {
//     try {
//       await Escposprinter.printText("Testing ESC POS printer...\n");
//       await Escposprinter.printText("Testing ESC POS printer...\n");
//       await Escposprinter.printText("Testing ESC POS printer...\n");
//       await Escposprinter.printText("Testing ESC POS printer...\n");
//       await Escposprinter.printText("Testing ESC POS printer...\n");
//       await Escposprinter.printText("\n\n\n\n\n");
//       await Escposprinter.printText("\x1d\x56\x00");
//     } on PlatformException {
//       //response = 'Failed to get platform version.';
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text('Daftar Perangkat USB'),
//       ),
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           new FloatingActionButton(
//               child: new Icon(Icons.refresh),
//               onPressed: () {
//                 _list();
//               }),
//           connected == true
//               ? Container(
//                   margin: EdgeInsets.only(top: 10.0),
//                   child: new FloatingActionButton(
//                     child: new Icon(Icons.print),
//                     onPressed: () {
//                       printKasir('Nota/percobaan/001', context);
//                     },
//                   ),
//                 )
//               : new Container(
//                   width: 0.0,
//                   height: 0.0,
//                 ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () {
//           _list();
//           return Future.value({});
//         },
//         child: new ListView(
//           scrollDirection: Axis.vertical,
//           children: _buildList(devices),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildList(List devices) {
//     return devices.length != 0
//         ? devices
//             .map(
//               (device) => new ListTile(
//                 onTap: () {
//                   _connect(int.parse(device['vendorid']),
//                       int.parse(device['productid']));
//                 },
//                 leading: new Icon(Icons.usb),
//                 title:
//                     new Text(device['manufacturer'] + " " + device['product']),
//                 subtitle:
//                     new Text(device['vendorid'] + " " + device['productid']),
//               ),
//             )
//             .toList()
//         : [
//             ListTile(
//               title: Text(
//                 'Daftar Perangkat Kosong',
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ];
//   }
// }
