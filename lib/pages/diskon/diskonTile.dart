import 'package:flutter/material.dart';

class DiskonListTile extends StatelessWidget {
  final String kode, nama, periode, akhir;
  final String isActive;
  final Function onTap;

  DiskonListTile({
    this.kode,
    this.nama,
    this.periode,
    this.isActive,
    this.akhir,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 3.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          width: 1.0,
          color: isActive != '0' ? Colors.green : Colors.orange,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: periode == 'expired'
                    ? Colors.red.withOpacity(.2)
                    : Colors.blue.withOpacity(.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                periode,
                style: TextStyle(
                  color: periode == 'expired'
                      ? Colors.red
                      : Colors.blue,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1.0,
                    color: isActive != '0' ? Colors.green : Colors.orange,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Nama Diskon',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          nama,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Kode Diskon',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(
                          kode,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[300].withOpacity(.5),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(akhir),
                  ),
                  Expanded(
                    child: isActive == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Aktif'),
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Aktif'),
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
