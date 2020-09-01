import 'package:flutter/material.dart';
import 'package:mega/services/constants.dart';

import '../texts/main_text.dart';

class MyCard extends StatelessWidget{
  final List<String> texts;
  final List<String> subTexts;
  final String imageUrl;

  const MyCard({Key key, @required this.texts, this.subTexts, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Stack(
          children: <Widget>[
            if(imageUrl != null) ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageUrl)
                  ),
                ),
              ),
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
                        ...texts.map((text) => MainText(text, textCenter: true)).toList(),
                        if(subTexts != null) ...subTexts.map((text) => Text(text, textAlign: TextAlign.center,)).toList(),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                    ),
                    padding: EdgeInsets.all(2),
                  ),
                  width: double.infinity,
                  color: Color(transGrey),
                )
              ),
            ),
          ],
        ),
        color: Color(grey),
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