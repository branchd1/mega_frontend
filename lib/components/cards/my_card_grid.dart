import 'package:flutter/material.dart';
import 'package:mega/components/texts/empty_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/services/callback_types.dart';

import 'my_card.dart';

class MyCardGrid extends StatelessWidget{
  final List<dynamic> list;
  final VoidCallback addButtonCallback;
  final String emptyText;
  final String emptySubtext;
  final TapCardCallback tapCardCallback;

  final List<String> gridTexts;
  final List<String> gridSubTexts;
  final List<String> gridPicturesUrls;

  const MyCardGrid({Key key, this.list, this.addButtonCallback, this.emptyText, this.emptySubtext, this.tapCardCallback, this.gridTexts, this.gridSubTexts, this.gridPicturesUrls}) : super(key: key);

  List<String> getSubtexts(int index){
    List<String> res = List<String>();
    if (list[index] is CommunityModel){
      res.add(list[index].isAdmin ? 'admin' : 'member');
    }

    if(res.length > 0) return res;
    if (gridSubTexts != null) return [gridSubTexts[index],];
    return null;
  }

  List<String> getTexts(int index){
    List<String> res = List<String>();
    if (list[index] is CommunityModel || list[index] is FeatureModel){
      res.add(list[index].name);
    }

    if(res.length > 0) return res;
    if (gridTexts != null) return [gridTexts[index],];
    return null;
  }

  String getPictureUrl(int index){
    if (list[index] is CommunityModel || list[index] is FeatureModel){
      return list[index].picture;
    }

    if (gridPicturesUrls != null) {
      try {
        return gridPicturesUrls[index];
      } on RangeError {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          list.length == 0 ? EmptyText(text: emptyText, subtext: emptySubtext) : GridView.count(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            scrollDirection: Axis.vertical,
            children: List.generate(
              list.length,
                  (int index) => Container(
                child: GestureDetector(
                    onTap: tapCardCallback != null ? ()=>tapCardCallback(context, list[index]) : (){},
                    child: MyCard(
                      texts: getTexts(index),
                      subTexts: getSubtexts(index),
                      imageUrl: getPictureUrl(index),
                    )
                ),
              ),
            ),
          ),
          if(addButtonCallback != null)IconButton(
            icon: Icon(Icons.add_circle_outline),
            iconSize: 50,
            onPressed: addButtonCallback,
          )
        ],
      ),
    );
  }
}