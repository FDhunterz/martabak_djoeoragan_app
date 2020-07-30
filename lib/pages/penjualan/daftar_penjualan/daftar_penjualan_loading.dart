import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DaftarPenjualanLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        margin: EdgeInsets.all(15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 22,
                    width: 250,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    color: Colors.white,
                    height: 18,
                    width: 150,
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              height: 20,
              width: 100,
            ),
          ],
        ),
      ),
    );
  }
}
