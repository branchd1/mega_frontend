import 'package:flutter/material.dart';

class MyAppBars{
  static AppBar myAppBar1() => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
  );

  static AppBar myAppBar2() => AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: <Widget>[
      Image.asset('assets/img/logo/small/logo.png')
    ],
    elevation: 0.0,
  );

  static AppBar myAppBar3() => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: <Widget>[
      Image.asset('assets/img/logo/small/logo.png')
    ],
    elevation: 0.0,
  );
}
