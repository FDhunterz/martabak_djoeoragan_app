import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KuponListTile extends StatefulWidget {
  final String nama,
      catatan,
      maxDiskon,
      isDouble,
      selected,
      persen,
      disabled,
      nominal;

  final Function onTap;

  KuponListTile({
    this.catatan,
    this.nama,
    this.isDouble,
    this.maxDiskon,
    this.selected,
    this.onTap,
    this.persen,
    this.disabled,
    this.nominal,
  });
  @override
  _KuponListTileState createState() => _KuponListTileState();
}

class _KuponListTileState extends State<KuponListTile> {
  NumberFormat _numberFormat = NumberFormat.decimalPattern(
      // name: 'Rp. ',
      // decimalDigits: 0,

      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 3.0,
        bottom: 3.0,
        left: 5.0,
        right: 5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
          width: 0.5,
        ),
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
      child: InkWell(
        onTap: widget.onTap,
        child: Stack(
          children: [
            Positioned(
              top: 7,
              right: 7,
              child: widget.selected == '1'
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
                  : Container(),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        widget.persen != 'null'
                            ? Container(
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: widget.disabled == '0'
                                      ? Colors.blue
                                      : Colors.grey[400],
                                ),
                                width: 50.0,
                                height: 50.0,
                                child: Center(
                                  child: Text(
                                    '${widget.persen} %',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.all(5.0),
                                margin: EdgeInsets.only(right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: widget.disabled == '0'
                                      ? Colors.blue
                                      : Colors.grey[400],
                                ),
                                width: 50.0,
                                height: 50.0,
                                child: Center(
                                  child: Text(
                                    _numberFormat
                                        .format(double.parse(widget.nominal)),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ),
                              ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  widget.nama,
                                  style: TextStyle(
                                    color: widget.disabled == '0'
                                        ? Colors.black
                                        : Colors.grey[400],
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              widget.catatan.isEmpty
                                  ? Text(
                                      'Tidak ada Catatan',
                                      style: TextStyle(
                                        color: widget.disabled == '0'
                                            ? Colors.grey
                                            : Colors.grey[400],
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    )
                                  : Flexible(
                                      child: Text(
                                        widget.catatan,
                                        style: TextStyle(
                                          color: widget.disabled == '0'
                                              ? Colors.black
                                              : Colors.grey[400],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      widget.isDouble == '1'
                          ? Text(
                              'Bisa digabung',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: widget.disabled == '0'
                                    ? Colors.blue
                                    : Colors.grey[400],
                              ),
                            )
                          : Text(
                              'Tidak bisa digabung',
                              style: TextStyle(
                                color: widget.disabled == '0'
                                    ? Colors.red
                                    : Colors.grey[400],
                                fontSize: 12.0,
                              ),
                            ),
                      Container(
                        child: Text(
                          'Max diskon ${_numberFormat.format(double.parse(widget.maxDiskon))}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: widget.disabled == '0'
                                ? Colors.black
                                : Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
