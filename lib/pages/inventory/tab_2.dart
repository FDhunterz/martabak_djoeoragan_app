import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'modal_detail.dart';

List<Listproduk> listproduk = [];

class InventoryTab2 extends StatefulWidget{
  @override
  _InventoryTab2 createState()=> _InventoryTab2();
}

class _InventoryTab2 extends State<InventoryTab2>{

  dummy(){
    listproduk = [];
    for(var i = 0 ; i < 15 ; i++){
      Listproduk produk = Listproduk(
        berat: '$i.00',
        cycletime: '$i',
        nama: 'Produk $i',
        safety: '$i',
        tanggalopname: 'terakhir  opname  $i/12/2019',
        satuan: 'kg$i',
      ); 
      listproduk.add(produk);
    }
  }

  @override
  void initState() {
    dummy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:   SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: listproduk.map((Listproduk f)  => Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.5 ),
                  width: double.infinity,
                  child: InkWell(
                    child : Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: BorderDirectional(
                        bottom: BorderSide(width: 1 , color: Colors.black12),
                      ),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            "images/martabak1.jpg",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      subtitle: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              f.tanggalopname,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                ),
                              ),
                          ),
                          
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Text(f.safety,
                                  style: TextStyle(
                                    color: Color.fromRGBO(255, 118 , 117, 1),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(' - '),
                                Text(
                                  f.cycletime+ ' Hari',
                                  style: TextStyle(
                                    color: Color.fromRGBO(35 , 198 , 200, 1),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
                      ),

                      title: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(f.nama,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Container(
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Center(
                              child: Text(f.berat + ' ' + f.satuan,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) => ModalDetailDataStock(),
                    );
                  },
                ),
              )).toList(),
            ),
          ),
        ),
      ),
    ) ;
  }
}

class Listproduk{
  var nama;
  var tanggalopname;
  var berat;
  var safety;
  var cycletime;
  var satuan;
  Listproduk({Key key , this.nama , this.tanggalopname , this.berat , this.cycletime , this.safety, this.satuan});
}