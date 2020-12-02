import 'package:flutter/material.dart' hide Image;
import 'package:provider/provider.dart';
import 'cari_bluetooth_bloc.dart';

class CariPrintBluetooth extends StatefulWidget {
  CariPrintBluetooth({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _CariPrintBluetoothState createState() => _CariPrintBluetoothState();
}

class _CariPrintBluetoothState extends State<CariPrintBluetooth> {
  @override
  void initState() {
    super.initState();

    CariBluetoothBloc blocX = context.read<CariBluetoothBloc>();
    blocX.initial();
  }

  @override
  Widget build(BuildContext context) {
    CariBluetoothBloc bloc = Provider.of<CariBluetoothBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          FlatButton.icon(
            textColor: Colors.white,
            icon: Icon(Icons.print),
            label: Text('Tes Print'),
            onPressed: () {
              bloc.print(context, 'Nota-percobaan/001');
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: bloc.listPrinterBluetooth.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                bloc.selectedPrinterBluetooth =
                    bloc.listPrinterBluetooth[index];
              },
              child: Stack(
                children: [
                  Positioned(
                      top: 7,
                      right: 7,
                      child: bloc.selectedPrinterBluetooth != null
                          ? bloc.selectedPrinterBluetooth.address ==
                                  bloc.listPrinterBluetooth[index].address
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                )
                              : Container()
                          : Container()),
                  Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints(minWidth: 100),
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.print),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(bloc.listPrinterBluetooth[index].name ??
                                      ''),
                                  Text(
                                      bloc.listPrinterBluetooth[index].address),
                                  Text(
                                    'Tap untuk memilih print',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ],
              ),
            );
          }),
      floatingActionButton: StreamBuilder<bool>(
        stream: bloc.printerManager.isScanningStream,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: bloc.cancelScan,
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
              child: Icon(Icons.search),
              onPressed: bloc.startScan,
            );
          }
        },
      ),
    );
  }
}
