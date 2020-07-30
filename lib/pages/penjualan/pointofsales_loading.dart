import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        margin: EdgeInsets.all(20),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
      ),
    );
  }
}

class FiturPOSLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          // color: Color(0xff4c1b37),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fitur Point Of Sales',
                    style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  MenuTileLoading(),
                  MenuTileLoading(),
                  MenuTileLoading(),
                  MenuTileLoading(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuTileLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 25,
            height: 25,
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
            // color: Colors.white,
            child: Text(
              'Memuat',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class POSTileVerticalLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: Colors.white,
                  height: 70,
                  width: 70,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width - 130,
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      child: Text(
                        'nama',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      width: 125,
                      child: Text(
                        'desc',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.blueGrey[300],
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          color: Colors.white,
                          width: 100,
                          child: Container(
                            child: Text(
                              'Rp. 250.000,000',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        Container(
                          height: 25,
                          width: 100,
                          color: Colors.white,
                        ),
                      ],
                    ),
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
