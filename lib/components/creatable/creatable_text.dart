import 'package:flutter/material.dart';

class CreatableText extends StatelessWidget{
  final Map data;

  const CreatableText({Key key, this.data}) : super(key: key);

  static Widget createText(Map _data){
    return CreatableText(data: _data);
  }

  @override
  Widget build(BuildContext context) {
//    if(data['id'] != null) assert((data['id']).length > 5); // move to external validator
    assert(data['value'] != null);

    Widget _text = Text(
      data['value']
    );

//    if(data['id'] != null) widgetMap.addAll({data['id']: _text});
    return _text;
  }
}