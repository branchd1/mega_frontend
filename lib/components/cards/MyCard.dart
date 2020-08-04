import 'package:flutter/material.dart';
import 'package:mega/services/Constants.dart';

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
            if(imageUrl != null) ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.network(imageUrl),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10)
                ),
                child: Container(
                  child: Padding(
                    child: Column(
                      children: <Widget>[
                        MainText(text),
                        if(subText != null) Text(subText),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                    padding: EdgeInsets.all(2),
                  ),
                  constraints: BoxConstraints.expand(
                    height: 50
                  ),
                  color: Color(Constants.transGrey),
                )
              ),
            ),
          ],
        ),
        color: Color(Constants.grey),
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