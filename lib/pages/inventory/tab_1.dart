import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InventoryTab1 extends StatefulWidget{
  @override
  _InventoryTab1 createState()=> _InventoryTab1();
}

class _InventoryTab1 extends State<InventoryTab1>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
        ),
        child:   SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Container(
                        padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.0),
                                  topRight: Radius.circular(3.0),
                                  bottomRight: Radius.circular(3.0),
                                  bottomLeft: Radius.circular(3.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset:Offset(0.0 ,0.0),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ]
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(26 , 179 , 148 , 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100.0),
                                        topRight: Radius.circular(100.0),
                                        bottomRight: Radius.circular(100.0),
                                        bottomLeft: Radius.circular(100.0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(width: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Net Sales',
                                          style: TextStyle(
                                            color: Color.fromRGBO(99 , 110 , 114 , 1),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text('Penjualan Bersih',
                                          style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 10
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(width: 10,),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.0),
                                  topRight: Radius.circular(3.0),
                                  bottomRight: Radius.circular(3.0),
                                  bottomLeft: Radius.circular(3.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset:Offset(0.0 ,0.0),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ]
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(35 , 198 , 200 , 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100.0),
                                        topRight: Radius.circular(100.0),
                                        bottomRight: Radius.circular(100.0),
                                        bottomLeft: Radius.circular(100.0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.access_alarm,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(width: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Penjualan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(99 , 110 , 114 , 1),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text('Viewer',
                                          style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 10
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.only(left: 10 , right: 10,bottom : 10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.0),
                                  topRight: Radius.circular(3.0),
                                  bottomRight: Radius.circular(3.0),
                                  bottomLeft: Radius.circular(3.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset:Offset(0.0 ,0.0),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ]
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(35 , 198 , 200 , 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100.0),
                                        topRight: Radius.circular(100.0),
                                        bottomRight: Radius.circular(100.0),
                                        bottomLeft: Radius.circular(100.0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.access_alarm,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(width: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Penjualan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(99 , 110 , 114 , 1),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text('Viewer',
                                          style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 10
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            SizedBox(width: 10,),

                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(3.0),
                                  topRight: Radius.circular(3.0),
                                  bottomRight: Radius.circular(3.0),
                                  bottomLeft: Radius.circular(3.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset:Offset(0.0 ,0.0),
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                  ),
                                ]
                              ),
                              width: MediaQuery.of(context).size.width * 0.45,
                              padding: EdgeInsets.symmetric(horizontal: 15 , vertical: 15),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(35 , 198 , 200 , 1),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100.0),
                                        topRight: Radius.circular(100.0),
                                        bottomRight: Radius.circular(100.0),
                                        bottomLeft: Radius.circular(100.0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.access_alarm,
                                      color: Colors.white,
                                    ),
                                  ),

                                  SizedBox(width: 10,),

                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.20,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Penjualan',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(99 , 110 , 114 , 1),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text('Viewer',
                                          style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 10
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      LineChartData mainData() {
                        return LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: true,
                            getDrawingHorizontalLine: (value) {
                              return const FlLine(
                                color: Color(0xff37434d),
                                strokeWidth: 1,
                              );
                            },
                            getDrawingVerticalLine: (value) {
                              return const FlLine(
                                color: Color(0xff37434d),
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 22,
                              textStyle: TextStyle(
                                  color: const Color(0xff68737d),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 2:
                                    return 'MAR';
                                  case 5:
                                    return 'JUN';
                                  case 8:
                                    return 'SEP';
                                }
                                return '';
                              },
                              margin: 8,
                            ),
                            leftTitles: SideTitles(
                              showTitles: true,
                              textStyle: TextStyle(
                                color: const Color(0xff67727d),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 1:
                                    return '10k';
                                  case 3:
                                    return '30k';
                                  case 5:
                                    return '50k';
                                }
                                return '';
                              },
                              reservedSize: 28,
                              margin: 12,
                            ),
                          ),
                          borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: const Color(0xff37434d), width: 1)),
                          minX: 0,
                          maxX: 11,
                          minY: 0,
                          maxY: 6,
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 3),
                                FlSpot(2.6, 2),
                                FlSpot(4.9, 5),
                                FlSpot(6.8, 3.1),
                                FlSpot(8, 4),
                                FlSpot(9.5, 3),
                                FlSpot(11, 4),
                              ],
                              isCurved: true,
                              colors: gradientColors,
                              barWidth: 5,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(
                                show: false,
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                colors:
                                    gradientColors.map((color) => color.withOpacity(0.3)).toList(),
                              ),
                            ),
                          ],
                        );
                      }

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}