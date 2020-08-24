
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mega/components/cards/card_grid.dart';
import 'package:mega/components/cards/my_card.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/services/api/feature_dev_api.dart';
import 'package:mega/services/callback_types.dart';

class CreatableGrid extends StatelessWidget{

  final Map<String, dynamic> data;

  const CreatableGrid({Key key, this.data}) : super(key: key);

  static Widget createGrid(Map<String, dynamic> data) => CreatableGrid(data: data);

  String convertSpecialStrings(String str, Map<String, dynamic> map){
    if(str.startsWith('mega\$action\$')){
      str = str.substring('mega\$action\$'.length);

      List<String> strTokens = str.split('.');

      for(String token in strTokens){
        if(map[token] is String){
          return map[token];
        }

        map = map[token];
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    assert(data.containsKey('title'));
    assert((data['title'] as Map).containsKey('value'));

    Future<List<dynamic>> _getData;

    // get list action map
    Map<String, dynamic> _formActionMap = data.containsKey('action') ? data['action'] : null;

    NoArgNoReturnCallback _addButtonCallback;

    if(_formActionMap!=null){
      if (_formActionMap['action_type'] == 'get'){
        String _tag = _formActionMap['tag'];
        _getData = FeatureDevAPI.getToDataStore(context, tag: _tag);
      }

      if(_formActionMap.containsKey('add_page')){
        assert((_formActionMap['add_page'] as Map).containsKey('new_page'));
        _addButtonCallback = _formActionMap['add_page']['new_page'];
      }
    }

    if(_getData == null){
//      return Expanded(
//        child: GridView.count(
//          itemBuilder: (context, index){
//            return ListTile(
////              leading: Text(),
//              title: Text(data['title']['value']),
//              subtitle: data.containsKey('subtitle') ? Text(data['subtitle']['value']) : null,
////              trailing: Text('d'),
//            );
//          },
//          separatorBuilder: (context, index){
//            return Divider();
//          },
//          itemCount: 100,
//        ),
//      );
    } else {
      return FutureBuilder<List<dynamic>>(
        future: _getData,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          Widget _widget;
          if(snapshot.hasData){
            String _titleValue = data['title']['value'];
            String _subtitleValue = data.containsKey('subtitle') ? data['subtitle']['value'] : null;
            String _imageUrlValue = data.containsKey('image') ? data['image']['value'] : null;

            List<String> _titles = List<String>();
            for(int i=0; i<snapshot.data.length; i++){
              _titles.add(convertSpecialStrings(_titleValue, snapshot.data[i]));
            }

            List<String> _subtitles = List<String>();
            for(int i=0; i<snapshot.data.length; i++){
              _subtitles.add(convertSpecialStrings(_subtitleValue, snapshot.data[i]));
            }

            List<String> _imgUrls = List<String>();
            for(int i=0; i<snapshot.data.length; i++){
              _imgUrls.add(convertSpecialStrings(_imageUrlValue, snapshot.data[i]));
            }

            _widget = CardGrid(
              list: snapshot.data,
              gridTexts: _titles,
              gridSubTexts: _subtitles,
              gridPicturesUrls: _imgUrls,
              addButtonCallback: _addButtonCallback,
            );
          } else if (snapshot.hasError){
            print(snapshot.error);
            _widget = ErrorText('Error');
          } else {
            _widget = CircularProgressIndicator();
          }
          return _widget;
        },
      );
    }
  }
}