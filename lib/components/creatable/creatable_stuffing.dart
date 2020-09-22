import 'package:flutter/material.dart';

/// Mega component for empty space
class CreatableStuffing extends StatelessWidget{
  /// Component data
  final Map<String, dynamic> data;

  const CreatableStuffing({Key key, @required this.data}) : super(key: key);

  /// Create Mega stuffing component
  static Widget createStuffing(Map<String, dynamic> _data){
    return CreatableStuffing(data: _data);
  }

  @override
  Widget build(BuildContext context) {
    // assert data has height property
    assert(data['height'] != null);

    // get stuffing height
    final double _height = double.tryParse(data['height']) ;

    return Container(
      height: _height != null ? _height : 10,
    );
  }
}