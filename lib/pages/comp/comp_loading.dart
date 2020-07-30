import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CompHeaderLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 15,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
            Container(
              height: 15,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
            Container(
              height: 15,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
            Container(
              height: 15,
              width: 150,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
          ],
        ),
      ),
    );
  }
}

class CompContentLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Text(
                'Cabang yang digunakan untuk login',
              ),
            ),
            Container(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10),
                // width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('~ Pilih Cabang'),
                    ),
                    // Icon(
                    //   Icons.chevron_right,
                    //   color: Colors.blue,
                    // )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.white,
              child: Text(
                'Cabang yang digunakan untuk login',
              ),
            ),
            Container(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: 10),
                // width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text('~ Pilih Cabang'),
                    ),
                    // Icon(
                    //   Icons.chevron_right,
                    //   color: Colors.blue,
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompFooterLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 15,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
            Container(
              height: 15,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
            Container(
              height: 15,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
            Container(
              height: 15,
              width: 100,
              color: Colors.white,
              margin: EdgeInsets.only(bottom: 8),
            ),
          ],
        ),
      ),
    );
  }
}
