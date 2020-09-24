import 'package:flutter/material.dart';
import 'package:mega/components/cards/my_card.dart';
import 'package:mega/components/texts/empty_text.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/services/type_defs.dart';

/// Card grid widget
class MyCardGrid extends StatelessWidget{
  /// List of grid items
  final List<dynamic> list;

  /// Callback to add item to the list
  final VoidCallback addButtonCallback;

  /// Text to show when grid is empty
  final String emptyText;

  /// Subtext to show when grid is empty
  final String emptySubtext;

  /// Callback when a grid item is tapped
  final TapCardCallback tapCardCallback;

  /// The grid texts
  /// Used for creatable widgets
  final List<String> gridTexts;

  /// The grid subtexts
  /// Used for creatable widgets
  final List<String> gridSubTexts;

  /// The grid picture urls
  /// Used for creatable widgets
  final List<String> gridPicturesUrls;

  const MyCardGrid({Key key, @required this.list,
    this.addButtonCallback, @required this.emptyText,
    this.emptySubtext, this.tapCardCallback,
    this.gridTexts, this.gridSubTexts,
    this.gridPicturesUrls}) : super(key: key);

  /// Get the corresponding subtexts in a list depending on index
  String getSubtexts(int index){

    // return subtext if it is a community model
    // specific case
    if (list[index] is CommunityModel){
      return list[index].isAdmin ? 'admin' : 'member';
    }

    // check for the corresponding grid subtext passed in the subtext list
    if (gridSubTexts != null) return gridSubTexts[index];

    // nothing happened, return null
    return null;
  }


  /// Get the corresponding texts in a list depending on index
  String getTexts(int index){

    // return text if it is a community model or feature model
    // specific cases
    if (list[index] is CommunityModel || list[index] is FeatureModel){
      return list[index].name;
    }

    // check for the corresponding grid text passed in the text list
    if (gridTexts != null) return gridTexts[index];

    // nothing happened, return null
    return null;
  }

  /// Get the corresponding pictures in a list depending on index
  String getPictureUrl(int index){

    // return picture url if it is a community or feature model
    // specific cases
    if (list[index] is CommunityModel || list[index] is FeatureModel){
      return list[index].pictureUrl;
    }

    // check for the corresponding grid picture url passed in the text list
    if (gridPicturesUrls != null) return gridPicturesUrls[index];

    // nothing happened, return null
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // if list is empty, show empty text, else show grid
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
                      texts: [getTexts(index), ],
                      subTexts: [getSubtexts(index), ],
                      imageUrl: getPictureUrl(index),
                    )
                ),
              ),
            ),
          ),
          // show add button, if specified
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