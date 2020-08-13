import 'package:flutter/material.dart';
import 'package:mega/screens/home/home_screen.dart';

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

  static AppBar myAppBar4(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: <Widget>[
      Image.asset('assets/img/logo/small/logo.png')
    ],
    elevation: 0.0,
    leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
        }
    ),
  );

  static AppBar myAppBar5(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: <Widget>[
      new IconButton(
        icon: new Icon(Icons.close),
        onPressed: (){
          Navigator.pop(context);
        }
      )
    ],
    elevation: 0.0,

    // only show when some data is fed through consumer
    leading: new IconButton(
      icon: new Icon(Icons.arrow_back_ios),
      onPressed: (){
        // feed some data through consumer
      }
    ),
  );

  static AppBar myAppBar6(BuildContext context, {String logoUrl}) => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.network(logoUrl),
        ),
      )
    ],
    elevation: 0.0,
    leading: new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        onPressed: (){
          Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
        }
    ),
  );
}
