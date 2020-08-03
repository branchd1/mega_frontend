import 'package:flutter/material.dart';

import '../texts/MainText.dart';

class MyCard extends StatelessWidget{
  final String text;
  final String subText;
  final String imageUrl;

  const MyCard({Key key, this.text, this.subText, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(imageUrl),
            ),
            Container(
              child: Padding(
                child: Column(
                  children: <Widget>[
                    MainText(text),
                    Text(subText)
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                padding: EdgeInsets.all(10),
              ),
              constraints: BoxConstraints.expand(),
            )
          ],
        ),
        color: Color(0xFFF1F1F1),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      height: 150,
      width: 150,
    );
  }
}