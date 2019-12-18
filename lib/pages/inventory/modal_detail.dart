
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ModalDetailDataStock extends StatefulWidget{
  @override
  _ModalDetailDataStock createState()=> _ModalDetailDataStock();
}

class _ModalDetailDataStock extends State<ModalDetailDataStock>{

  dialogContent(BuildContext context) {
  return  SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          height: 340,
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1,color: Colors.black.withOpacity(0.1))
                  )
                ),
                child: Text('Detail Stock Item',textAlign: TextAlign.center),
              ),

              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(left: 10),
                      child : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "images/martabak1.jpg",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                bottom: BorderSide(width: 2,color: Colors.black12),
                              )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text('Nama Produk',
                                style: TextStyle(
                                  fontSize: 10
                                ),
                              ),
                              Text('Nama Produknya Apa',
                                style: TextStyle(
                                    fontSize: 12
                                  ),
                              ),
                              ],
                            ),
                          ),

                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                bottom: BorderSide(width: 2,color: Colors.black12),
                              )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text('Nama Produk',
                                style: TextStyle(
                                  fontSize: 10
                                ),
                              ),
                              Text('Nama Produknya Apa',
                                style: TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                bottom: BorderSide(width: 2,color: Colors.black12),
                              )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              Text('Nama Produk',
                                style: TextStyle(
                                  fontSize: 10
                                ),
                              ),
                              Text('Nama Produknya Apa',
                                style: TextStyle(
                                    fontSize: 12
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black26),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset:Offset(1.0 ,1.0),
                        blurRadius: 3,
                        spreadRadius: 2,
                      ),
                    ]
                  ),
                  child :Row(
                    children: <Widget>[
                      Text('a'),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 5.0;
  static const double avatarRadius = 0.0;
}
