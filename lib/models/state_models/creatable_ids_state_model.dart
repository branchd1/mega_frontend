
import 'package:flutter/material.dart';

class CreatableIdsStateModel {
  final Map<String, Widget> idToWidgetMap = Map<String, Widget>();

  void addWidgetWithId(String id, Widget widget){
    idToWidgetMap.putIfAbsent(id, () => widget);
  }

  Widget getWidget(String id){
    if(!idToWidgetMap.containsKey(id)) throw ('Widget with this id does not exist');
    return idToWidgetMap[id];
  }
}