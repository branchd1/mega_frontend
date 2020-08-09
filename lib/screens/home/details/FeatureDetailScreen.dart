import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/bars/MyBottomNav.dart';
import 'package:mega/components/buttons/MyButton.dart';
import 'package:mega/components/texts/BigText.dart';
import 'package:mega/models/FeatureModel.dart';

Widget createText(String a) => Text(a);
Widget createButton(String a) => MyButton(buttonText: a, onPressCallback: ()=>{},);

final Map<String, dynamic> configurationMap = {
  'text': createText,
  'button': createButton,
};

Map<String, dynamic> json = {
  'text': {
    'value': 'hello',
  },
  'button': {
    'value': 'hey'
  }
};

class FeatureDetailScreen extends StatelessWidget{
  final FeatureModel feature;

  const FeatureDetailScreen({Key key, this.feature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = json.keys.map<Widget>((i) => configurationMap[i](json[i]['value'])).toList();
    return Scaffold(
      appBar: MyAppBars.myAppBar3(),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText(feature.name),
            Column(
                children: list
            )
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      )
    );
  }
}