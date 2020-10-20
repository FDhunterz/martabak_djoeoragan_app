import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:martabakdjoeragan_app/pages/inventory/tab_2.dart';
import 'tambah_opname.dart';

TextEditingController uqty = TextEditingController();
TextEditingController catatanC = TextEditingController();
class IsiForm extends StatefulWidget{
  _IsiForm createState()=> _IsiForm();
}

class _IsiForm extends State<IsiForm>{

  void initState() {
    catatanC = TextEditingController(text: catatan);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: 230 + MediaQuery.of(context).viewInsets.bottom,
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0))),
        child : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Isi Form Ini',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10,),
                
                TextField(
                  controller: catatanC,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.0,
                    color: Color(0xff25282b),
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Catatan",
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
                  maxLines: 4,
                ),

                SizedBox(height: 10,),

                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(3.0),
                  color: Color(0xfffbaf18),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      catatan = catatanC.text;
                      Navigator.pop(context);
                    },
                    child: Text("Simpan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                      ),
                    ),
                  ),
                )
              
              ],
            ), 
          ),
        )
      ),
    );
  }
}

class IsiGudang extends StatefulWidget{
  _IsiGudang createState()=> _IsiGudang();
}

class _IsiGudang extends State<IsiGudang>{
  konfirmasi(gudang){
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
              onPressed: () async {
                Navigator.pop(context);
                await ubahgudang(gudang);
              },
            ),

          ],
        );
      },
    );
  }

  ubahgudang(gudang){
    selectedgudang = gudang;
    listproduksementara = [];
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        child : SingleChildScrollView(
          child: new Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Ganti Gudang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height:10),

                ListTile(
                  onTap:() async {
                    if(listproduksementara.length != 0){
                      await konfirmasi('1');
                    }else{
                      await ubahgudang('1');
                    }
                    setState(() {
                        
                      });
                  } ,
                  leading: selected == null ? Icon(
                    Icons.check,
                    color: Color(0xfffbaf18),
                  ) : Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  title: Text(
                      'Gudang 1',
                      style: TextStyle(
                        color: Color(0xfffbaf18),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                ),
              ],
            ), 
          ),
        )
      ),
    );
  }
}

class UbahQty extends StatefulWidget{
  final code;
  final qty;
  UbahQty({Key key , this.code , this.qty});
  _UbahQty createState()=> _UbahQty(code: code , qty: qty);
}

class _UbahQty extends State<UbahQty>{
  var code;
  var qty;

  _UbahQty({Key key, this.code , this.qty});

  void initState() {
    uqty = TextEditingController(text: qty.toString());
    super.initState();
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

      listproduksementara[i].qty = int.parse(uqty.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        height: 180 + MediaQuery.of(context).viewInsets.bottom,
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
        decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0))),
        child : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Ubah Qty',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10,),
                
                TextField(
                  controller: uqty,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16.0,
                    color: Color(0xff25282b),
                ),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Stock",
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
                  maxLines: 1,
                ),

                SizedBox(height: 10,),

                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(3.0),
                  color: Color(0xfffbaf18),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      await ubahqty(uqty,code);
                      Navigator.pop(context);
                    },
                    child: Text("Simpan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                      ),
                    ),
                  ),
                )
              
              ],
            ), 
          ),
        )
      ),
    );
  }
}