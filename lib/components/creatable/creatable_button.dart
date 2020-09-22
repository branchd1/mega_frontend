import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/services/type_defs.dart';

/// Mega button component
class CreatableButton extends StatelessWidget{
  /// The different button actions
  static const String changePage='change_page', getData='get_data', deleteItem='delete_item';

  /// The component data
  final Map data;

  /// The button tap callback
  final CreatableCallback callback;

  const CreatableButton({Key key, @required this.data, @required this.callback,}) : super(key: key);

  /// The button action
  void buttonAction(Map<String, dynamic> action){
    // check action map is valid
    String actionType = action['action_type'];

    // perform action specified
    if (actionType == changePage){
      assert(action.containsKey('new_page'));
      action['new_page']();
    }
  }

  /// Create Mega button component
  static Widget createButton(Map _data, {CreatableCallback callback}) =>
      CreatableButton(data: _data, callback: callback);

  @override
  Widget build(BuildContext context) {
    // validate map
    assert(data['value'] != null);

    String buttonType = data.containsKey('type') ? data['type'] : null;

    // return button based on type specified
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
            return null;
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