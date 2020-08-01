import 'package:flutter/material.dart';

AppBar myAppBar1() => AppBar(
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  elevation: 0.0,
);

AppBar myAppBar2() => AppBar(
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
  actions: <Widget>[
    Image.asset('assets/img/logo/small/logo.png')
  ],
  elevation: 0.0,
);