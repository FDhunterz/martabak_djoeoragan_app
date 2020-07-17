import 'package:flutter/material.dart';
// import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:martabakdjoeragan_app/core/api.dart';
import 'package:martabakdjoeragan_app/utils/errorWidget.dart';
import 'package:shimmer/shimmer.dart';

dynamic request;
bool _isError;
String _errorMessage;

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  getuser() async {
    setState(() {
      _isError = false;
    });
    request = null;
    request = await RequestGet(
      name: 'user/profile/resource',
      customrequest: '',
    ).getdata();

    if (request == 'token expired') {
      setState(() {
        _isError = true;
        _errorMessage = 'Token kedaluwarsa, silahkan login kembali';
      });
    } else if (request == 'failure') {
      setState(() {
        _isError = true;
        _errorMessage = 'Gagal, silahkan coba lagi';
      });
    } else {
      setState(() {
        _isError = false;
      });
    }
  }

  @override
  void initState() {
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: request == null
          ? Center(
              child: loading(),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _isError
                        ? ErrorOutputWidget(
                            errorMessage: _errorMessage,
                            onPress: () {
                              getuser();
                            },
                          )
                        : Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 250,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              request == null
                                                  ? ''
                                                  : request['us_pegawai'] ==
                                                          null
                                                      ? request['us_username']
                                                      : request['pegawai']
                                                          ['p_nama'],
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              request['pegawai'] != null &&
                                                      request['pegawai']
                                                              ['jabatan'] !=
                                                          null &&
                                                      request['pegawai']
                                                                  ['jabatan']
                                                              ['pos_nama'] !=
                                                          null
                                                  ? request['pegawai']
                                                      ['jabatan']['pos_nama']
                                                  : 'unknown',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w100,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      left: 40,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 3, color: Colors.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0.00, 2.0),
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                blurRadius: 3)
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            'images/support.png',
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 2,
                                      color: Colors.black.withOpacity(0.15),
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        request['pegawai'] != null &&
                                                request['pegawai']['p_agama'] !=
                                                    null
                                            ? request['pegawai']['p_agama']
                                            : 'unknown',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        request['pegawai'] != null &&
                                                request['pegawai']
                                                        ['p_tempat_lahir'] !=
                                                    null
                                            ? request['pegawai']
                                                ['p_tempat_lahir']
                                            : 'unknown',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        request['pegawai'] != null &&
                                                request['pegawai']
                                                        ['p_pendidikan'] !=
                                                    null
                                            ? request['pegawai']['p_pendidikan']
                                            : 'unknown',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: ButtonTheme(
                        height: 50,
                        child: RaisedButton(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          onPressed: () async {
                            await Auth().logout(context);
                            Navigator.pushReplacementNamed(context, '/splash');
                          },
                          child: Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget loading() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          viewloading(0.9, 100),
          viewloading(0.9, 10),
          viewloading(0.7, 10),
          SizedBox(
            height: 10,
          ),
          viewloading(0.9, 100),
          viewloading(0.9, 10),
          viewloading(0.7, 10),
          SizedBox(
            height: 10,
          ),
          viewloading(0.9, 100),
          viewloading(0.9, 10),
          viewloading(0.7, 10),
        ],
      ),
    );
  }

  viewloading(double sizecustom, double heightcustom) {
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

class ProfileModel {}
