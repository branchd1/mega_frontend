import 'package:flutter/material.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/buttons/delete_icon_list_button.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/texts/empty_text.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/models/community_model.dart';
import 'package:mega/models/feature_model.dart';
import 'package:mega/services/api/feature_api.dart';

/// Screen for the community admin to manage its features
class ManageFeatureScreen extends StatefulWidget{

  /// The current community
  final CommunityModel community;

  const ManageFeatureScreen({Key key, @required this.community}) : super(key: key);

  @override
  _ManageFeatureScreenState createState()=>_ManageFeatureScreenState();
}

class _ManageFeatureScreenState extends State<ManageFeatureScreen>{
  /// The community features
  Future<List<FeatureModel>> features;

  /// Search bar value
  String searchVal;

  /// Update list when search bar value changes
  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    // get features from API
    if (searchVal == null) features = FeatureAPI.getFeatures(context, widget.community.id);

    return Scaffold(
      appBar: MyAppBars.myAppBar2(),
      body: Padding(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BigText(text:'Manage ${this.widget.community.name} features'),
                ),
              ],
            ),
            Padding(
              child: SearchInput(
                onChangeCallback: onSearch,
              ),
              padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            ),
            FutureBuilder<List<FeatureModel>>(
              future: features,
              builder: (BuildContext context, AsyncSnapshot<List<FeatureModel>> snapshot) {
                Widget _widget;
                if(snapshot.hasData){
                  // filter list with search value
                  List<FeatureModel> _list = searchVal == null ?
                  snapshot.data : snapshot.data.where((element) =>
                    element.name.toLowerCase().contains(searchVal)).toList();

                  // list features
                  _widget = _list.length == 0 ? EmptyText(text: 'No features in this community',) : Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_list[index].name),
                          trailing: IconButton(
                            icon: DeleteIconListButton(
                              onPressCallback: () async {
                                // remove feature if deleted
                                await FeatureAPI.removeFeature(context, widget.community.id.toString(), _list[index].id.toString());
                                setState(() {});
                              }
                            )
                          ),
                        );
                      },
                      separatorBuilder: (context, index)=>Divider(),
                    ),
                  );
                } else if (snapshot.hasError){
                  print(snapshot.error);
                  _widget = ErrorTextWithIcon(text: 'Could not retrieve features', subtext: 'try again',);
                } else {
                  _widget = CircularProgressIndicator();
                }
                return _widget;
              },
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      ),
    );
  }
}