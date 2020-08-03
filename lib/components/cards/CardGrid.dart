import 'package:flutter/material.dart';

import 'MyCard.dart';

typedef void AddButtonCallback();

class CardGrid extends StatelessWidget{
  final List<dynamic> list;
  final AddButtonCallback addButtonCallback;

  const CardGrid({Key key, this.list, this.addButtonCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: List.generate(
          addButtonCallback != null ? list.length + 1 : list.length,
          (index) => index == list.length && addButtonCallback != null  ? Container(
            child: IconButton(
              icon: Icon(Icons.add_circle_outline),
              iconSize: 50,
              onPressed: addButtonCallback,
            ),
          ) : Column(
            children: <Widget>[
              MyCard(
                text: list[index].name,
                subText: list[index].isAdmin ? 'admin' : 'member',
                imageUrl: list[index].picture,
              )
            ]
          ),
        ),
      )
    );
  }
}