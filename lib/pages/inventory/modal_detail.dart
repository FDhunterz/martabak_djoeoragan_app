
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ModalDetailDataStock extends StatefulWidget{
  var name , code , stock , safety , max , cycle , lastopname , nextopname , image , satuan;

  ModalDetailDataStock({Key key , this.safety , this.code, this.cycle , this.lastopname , this.max , this.name , this.nextopname , this.stock , this.image , this.satuan});
  @override
  _ModalDetailDataStock createState()=> _ModalDetailDataStock(name: name , code: code, stock: stock, safety:safety , max: max, cycle: cycle, lastopname: lastopname, nextopname: nextopname , image : image , satuan : satuan);
}

class _ModalDetailDataStock extends State<ModalDetailDataStock>{

  var name , code , stock , safety , max , cycle , lastopname , nextopname , image , satuan;

  _ModalDetailDataStock({Key key , this.safety , this.code, this.cycle , this.lastopname , this.max , this.name , this.nextopname , this.stock , this.image , this.satuan});

  dialogContent(BuildContext context) {
  return  SingleChildScrollView(
    child: Column(
      children: <Widget>[
        Container(
          height: 360,
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
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
                          image != null ? image : "images/martabak1.jpg",
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 20,
                      child : Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                // width: double.infinity,
                                padding: EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(width: 1,color: Colors.black12),
                                  )
                                ),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                    Text('Nama Produk',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black38
                                      ),
                                    ),
                                    Text(name != null ? name :'',
                                      style: TextStyle(
                                          fontSize: 12
                                        ),
                                    ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 10,),

                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                // width: double.infinity,
                                width: MediaQuery.of(context).size.width * 1,
                                decoration: BoxDecoration(
                                  border: BorderDirectional(
                                    bottom: BorderSide(width: 1,color: Colors.black12),
                                  )
                                ),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                    Text('Kode Produk',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black38
                                      ),
                                    ),
                                    Text(code != null ? code : '',
                                      style: TextStyle(
                                          fontSize: 12
                                        ),
                                    ),
                                    ],
                                  ),
                                )
                              ),
                              
                            ],
                          ),
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10,),

              Container(
                width: double.infinity,
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black12),
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

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 5 , bottom : 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(width: 1,color: Colors.black.withOpacity(0.1))
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Stock Saat Ini',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(stock != null ? stock.toString() : '',
                                  style: TextStyle(
                                    color: Color.fromRGBO(35 , 198 , 200, 1)
                                  ),
                                ),
                              ],
                            ), 
                          )
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 5 , bottom : 5),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Safety Stock',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(safety != null ? safety.toString() : '',
                                  style: TextStyle(
                                    color: Color.fromRGBO(35 , 198 , 200, 1)
                                  ),
                                ),
                              ],
                            ), 
                          )
                        ),
                      ),

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 5 , bottom : 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(width: 1,color: Colors.black.withOpacity(0.1))
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Nilai maksimal',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                                Text(max != null ? max.toString() : '',
                                  style: TextStyle(
                                    color: Color.fromRGBO(35 , 198 , 200, 1)
                                  ),
                                ),
                              ],
                            ), 
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 70,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1,color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
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

                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 5 , bottom : 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(width: 1,color: Colors.black.withOpacity(0.1))
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Cycle time',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                                Text( cycle != null ? cycle.toString() :  '',
                                  style: TextStyle(
                                    color: Colors.green
                                  ),
                                ),
                              ],
                            ), 
                          )
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 5 , bottom : 5),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Last Opname',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                                Text( lastopname != null ? lastopname : '',
                                  style: TextStyle(
                                    color: Colors.green
                                  ),
                                ),
                              ],
                            ), 
                          )
                        ),
                      ),

                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(top: 5 , bottom : 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(width: 1,color: Colors.black.withOpacity(0.1))
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text('Next Opname',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                  ),
                                ),
                                Text( nextopname != null ? nextopname : '',
                                  style: TextStyle(
                                    color: Colors.green
                                  ),
                                ),
                              ],
                            ), 
                          )
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              Center(
                child: Text('Nilai satuan yang digunakan adalah ' + satuan,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 10
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
