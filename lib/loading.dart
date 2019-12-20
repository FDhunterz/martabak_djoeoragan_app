import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatefulWidget{

  @override 
  _Loading createState() => _Loading();
}

class _Loading extends State<Loading>{
  
  Widget loading(){
    return SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            viewloading(0.9,100),
            viewloading(0.9,10),
            viewloading(0.7,10),
            SizedBox(height: 10,),
            viewloading(0.9,100),
            viewloading(0.9,10),
            viewloading(0.7,10),
            SizedBox(height: 10,),
            viewloading(0.9,100),
            viewloading(0.9,10),
            viewloading(0.7,10),
          ],
        ),
      );
  }

  viewloading(double sizecustom,double heightcustom){
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey[300],
      child: Container(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            height: heightcustom,
            width: MediaQuery.of(context).size.width * sizecustom,
            color: Colors.grey,
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}