import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/services/callback_types.dart';

class CreatableButton extends StatelessWidget{
  static const String changePage='change_page', getData='get_data';

  final Map data;
  final CreatableFormSubmitCallback submitCallback;

  const CreatableButton({Key key, this.data, this.submitCallback}) : super(key: key);

  void buttonAction(Map<String, dynamic> action){
    String actionType = action['action_type'];

    if (actionType == changePage){
      assert(action.containsKey('new_page')); // delegate to a function that checks components structured correctly
      action['new_page']();
    }
  }

  static Widget createButton(Map _data, {CreatableFormSubmitCallback submitCallback}) => CreatableButton(data: _data, submitCallback: submitCallback);

  @override
  Widget build(BuildContext context) {
    assert(data['value'] != null);

    if(submitCallback != null) {
      return Align(
        alignment: Alignment.bottomRight,
        child: MySubmitButton(
          buttonText: data['value'],
          submitCallback: data['action'] != null ? () {
            submitCallback(doAfter: ()=>buttonAction(data['action']));
          } : (){
            submitCallback();
          },
        )
      );
    } else {
      return MyButton(
        buttonText: data['value'],
        onPressCallback: () {
          if (data['action'] != null) buttonAction(data['action']);
        }
      );
    }
  }
}