import 'package:flutter/material.dart';
import 'package:mega/components/texts/main_text.dart';
import 'package:mega/services/constants.dart';

/// Single card widget
class MyCard extends StatelessWidget{
  /// List of texts to display on card
  final List<String> texts;

  /// List of subtexts to display on card
  final List<String> subTexts;

  /// The card background image
  final String imageUrl;

  const MyCard({Key key, @required this.texts, @required this.imageUrl, this.subTexts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Stack(
          children: <Widget>[
            ClipRRect(
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
                        ...texts.map((text) => MainText(text: text, textCenter: true)).toList(),
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