
import 'package:flutter/material.dart';

///  Widget displays a message to indicate there is no content
///  with an icon to improve user experience
class EmptyText extends StatelessWidget{
  /// The main text
  final String text;

  /// Subtext explaining the text
  /// or directing the user to perform some action when the content is empty
  final String subtext;

  const EmptyText({Key key, @required this.text, this.subtext: ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Icon(
          Icons.search,
          size: 100,
        ),
        Container(
          // the large main text
          child: Text(text, textScaleFactor: 1.5,),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(subtext),
          alignment: Alignment.center,
        )
      ],
    );
  }
}