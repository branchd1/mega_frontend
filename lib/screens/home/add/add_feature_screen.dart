import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/screens/home/details/feature_detail_add_screen.dart';
import 'package:mega/services/api/feature_api.dart';
import 'package:mega/services/type_defs.dart';

/// Screen to add feature to community
class AddFeatureScreen extends StatefulWidget {

  /// The community
  final CommunityModel community;

  const AddFeatureScreen({Key key, @required this.community}) : super(key: key);

  @override
  _AddFeatureScreenState createState()=> _AddFeatureScreenState();
}

class _AddFeatureScreenState extends State<AddFeatureScreen>{
  /// Search bar value
  String searchVal;

  /// Filter list of communities when search bar value changes
  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  /// Go to feature detail add screen when user taps feature card
  void tapCardCallback(BuildContext context, dynamic item){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeatureDetailAddScreen(
        feature: item,
        community: this.widget.community)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBars.myAppBar2(),
      body: Padding(
        child: Column(
          children: <Widget>[
            BigText(text:'Add features'),
            Padding(
              child: SearchInput(
                onChangeCallback: onSearch,
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            FeatureGrid(
              searchVal: searchVal,
              community: widget.community,
              tapCardCallback: tapCardCallback,
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      ),
    );
  }
}

/// Feature grid
///
/// Contains a feature details
/// Helper class for AddFeatureScreen only
class FeatureGrid extends StatefulWidget{

  /// Search bar value
  final String searchVal;

  /// The community
  final CommunityModel community;

  /// Callback when card tapped
  final TapCardCallback tapCardCallback;

  FeatureGrid({Key key, @required this.searchVal,
    @required this.community,
    @required this.tapCardCallback}) : super(key: key);

  @override
  _FeatureGridState createState() => _FeatureGridState();
}

class _FeatureGridState extends State<FeatureGrid>{
  /// The list of features
  Future<List<FeatureModel>> features;

  @override
  Widget build(BuildContext context) {
    // get the list of features
    if (widget.searchVal == null) features = FeatureAPI.getAllFeatures(context, widget.community.type, widget.community.id);

    return FutureBuilder<List<FeatureModel>>(
      future: features,
      builder: (BuildContext context, AsyncSnapshot<List<FeatureModel>> snapshot) {
        Widget _widget;
        if(snapshot.hasData){
          _widget = MyCardGrid(
            list: widget.searchVal == null ?
            snapshot.data : snapshot.data.where((element) =>
                element.name.toLowerCase().contains(widget.searchVal)).toList(),
            emptyText: 'No unused features to add',
            emptySubtext: 'you can only add features you haven\'t used',
            tapCardCallback: widget.tapCardCallback,
          );
        } else if (snapshot.hasError){
          _widget = ErrorTextWithIcon(text: 'Something went wrong', subtext: 'try again',);
        } else {
          _widget = CircularProgressIndicator();
        }
        return _widget;
      },
    );
  }
}