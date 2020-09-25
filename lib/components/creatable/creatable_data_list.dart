import 'package:flutter/material.dart';
import 'package:mega/components/texts/empty_text.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/services/api/feature_dev_api.dart';

/// Mega Component for list with data from server
class CreatableDataList extends StatelessWidget{
  /// Component data
  final Map<String, dynamic> data;

  const CreatableDataList({Key key, @required this.data}) : super(key: key);

  /// Create the Mega list component
  static Widget createList(Map<String, dynamic> data) => CreatableDataList(data: data);

  /// Convert the special strings in the component map data
  /// to the appropriate values
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
    // check component data is well formed
    assert(data.containsKey('title'));
    assert((data['title'] as Map).containsKey('value'));

    // call back when add button pressed
    VoidCallback _addButtonCallback;

    // the online data
    Future<List<dynamic>> _getData;

    // get list action map
    Map<String, dynamic> _listActionMap = data.containsKey('action') ? data['action'] : null;

    if(_listActionMap!=null){
      // get data from server
      if (_listActionMap['action_type'] == 'get'){
        String _tag = _listActionMap['tag'];
        _getData = FeatureDevAPI.getToDataStore(context, tag: _tag);
      }

      // set callback for other actions
      if(_listActionMap.containsKey('add_page')){
        assert((_listActionMap['add_page'] as Map).containsKey('new_page'));
        _addButtonCallback = _listActionMap['add_page']['new_page'];
      }
    }

    return FutureBuilder<List<dynamic>>(
      future: _getData,
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        Widget _widget;
        if(snapshot.hasData){
          String _titleValue = data['title']['value'];
          String _subtitleValue = data.containsKey('subtitle') ? data['subtitle']['value'] : null;

          _widget = snapshot.data.length == 0 ? EmptyText(text: 'No items in this list',) : Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index){
                if(index == snapshot.data.length){
                  return FloatingActionButton(child: Icon(Icons.add),onPressed: _addButtonCallback);
                }
                return ListTile(
                    // get appropriate values for list item title and subtitle
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
                          // if list specifies delete, show the icon
                          // and set the callback
                          if(_listActionMap != null && _listActionMap.containsKey('delete'))
                            (
                              DeleteIconListButton(
                                snapshot: snapshot,
                                listActionMap: _listActionMap,
                                index: index,
                              )
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

/// Delete icon button for the data list
class DeleteIconListButton extends StatefulWidget{

  /// Data from server
  final AsyncSnapshot<List<dynamic>> snapshot;

  /// The action map for the parent list
  final Map<String, dynamic> listActionMap;

  /// The item index in the list
  final int index;

  const DeleteIconListButton({Key key, @required this.snapshot,
    @required this.listActionMap, @required this.index}) : super(key: key);

  @override
  _DeleteIconListButtonState createState()=> _DeleteIconListButtonState();
}

class _DeleteIconListButtonState extends State<DeleteIconListButton>{
  /// Tracks if the request is loading
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator() : IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        // start loading
        setState(() {
          isLoading = true;
        });

        // send delete request
        bool isSuccess = await FeatureDevAPI.deleteFromDataStore(
            context,
            storeId: widget.snapshot.data[widget.index]['id'].toString()
        );

        // complete request
        if(isSuccess==true) {
          widget.listActionMap['delete']['new_page']();
          setState(() {
            isLoading = false;
          });
        }
      },
      color: Colors.red,
    );
  }
}