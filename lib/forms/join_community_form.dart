import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_async_button.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/my_dialog.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/community_api.dart';
import 'package:mega/services/validators.dart';

/// Form to join a community
class JoinCommunityForm extends StatefulWidget{
  _JoinCommunityFormState createState() => _JoinCommunityFormState();
}

class _JoinCommunityFormState extends State<JoinCommunityForm>{
  /// Controls community key
  final TextEditingController _communityKeyController = TextEditingController();

  /// The form key
  /// Unique globally
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Error text displayed at the bottom
  String _errorText;

  /// Set the error text
  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  /// Submit the form
  Future<void> submit() async {
    // validate
    if (_formKey.currentState.validate()){

      // Ask for data compliance
      String _dialogTitle = 'Data compliance';

      String _dialogText = 'By joining this community, you hereby agree to ' +
          'share any and all personal information given to us with the ' +
          'community admin(s).\n\n' + 'Click continue to accept or click cancel to decline.';

      // Consent button
      Widget _dialogContinueButton = MyAsyncButton(
        buttonText: 'continue',
        onPressCallback: () async {
          bool _res = await CommunityAPI.joinCommunities(context, _communityKeyController.text, setErrorText);

          if(_res){
            Navigator.pushNamedAndRemoveUntil(
                context,
                HomeScreen.routeName,
                (Route<dynamic> route) => false
            );
          }
        }
      );

      // cancel button
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