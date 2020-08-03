import 'package:flutter/cupertino.dart';

import 'MyCard.dart';

class CardGrid extends StatelessWidget{
  final List<dynamic> list;

  const CardGrid({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: List.generate(
            list.length,
                (index) => Column(
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