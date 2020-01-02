import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:martabakdjoeragan_app/pages/dashboard.dart';
import 'package:shimmer/shimmer.dart';
import 'isi_form.dart';

var selected = 'ada';
List<ProdukAwal> listprodukawal = [];
List<ProdukSementara> listproduksementara = [];
List<SearchProduk> listsearchproduk = [];
List<Gudang> listgudang = [];
String catatan = '' ;
String textsearch;
TextEditingController searchController = TextEditingController();
var selectedgudang;
bool loading = true;
double buttonwidth = 84;
DateTime currentBackPressTime;

class TambahOpname extends StatefulWidget {
  @override
  _TambahOpname createState() => _TambahOpname();
}

class _TambahOpname extends State<TambahOpname>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  searchproduk(judul){
    listsearchproduk = [];

    for(var i = 0;i < listprodukawal.length; i++){
      if(listprodukawal[i].nama.toUpperCase() == judul.toUpperCase()){
        print('ok');
      }
    }
  }

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

    if(listproduksementara.length > 0){
      for(var i = 0 ; i < listprodukawal.length ; i++){
        for(var j = 0 ; j < listproduksementara.length ; j++){
          if(listproduksementara[j].code == listprodukawal[i].code){
            listprodukawal[i].checked = true;
          }
        }
      }
    }
    setState(() {    
      loading = false;
    });
  }

  getgudang() async {
  }

  ubahqty(qty,code){
    for(var i = 0;i < listproduksementara.length;i++){
      if(listproduksementara[i].code == code){
        for(var j = 0;j < listproduksementara.length;j++){
        if(listproduksementara[j].qty < int.parse(uqty.text)){
          if(int.parse(uqty.text) < 100){
            buttonwidth = 84;
          }else if(int.parse(uqty.text) > 99 && int.parse(uqty.text) < 1000){
            buttonwidth = 99;
          }else if (int.parse(uqty.text) > 999 && int.parse(uqty.text) < 10000){
            buttonwidth = 110;
          }else if (int.parse(uqty.text) > 9999 && int.parse(uqty.text) < 100000){
            buttonwidth = 120;
          }else if (int.parse(uqty.text) > 99999 && int.parse(uqty.text) < 1000000){
            buttonwidth = 130;
          }else{
            buttonwidth = 150;
            }
          }
        }
      }
    }
  }

  tambah(code){
    for(var i = 0;i < listproduksementara.length;i++){
      if(code == listproduksementara[i].code){
        listproduksementara[i].qty = listproduksementara[i].qty + 1;
      }
    }
  }

  kurang(code){
    for(var i = 0;i < listproduksementara.length;i++){
      if(listproduksementara[i].qty > 0){
        if(code == listproduksementara[i].code){
          listproduksementara[i].qty = listproduksementara[i].qty - 1;
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
    listproduksementara = [];
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
                    controller: searchController,
                    onChanged: (data){
                      setState(() {                        
                       textsearch = data;
                      });
                      print(textsearch);
                    },
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
                      children: textsearch != null && textsearch != '' ? 
                        listprodukawal.where((ProdukAwal f) => f.nama.toLowerCase().contains(textsearch.toLowerCase())).map(( ProdukAwal f) => InkWell(
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
                      )
                    ).toList()
                      :
                      listprodukawal.map(( ProdukAwal f) => InkWell(
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
        preferredSize: Size.fromHeight(0.0),
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
                  onTap: ()async {
                    await popupbawah(IsiGudang());
                    setState(() {
                      getproduk();
                    });
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
      body: loading? 
      SingleChildScrollView(
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
      )
      : WillPopScope(
        onWillPop: onWillPop,
          child: Container(
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
                      border :listproduksementara.length == 0 ? null : Border(
                        top: BorderSide(width: 1,color: Color(0xfffbaf18)),
                        left: BorderSide(width: 10,color: Color(0xfffbaf18)),
                        right: BorderSide(width: 1,color: Color(0xfffbaf18)),
                        bottom: BorderSide(width: 1,color: Color(0xfffbaf18))
                      ),
                    ),
                    child: Column(
                      children: listproduksementara.length == 0 ? <Widget> [
                        Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 40),
                    Icon(
                        FontAwesomeIcons.parachuteBox,
                        color: Colors.black26,
                        size:170
                    ),
                    SizedBox(height: 30),
                    Text('tidak Ada barang',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38
                        ),
                    )
                  ],
                ),
              )
            ] : listproduksementara.map((ProdukSementara f) => ListTile(
                        onLongPress: () => popupbawah(UbahQty(qty:f.qty,code:f.code)),
                        title: Text(f.nama != null ? f.nama : ''),
                        subtitle: Text(f.deskripsi != null ? f.deskripsi : ''),
                        trailing: Container(
                          padding: EdgeInsets.all(3),
                          width: buttonwidth,
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
                                child: InkWell(
                                  onTap: () {
                                    setState(() {                                    
                                      kurang(f.code);
                                    });
                                  },
                                  child: const Text(
                                      '-',
                                      style: TextStyle(fontSize: 25, color: Color(0xfffbaf18))
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      f.qty != null ? f.qty.toString() : '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tambah(f.code);
                                    });
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

                listproduksementara.length < 1 ? 
                Container()
                : Container(
                  margin: EdgeInsetsDirectional.only(top: 20),
                  padding: EdgeInsets.only(bottom : 10 , left: 10 , right: 10 ),
                  child: ButtonTheme(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      minWidth: MediaQuery.of(context).size.width * 0.5,
                      height: 50.0,
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: (){
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.check_box,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10,),
                            Text('Simpan Data',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }

  void konfirmasi(){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Apakah Anda Yakin?"),
          content: new Text("Barang Masih Belum Di Simpan!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.pushNamed(context, '/inventory');
              },
            ),

          ],
        );
      },
    );
}

void _konfirmasi(){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Apakah Anda Yakin?"),
          content: new Text("Barang Masih Belum Di Simpan!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => DashboardPage()), (Route<dynamic> route) => false);
              },
            ),

          ],
        );
      },
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

Future<bool> onWillPop() async {
    Widget widget = Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          width: 40.0,
          height: 40.0,
           color: Colors.grey.withOpacity(0.3),
          child: Icon(
            Icons.add,
            size: 30.0,
            color: Colors.green,
          ),
        ),
      ),
    );

    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      if(listproduksementara.length != 0){
        _konfirmasi();
      }else{
        Fluttertoast.showToast(
          msg: "double click untuk kembali"
        );
      }
      return false;
    }
    if(listproduksementara.length != 0){
    return false;
    }
    Navigator.pop(context);
    return false;
    // return true;
  }

  popupbawah(target) async {
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

class SearchProduk{
  var stock;
  var nama;
  var code;
  var satuan;
  bool checked;
  var deskripsi;

  SearchProduk({Key key , this.code , this.deskripsi , this.nama , this.satuan , this.stock , this.checked});
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
