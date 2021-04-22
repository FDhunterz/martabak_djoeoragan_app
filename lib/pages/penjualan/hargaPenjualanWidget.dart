import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';

class HargaPenjualanListTile extends StatefulWidget {
  final HargaPenjualan hargaPenjualan;

  final Function onTap;

  HargaPenjualanListTile({
    this.hargaPenjualan,
    this.onTap,
  });

  @override
  _HargaPenjualanListTileState createState() => _HargaPenjualanListTileState();
}

class _HargaPenjualanListTileState extends State<HargaPenjualanListTile> {
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(5.0),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(5.0),
          child: Stack(
            children: [
              Positioned(
                top: 7,
                right: 7,
                child: widget.hargaPenjualan.selected == '1'
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
              Container(
                height: 75.0,
                child: Center(
                  child: Text(
                    widget.hargaPenjualan.nama,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
