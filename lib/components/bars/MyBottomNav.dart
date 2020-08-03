import 'package:flutter/material.dart';
import 'package:mega/services/Constants.dart';

class MyBottomNav extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home), onPressed: () {},),
            IconButton(icon: Icon(Icons.search), onPressed: () {},),
            IconButton(icon: Icon(Icons.person), onPressed: () {},),
          ],
        ),
        color: Color(Constants.grey),
      ),
      height: 60,
    );
  }
}