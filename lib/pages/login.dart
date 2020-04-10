import 'package:flutter/material.dart';
// import 'package:martabakdjoeragan_app/utils/Navigator.dart';
import '../core/api.dart';

TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
FocusNode usernameFocus = FocusNode();
FocusNode passwordFocus = FocusNode();
bool loading = false;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // List headsession = ['nama','username','id','nomor','jenis'];
  // List getsession = ['m_name','m_username','m_id','m_phone','m_gender'];
  login() async {
    // await Auth(username: username,password: password ,name: 'login',nameStringsession: headsession , dataStringsession: getsession).getuser();
    dynamic login =
        await Auth(username: username.text, password: password.text).proses();
    if (login == 'success') {
      Navigator.pushReplacementNamed(context, "/dashboard");
    }

    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      controller: username,
      focusNode: usernameFocus,
      autofocus: true,
      obscureText: false,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16.0,
        color: Color(0xff25282b),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Nama Pengguna",
        hintStyle: TextStyle(
            fontWeight: FontWeight.w300, color: Colors.black38, fontSize: 14),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.black38)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
          ),
        ),
      ),
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(passwordFocus);
      },
    );
    final passwordField = TextField(
      controller: password,
      focusNode: passwordFocus,
      obscureText: true,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 16.0,
        color: Color(0xff25282b),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Kata Sandi",
        hintStyle: TextStyle(
            fontWeight: FontWeight.w300, color: Colors.black38, fontSize: 14),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.black38)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
          ),
        ),
      ),
      onEditingComplete: () {
        login();
      },
    );
    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(3.0),
      color: Color(0xfffbaf18),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          // setState(() {
          //   loading = true;
          // });
          // await login();
          // setState(() {
          //   loading = false;
          // });
          // Navigator.pushReplacementNamed(context, "/pos");
          // Navigator.pushReplacementNamed(context, "/dashboard");
          login();
        },
        child: Text(
          "Masuk",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontFamily: 'Roboto',
            fontSize: 14.0,
          ),
        ),
      ),
    );
    final adsSection = Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Text(
            "Belum Menggunakan Alamraya Software+ ?",
            style: TextStyle(
              color: Colors.grey[500],
              fontFamily: 'Roboto',
              fontSize: 11.0,
            ),
          ),
          SizedBox(height: 10),
          OutlineButton(
            padding: EdgeInsets.fromLTRB(20.0, 1.0, 20.0, 1.0),
            onPressed: () {
              // MyNavigator.goToDashboard(context);
            },
            child: Text(
              "Hubungi Kami Segera",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Roboto',
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
    final footer = Text(
      "Powered by Alamraya Software v.1.0 © 2019",
      style:
          TextStyle(color: Colors.grey, fontFamily: 'Roboto', fontSize: 10.0),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(27.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 160.0,
                    child: Center(
                      child: Image.asset(
                        "images/djoeragan.png",
                        height: 500.0,
                        width: 500.0,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                              bottom:
                                  BorderSide(width: 1, color: Colors.black45),
                            )),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: BorderDirectional(
                              bottom:
                                  BorderSide(width: 1, color: Colors.black45),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  usernameField,
                  SizedBox(height: 15.0),
                  passwordField,
                  SizedBox(
                    height: 15.0,
                  ),
                  loginButton,
                  SizedBox(
                    height: 15.0,
                  ),
                  adsSection,
                  SizedBox(
                    height: 15.0,
                  ),
                  footer,
                  SizedBox(
                    height: 1.0,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
