import 'package:flutter/material.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/screens/home/details/community_detail_screen.dart';

import 'my_card.dart';

typedef void AddButtonCallback();
typedef void TapCardCallback(BuildContext context, dynamic item);

class CardGrid extends StatelessWidget{
  final List<dynamic> list;
  final AddButtonCallback addButtonCallback;
  final String emptyText;
  final TapCardCallback tapCardCallback;

  const CardGrid({Key key, this.list, this.addButtonCallback, this.emptyText, this.tapCardCallback}) : super(key: key);

  String getSubtext(int index){
    if (list[index] is CommunityModel){
      return list[index].isAdmin ? 'admin' : 'member';
    }
    return null;
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
                  text: list[index].name,
                  subText: getSubtext(index),
                  imageUrl: list[index].picture,
                )
            ),
          ),
        ),
      )
    );
  }
}