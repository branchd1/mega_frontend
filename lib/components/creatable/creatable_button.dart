import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/services/type_defs.dart';

class CreatableButton extends StatelessWidget{
  static const String changePage='change_page', getData='get_data', deleteItem='delete_item';

  final Map data;
  final CreatableCallback callback;

  const CreatableButton({Key key, this.data, this.callback,}) : super(key: key);

  void buttonAction(Map<String, dynamic> action){
    String actionType = action['action_type'];

    if (actionType == changePage){
      assert(action.containsKey('new_page')); // delegate to a function that checks components structured correctly
      action['new_page']();
    }
  }

  static Widget createButton(Map _data, {CreatableCallback callback}) => CreatableButton(data: _data, callback: callback);

  @override
  Widget build(BuildContext context) {
    assert(data['value'] != null);

    String buttonType = data.containsKey('type') ? data['type'] : null;

    if(buttonType == 'icon'){
      Icon _icon;
      Color _iconColor;
      if(data['value'] == 'delete'){
        _icon = Icon(Icons.delete);
        _iconColor = Colors.red;
      }

      return IconButton(
        icon: _icon,
        onPressed: () {
          if (data['action'] != null){
            callback(doAfter: ()=>buttonAction(data['action']));
          } else {
            callback();
          }
        },
        color: _iconColor,
      );
    }

    if(buttonType == 'submit') {
      return Align(
        alignment: Alignment.bottomRight,
        child: MySubmitButton(
          buttonText: data['value'],
          submitCallback: () {
            if (data['action'] != null){
              callback(doAfter: ()=>buttonAction(data['action']));
            } else {
              callback();
            }
          },
        )
      );
    }

    return MyButton(
      buttonText: data['value'],
      onPressCallback: () {
        if (data['action'] != null) buttonAction(data['action']);
      }
    );
  }
}