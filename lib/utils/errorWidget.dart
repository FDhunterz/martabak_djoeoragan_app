import 'package:flutter/material.dart';

class ErrorOutputWidget extends StatefulWidget {
  final Function onPress;
  final String errorMessage;
  ErrorOutputWidget({
    this.onPress,
    this.errorMessage,
  });
  @override
  _ErrorOutputWidgetState createState() => _ErrorOutputWidgetState();
}

class _ErrorOutputWidgetState extends State<ErrorOutputWidget> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Container(
          // color: Colors.red,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10.0),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    bottom: 25.0,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.close,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  child: Text(
                    'Error!',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: Text(
                    widget.errorMessage,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    child: Text(
                      'Coba lagi',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: widget.onPress,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
