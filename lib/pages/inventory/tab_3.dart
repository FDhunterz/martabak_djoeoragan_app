import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'tambah_opname.dart';

class InventoryTab3 extends StatefulWidget {

  @override 
  _InventoryTab3 createState()=> _InventoryTab3();
}

class _InventoryTab3 extends State<InventoryTab3>{

  Widget listinfo(){
    return Container(
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.blue.withOpacity(0.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 5,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text('REF/1002/334/1',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 3,),

                    Text('12 barang',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w200,
                      ),
                    ),

                    SizedBox(height: 3,),
                    
                    Text('Waiting...',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w200,
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listsuccess(){
    return Container(
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.green.withOpacity(0.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 5,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text('Contoh'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listdanger(){
    return Container(
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.red.withOpacity(0.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 5,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text('Contoh'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listwarning(){
    return Container(
      child: ListTile(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.orange.withOpacity(0.2),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 5,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text('Contoh'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10 , right: 5),
        child: FloatingActionButton( 
          backgroundColor: Colors.white,
          child: Icon(FontAwesomeIcons.plus,
            color: Colors.blue,
            ),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => TambahOpname()));
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              listinfo(),
              listinfo(),
              listinfo(),
              listinfo(),
              listinfo(),
              listinfo(),
              listinfo(),
              listinfo(),
              listinfo(),
              listsuccess(),
              listdanger(),
              listwarning(),
            ],
          ),
        ),
      ),
    );
  }
}