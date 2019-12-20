import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'isi_form.dart';

var selected = 'ada';
List<ProdukAwal> listprodukawal = [];
List<ProdukSementara> listproduksementara = [];
List<Gudang> listgudang = [];
String catatan ;
var selectedgudang;
bool loading = true;

class TambahOpname extends StatefulWidget {
  @override
  _TambahOpname createState() => _TambahOpname();
}

class _TambahOpname extends State<TambahOpname>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getproduk(){
    listprodukawal = [];
    for(var i = 0 ; i < 10 ; i++){
      ProdukAwal awal = ProdukAwal(
        code: '$i',
        deskripsi: 'ini deskripsi $i',
        nama: 'Produk $i',
        satuan: 'Satuan $i',
        stock: i + 10,
        checked: false,
      );
      listprodukawal.add(awal);
    }
    setState(() {    
      loading = false;
    });
  }

  getgudang(){

  }

  tambah(code){
    for(var i = 0;i < listproduksementara.length;i++){
        ProdukSementara appen = ProdukSementara(
          code: listproduksementara[i].code,
          qty: listproduksementara[i].qty + 1,
          nama: listproduksementara[i].nama,
          deskripsi: listproduksementara[i].deskripsi,
        );

      if(code == listproduksementara[i].code){
        listproduksementara.removeWhere((c)=> c.code == code);
        listproduksementara.add(appen);
      }else{
        listproduksementara.add(appen);
      }
    }
  }

  kurang(code){
    for(var i = 0;i < listproduksementara.length;i++){
      if(listproduksementara[i].qty > 0){
        ProdukSementara appen = ProdukSementara(
          code: listproduksementara[i].code,
          qty: listproduksementara[i].qty - 1,
          nama: listproduksementara[i].nama,
          deskripsi: listproduksementara[i].deskripsi,
        );

        if(code == listproduksementara[i].code){
          listproduksementara.removeWhere((c)=> c.code == code);
          listproduksementara.add(appen);
        }else{
          listproduksementara.add(appen);
        }
      }
    }
  }

  tambahsementara(code){
    print(code);
    print('code');
    for(var i = 0 ; i < listprodukawal.length;i++){
      if(listprodukawal[i].code == code && listprodukawal[i].checked == true){
        ProdukSementara semenrtara = ProdukSementara(
          code: listprodukawal[i].code,
          deskripsi: listprodukawal[i].deskripsi,
          nama: listprodukawal[i].nama,
          qty: 1,
          satuan: listprodukawal[i].satuan,
          stock: listprodukawal[i].stock,
        );
        listproduksementara.add(semenrtara);
      }else if(listprodukawal[i].code == code && listprodukawal[i].checked == false){
        listproduksementara.removeWhere((c)=> c.code == code);
      }
    }
  }

@override
  void initState() {
    loading = true;
    getproduk();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextField(
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16.0,
                      color: Color(0xff25282b),
                  ),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      hintText: "Cari...",
                      icon: Icon(
                        FontAwesomeIcons.search,
                        color: Colors.black38,
                      ),
                      hintStyle: TextStyle(fontWeight: FontWeight.w300, color: Colors.black38, fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.black38)),
                      border:
                      OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5.0),
                          topRight: Radius.circular(5.0),
                          bottomRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                      )
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(
                    child: Column(
                      children: listprodukawal.map(( ProdukAwal f) => InkWell(
                      onTap: (){
                          if(f.checked == true){
                            setState(() {                          
                              f.checked = false;
                              tambahsementara(f.code);
                            });
                          }else{
                            setState(() {                          
                              f.checked = true;
                              tambahsementara(f.code);
                            });
                          }
                        },
                      child : ListTile(
                      title: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(f.nama != null ? f.nama : ''),
                              ),
                              
                              Checkbox(
                                value: f.checked,
                                onChanged: (isinya){
                                  print(listproduksementara.length);
                                  setState(() {
                                    f.checked = isinya;                              
                                    tambahsementara(f.code);
                                  });
                                },
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),).toList(), 
                    ),
                  ),
                ],
              ),
            ),
          )
        )
      ),
      floatingActionButton: FloatingActionButton( 
          backgroundColor: Colors.white,
          child: Icon(FontAwesomeIcons.plus,
            color: Color(0xfffbaf18),
            ),
          onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Color(0xfffbaf18),
          leading: null,
          titleSpacing: 0,
          title: Text('Opname Stock'),
          actions: <Widget>[
            Container(
              width: 50,
              margin: EdgeInsets.only(right:10),
              child: Material(
                child: InkWell(
                  onTap: (){
                    popupbawah(IsiForm());
                  },
                  child: Icon(FontAwesomeIcons.clipboard,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                color: Color(0xfffbaf18),
              ),
            ),

            Container(
              width: 50,
              margin: EdgeInsets.only(right:10),
              child: Material(
                child: InkWell(
                  onTap: (){
                    popupbawah(IsiGudang());
                  },
                  child: Icon(FontAwesomeIcons.cog,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                color: Color(0xfffbaf18),
              ),
            ),
          ],
        )
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child : SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal:10 , vertical: 5),
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border : Border(
                      top: BorderSide(width: 1,color: Color(0xfffbaf18)),
                      left: BorderSide(width: 10,color: Color(0xfffbaf18)),
                      right: BorderSide(width: 1,color: Color(0xfffbaf18)),
                      bottom: BorderSide(width: 1,color: Color(0xfffbaf18))
                    ),
                  ),
                  child: Column(
                    children: listproduksementara.map((ProdukSementara f) => ListTile(
                      onLongPress: () => popupbawah(UbahQty()),
                      title: Text('Produk 1'),
                      subtitle: Text('Ini adalah Produk 1'),
                      trailing: Container(
                        padding: EdgeInsets.all(3),
                        width: 84,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  kurang(f.code);
                                },
                                child: const Text(
                                    '-',
                                    style: TextStyle(fontSize: 15, color: Color(0xfffbaf18))
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 15.0, left: 15.0),
                              child: Text(
                                f.qty != null ? f.qty.toString() : '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  tambah(f.code);
                                },
                                child: const Text(
                                    '+',
                                    style: TextStyle(fontSize: 20, color: Color(0xfffbaf18))
                                ),
                              ),
                            ),
                          ],
                        )
                      ),
                    ),).toList(),
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void popupbawah(target) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white.withOpacity(0),
      context: context,
      builder: (BuildContext context) => target,
    );
    setState(() {
      
    });
  }
}

class ProdukAwal{
  var stock;
  var nama;
  var code;
  var satuan;
  bool checked;
  var deskripsi;

  ProdukAwal({Key key , this.code , this.deskripsi , this.nama , this.satuan , this.stock , this.checked});
}

class ProdukSementara{
  var stock;
  var nama;
  var code;
  var satuan;
  var deskripsi;
  var qty;

  ProdukSementara({Key key , this.code , this.deskripsi , this.nama , this.satuan , this.stock , this.qty});
}

class Gudang{
  var nama;
  var code;

  Gudang({Key key , this.code , this.nama});
}
