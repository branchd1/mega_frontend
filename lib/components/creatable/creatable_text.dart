import 'package:flutter/material.dart';

/// Mega text component
class CreatableText extends StatelessWidget{
  /// The component data
  final Map data;

  const CreatableText({Key key, @required this.data}) : super(key: key);

  /// Create the text component with data
  static Widget createText(Map _data){
    return CreatableText(data: _data);
  }

  @override
  Widget build(BuildContext context) {
    // text value should not be null
    assert(data['value'] != null);

    // form text with value
    Widget _text = Text(
      data['value']
    );

    return _text;
  }
}