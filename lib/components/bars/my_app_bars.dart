import 'package:flutter/material.dart';
import 'package:mega/models/state_models/feature_screen_back_button_state_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

/// Contains the different app bars for different app screens
class MyAppBars{
  /// White app bar
  /// No items atop
  static AppBar myAppBar1() => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    elevation: 0.0,
    brightness: Brightness.light,
  );

  /// App bar containing logo
  static AppBar myAppBar2() => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: <Widget>[
      Image.asset('assets/img/logo/small/logo.png')
    ],
    elevation: 0.0,
    brightness: Brightness.light,
  );

  /// Feature interpreter page app bar
  /// App bar contains with logo, specific back button route and specific instructions
  static AppBar myAppBar3(BuildContext context, {VoidCallback onPop, bool isFirstScreen}) => AppBar(
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

    // only show if set
    leading: !isFirstScreen && Provider.of<FeatureScreenBackButtonStateModel>(context).showBackButton ?
      new IconButton(
        icon: new Icon(Icons.arrow_back_ios),
        onPressed: onPop
      ) : Container(),
    brightness: Brightness.light,
  );

  /// App bar for Community list screen
  /// Contains specific back button route
  static AppBar myAppBar4(BuildContext context, {String logoUrl}) => AppBar(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    actions: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
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
    brightness: Brightness.light,
  );
}
