import 'package:flutter/material.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';

import 'my_card.dart';

typedef void AddButtonCallback();
typedef void TapCardCallback(BuildContext context, dynamic item);

class CardGrid extends StatelessWidget{
  final List<dynamic> list;
  final AddButtonCallback addButtonCallback;
  final String emptyText;
  final TapCardCallback tapCardCallback;

  const CardGrid({Key key, this.list, this.addButtonCallback, this.emptyText, this.tapCardCallback}) : super(key: key);

  List<String> getSubtexts(int index){
    List<String> res = List<String>();
    if (list[index] is CommunityModel){
      res.add(list[index].isAdmin ? 'admin' : 'member');
    }
    return res.length > 0 ? res : null;
  }

  List<String> getTexts(int index){
    List<String> res = List<String>();
    if (list[index] is CommunityModel || list[index] is FeatureModel){
      res.add(list[index].name);
    }
    return res.length > 0 ? res : null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: List.generate(
          addButtonCallback != null ? list.length + 1 : list.length,
          (int index) => index == list.length && addButtonCallback != null  ? Container(
            child: IconButton(
              icon: Icon(Icons.add_circle_outline),
              iconSize: 50,
              onPressed: addButtonCallback,
            ),
          ) : Container(
            child: GestureDetector(
                onTap: tapCardCallback != null ? ()=>tapCardCallback(context, list[index]) : (){},
                child: MyCard(
                  texts: getTexts(index),
                  subTexts: getSubtexts(index),
                  imageUrl: list[index].picture,
                )
            ),
          ),
        ),
      )
    );
  }
}