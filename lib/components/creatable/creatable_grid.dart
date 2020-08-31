
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mega/components/cards/my_card_grid.dart';
import 'package:mega/components/cards/my_card.dart';
import 'package:mega/components/inputs/search_input.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/services/api/feature_dev_api.dart';
import 'package:mega/services/callback_types.dart';

class CreatableGrid extends StatefulWidget{
  final Map<String, dynamic> data;

  const CreatableGrid({Key key, this.data}) : super(key: key);

  static Widget createGrid(Map<String, dynamic> data) => CreatableGrid(data: data);

  @override
  _CreatableGridState createState() => _CreatableGridState();
}

class _CreatableGridState extends State<CreatableGrid>{

  String searchVal;

  void onSearch(String val){
    setState(() {
      searchVal = val;
    });
  }

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
    assert(widget.data.containsKey('title'));
    assert((widget.data['title'] as Map).containsKey('value'));

    Future<List<dynamic>> _getData;

    // get list action map
    Map<String, dynamic> _formActionMap = widget.data.containsKey('action') ? widget.data['action'] : null;

    VoidCallback _addButtonCallback;

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
      return Column(
        children: <Widget>[
          if( _formActionMap.containsKey('search') ) Padding(
            child: SearchInput(
              onChangeCallback: onSearch,
            ),
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
          ),
          FutureBuilder<List<dynamic>>(
            future: _getData,
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              Widget _widget;
              if(snapshot.hasData){

                List<dynamic> _data = searchVal == null ? snapshot.data :
                  snapshot.data.where((element) => element['value'][_formActionMap['search']['field']].toLowerCase().contains(searchVal)).toList();

                String _titleValue = widget.data['title']['value'];
                String _subtitleValue = widget.data.containsKey('subtitle') ? widget.data['subtitle']['value'] : null;
                String _imageUrlValue = widget.data.containsKey('image') ? widget.data['image']['value'] : null;

                List<String> _titles = List<String>();
                for(int i=0; i<_data.length; i++){
                  String _title = convertSpecialStrings(_titleValue, _data[i]);

                  _title = widget.data['title'].containsKey('prefix') ? widget.data['title']['prefix']+_title : _title;

                  _titles.add(_title);
                }

                List<String> _subtitles = List<String>();
                for(int i=0; i<_data.length; i++){
                  String _subtitle = convertSpecialStrings(_subtitleValue, _data[i]);

                  _subtitle = widget.data['subtitle'].containsKey('prefix') ? widget.data['subtitle']['prefix']+_subtitle : _subtitle;

                  _subtitles.add(_subtitle);
                }

                List<String> _imgUrls = List<String>();
                for(int i=0; i<_data.length; i++){
                  _imgUrls.add(convertSpecialStrings(_imageUrlValue, _data[i]));
                }

                _widget = MyCardGrid(
                  list: _data,
                  gridTexts: _titles,
                  gridSubTexts: _subtitles,
                  gridPicturesUrls: _imgUrls,
                  addButtonCallback: _addButtonCallback,
                  emptyText: widget.data.containsKey('empty_text') ? widget.data['empty_text']['value'] : 'No items',
                  emptySubtext: widget.data.containsKey('empty_subtext') ? widget.data['empty_subtext']['value'] : '',
                );
              } else if (snapshot.hasError){
                _widget = ErrorTextWithIcon(
                  text: widget.data.containsKey('error_text') ? widget.data['error_text']['value'] : 'Cannot retrieve data',
                  subtext: widget.data.containsKey('error_subtext') ? widget.data['error_subtext']['value'] : 'try again',
                );
              } else {
                _widget = CircularProgressIndicator();
              }
              return _widget;
            },
          )
        ],
      );
    }
  }
}