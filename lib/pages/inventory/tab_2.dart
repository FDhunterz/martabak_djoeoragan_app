import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/core/api.dart';
import 'package:shimmer/shimmer.dart';
import 'modal_detail.dart';

List<Listproduk> listproduk = [];

class InventoryTab2 extends StatefulWidget{
  @override
  _InventoryTab2 createState()=> _InventoryTab2();
}

class _InventoryTab2 extends State<InventoryTab2>{

  first() async {

    dynamic list = await RequestGet(
      name: 'master/item/get/data',
      customrequest: '',
    ).getdata();

    listproduk = [];
    for(var i = 0 ; i < list.length ; i++){
      Listproduk produk = Listproduk(
        berat: list[i]['stok']['s_qty'],
        leadtime: list[i]['setting']['id_lead_time'],
        nama: list[i]['i_nama'],
        safety: list[i]['setting']['id_safety_stock'],
        tanggalopname: list[i]['i_last_opname'],
        nextopname: list[i]['i_next_opname'],
        satuan: list[i]['s_inisial'],
        code: list[i]['i_kode'],
        stock: list[i]['stok']['s_qty'],
        max: list[i]['setting']['id_stock_max'],
        image: 'images/martabak1.jpg',

      ); 
      print(list[i]['stok']['s_qty']);
      listproduk.add(produk);
    }
    setState(() {
      
    });
  }

  @override
  void initState() {
    listproduk = [];
    first();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listproduk.length < 1 ? loading() :Container(
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
                            f.image,
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
                              'terakhir  opname '+f.tanggalopname,
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
                                  f.leadtime+ ' Hari',
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
                      builder: (BuildContext context) => ModalDetailDataStock(image : f.image,name : f.nama , code : f.code , stock : f.stock , safety : f.safety , max : f.max , leadtime : f.leadtime , lastopname : f.tanggalopname , nextopname : f.nextopname , satuan: f.satuan,),
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
}

class Listproduk{
  var nama;
  var tanggalopname;
  var berat;
  var safety;
  var leadtime;
  var satuan;
  var code;
  var stock;
  var max ; 
  var nextopname;
  var image;
  Listproduk({Key key, this.code , this.max , this.stock, this.nama , this.tanggalopname , this.berat , this.leadtime , this.safety, this.satuan , this.nextopname , this.image});
}