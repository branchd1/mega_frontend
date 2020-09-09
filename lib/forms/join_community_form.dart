import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/my_dialog.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/community_api.dart';
import 'package:mega/services/validators.dart';


class JoinCommunityForm extends StatefulWidget{
  _JoinCommunityFormState createState() => _JoinCommunityFormState();
}

class _JoinCommunityFormState extends State<JoinCommunityForm>{
  final TextEditingController _communityKeyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _errorText;

  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  Future<void> submit() async {
    if (_formKey.currentState.validate()){

      String _dialogTitle = 'Data compliance';

      String _dialogText = 'By joining this community, you hereby agree to ' +
          'share any and all personal information given to us with the ' +
          'community admin(s).\n\n' + 'Click continue to accept or click cancel to decline.';

      Widget _dialogContinueButton = MyButton(
          buttonText: 'continue',
          onPressCallback: () async {
            bool _res = await CommunityAPI.joinCommunities(context, _communityKeyController.text, setErrorText);

            if(_res) Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen())
            );
          }
      );

      Widget _dialogCancelButton = MyButton(
          buttonText: 'cancel',
          onPressCallback: () async {
            Navigator.pop(context);
          }
      );

      List<Widget> _dialogButtons = [_dialogContinueButton, _dialogCancelButton];

      MyDialog.showMyDialog(context, _dialogTitle, _dialogText, buttons: _dialogButtons);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextInput(
            controller: _communityKeyController,
            hintText: 'Community key *',
            validator: (val)=>Validators.exactLengthValidator(val, 10),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MySubmitButton(
              buttonText: 'Go',
              submitCallback: submit,
            )
          ),
          if(_errorText!=null) Align(
            alignment: Alignment.bottomLeft,
            child: ErrorTextPlain(_errorText),
          )
        ],
      )
    );
  }
}