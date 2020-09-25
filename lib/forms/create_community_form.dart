import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/my_dialog.dart';
import 'package:mega/components/inputs/dropdown_input.dart';
import 'package:mega/components/inputs/my_file_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/models/community_type_model.dart';
import 'package:mega/models/response_models/create_community_response_model.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/services/api/community_api.dart';
import 'package:mega/services/validators.dart';

/// Form to create a community
class CreateCommunityForm extends StatefulWidget{
  _CreateCommunityFormState createState() => _CreateCommunityFormState();
}

class _CreateCommunityFormState extends State<CreateCommunityForm>{
  /// The form key
  /// Unique globally
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controls community name
  final TextEditingController _communityNameController = TextEditingController();

  /// Controls community picture path
  final TextEditingController _communityPicturePathController = TextEditingController();

  /// Simulates editing controller for community type dropdown input
  String _communityTypeControllerSimulator;

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
    // validate the form first
    if (_formKey.currentState.validate()){
      // create community in server
      CreateCommunityResponseModel _res = await CommunityAPI.createCommunity(
          context, _communityNameController.text,
          _communityTypeControllerSimulator,
          _communityPicturePathController.text, setErrorText);

      // Show the community admin his key when done
      String _dialogTitle = 'Save your community key';

      String _dialogText = 'Your community key is ' + _res.key +
          '.\n\nShare this key to members to join your community.' +
          '\n\nTo restrict strangers from joining, keep this key private.';

      Widget _dialogButton = MyButton(
        buttonText: 'Copy key',
        onPressCallback: (){
          // shouldn't error but just in case
          try {
            Clipboard.setData(ClipboardData(text: _res.key));
          } catch (e) {}

          // go to home screen
          if(_res != null){
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.routeName,
              (Route<dynamic> route) => false
            );
          }

        }
      );

      List<Widget> _dialogButtons = [_dialogButton];

      MyDialog.showMyDialog(context, _dialogTitle, _dialogText, buttons: _dialogButtons);
    }
  }

  /// Change the community type value on the controller simulator
  /// when dropdown value changes
  void changeTypeValue(String val){
    _communityTypeControllerSimulator = val;
  }

  @override
  Widget build(BuildContext context) {
    // get the list of community types
    Future<List<CommunityTypeModel>> _typeList = CommunityAPI.getCommunityTypes(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyTextInput(
            controller: _communityNameController,
            hintText: 'Community name *',
            validator: Validators.requiredValidator,
          ),
          FutureBuilder<List<CommunityTypeModel>>(
            future: _typeList,
            builder: (BuildContext context, AsyncSnapshot<List<CommunityTypeModel>> snapshot) {
              Widget _widget;
              if(snapshot.hasData){
                _widget = Container(
                  child: DropdownInput(
                    dropDownList: snapshot.data,
                    dropDownChangedCallback: changeTypeValue,
                    hintText: 'Community type *',
                    validator: Validators.requiredValidator,
                  ),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                );
              } else if (snapshot.hasError){
                _widget = ErrorTextPlain('Cannot retrieve community types');
              } else {
                _widget = CircularProgressIndicator();
              }
              return _widget;
            },
          ),
          Container(
            child: MyFileInput(
              hintText: 'upload picture *',
              controller: _communityPicturePathController,
              validator: Validators.requiredValidator,
            ),
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MySubmitButton(
              buttonText: 'Submit',
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