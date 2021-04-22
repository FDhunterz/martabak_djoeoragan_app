import "package:flutter/material.dart";
import 'package:meta/meta.dart';

class MasterPage extends StatefulWidget {
  @override
  _MasterPageState createState() => new _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Color(0xff25282b),
          ),
          title: new Text(
            "Master",
            style: TextStyle(
              color: Color(0xff25282b),
            ),
          ),
          backgroundColor: Colors.white),
      body: new ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return new CustomWidget(
              title: "Title",
              content: "Description",
              trailingIconOne: new Icon(
                Icons.share,
                color: Colors.blueAccent,
              ),
              trailingIconTwo: new Icon(
                Icons.favorite,
                color: Colors.redAccent,
              ),
            );
          }),
    );
  }
}

class CustomWidget extends StatelessWidget {
  final String title;
  final String content;

  final Icon trailingIconOne;

  final Icon trailingIconTwo;

  CustomWidget(
      {@required this.title,
      @required this.content,
      @required this.trailingIconOne,
      @required this.trailingIconTwo});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Color(0xff25282b),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
              ),
              Container(
                height: 3.0,
              ),
              Container(
                child: Text(
                  content,
                  style: TextStyle(
                    color: Color(0xff25282b),
                  ),
                ),
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 50.0,
                    height: 20.0,
                    buttonColor: Color(0xff388bf2),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text("Detail"),
                    ),
                  ),
                  Container(
                    width: 10.0,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
