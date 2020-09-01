
import 'package:flutter/material.dart';

class EmptyText extends StatelessWidget{
  final String text;
  final String subtext;

  const EmptyText({Key key, @required this.text, this.subtext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.search,
          size: 100,
        ),
        Container(
          child: Text(text, textScaleFactor: 1.5,),
          alignment: Alignment.center,
        ),
        if(subtext != null) Container(
          child: Text(subtext),
          alignment: Alignment.center,
        )
      ],
    );
  }
}