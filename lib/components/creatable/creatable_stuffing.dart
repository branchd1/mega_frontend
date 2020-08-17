import 'package:flutter/material.dart';

class CreatableStuffing extends StatelessWidget{
  final Map<String, dynamic> data;

  const CreatableStuffing({Key key, this.data}) : super(key: key);

  static Widget createStuffing(Map<String, dynamic> _data){
    return CreatableStuffing(data: _data);
  }

  @override
  Widget build(BuildContext context) {
    assert(data['height'] != null);

    final double _height = double.tryParse(data['height']) ;

    return Container(
      height: _height != null ? _height : 10,
    );
  }
}