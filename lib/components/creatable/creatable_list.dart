
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/services/api/feature_dev_api.dart';
import 'package:mega/services/callback_types.dart';
import 'package:mega/services/constants.dart';

class CreatableList extends StatelessWidget{

  final Map<String, dynamic> data;

  const CreatableList({Key key, this.data}) : super(key: key);

  static Widget createList(Map<String, dynamic> data) => CreatableList(data: data);

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

    VoidCallback _addButtonCallback;

    Future<List<dynamic>> _getData;

    // get list action map
    Map<String, dynamic> _listActionMap = data.containsKey('action') ? data['action'] : null;

    if(_listActionMap!=null){
      if (_listActionMap['action_type'] == 'get'){
        String _tag = _listActionMap['tag'];
        _getData = FeatureDevAPI.getToDataStore(context, tag: _tag);
      }

      if(_listActionMap.containsKey('add_page')){
        assert((_listActionMap['add_page'] as Map).containsKey('new_page'));
        _addButtonCallback = _listActionMap['add_page']['new_page'];
      }
    }

    if(_getData == null){
      return Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index){
            return ListTile(
//              leading: Text(),
              title: Text(data['title']['value']),
              subtitle: data.containsKey('subtitle') ? Text(data['subtitle']['value']) : null,
//              trailing: Text('d'),
            );
          },
          separatorBuilder: (context, index){
            return Divider();
          },
          itemCount: 100,
        ),
      );
    } else {
      return FutureBuilder<List<dynamic>>(
        future: _getData,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          Widget _widget;
          if(snapshot.hasData){
            String _titleValue = data['title']['value'];
            String _subtitleValue = data.containsKey('subtitle') ? data['subtitle']['value'] : null;

            _widget = Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index){
                  if(index == snapshot.data.length){
                    return FloatingActionButton(child: Icon(Icons.add),onPressed: _addButtonCallback);
                  }
                  return ListTile(
                    title: (data['title'] as Map).containsKey('prefix') ?
                      Text(data['title']['prefix'] + convertSpecialStrings(_titleValue, snapshot.data[index])) :
                      Text(convertSpecialStrings(_titleValue, snapshot.data[index])),

                    subtitle: _subtitleValue != null ?
                      ((data['subtitle'] as Map).containsKey('prefix') ?
                        Text(data['subtitle']['prefix'] + convertSpecialStrings(_subtitleValue, snapshot.data[index])) :
                        Text(convertSpecialStrings(_subtitleValue, snapshot.data[index]))) :
                      null,

                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: <Widget>[
                          if(_listActionMap != null && _listActionMap.containsKey('delete')) IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool isSuccess = await FeatureDevAPI.deleteFromDataStore(context, storeId: snapshot.data[index]['id'].toString());

                              if(isSuccess==true) _listActionMap['delete']['new_page']();
                            },
                            color: Colors.red,
                          )
                        ],
                        textDirection: TextDirection.rtl,
                      ),
                    )
                  );
                },
                separatorBuilder: (context, index){
                  return Divider();
                },
                itemCount: _addButtonCallback == null ? snapshot.data.length : snapshot.data.length+1,
              ),
            );
          } else if (snapshot.hasError){
            print(snapshot.error);
            _widget = ErrorTextPlain('Error');
          } else {
            _widget = CircularProgressIndicator();
          }
          return _widget;
        },
      );
    }
  }
}