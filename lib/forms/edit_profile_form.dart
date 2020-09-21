import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_file_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/screens/profile/profile_screen.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/callback_types.dart';
import 'package:mega/services/validators.dart';

/// The form used to edit user profile
class ProfileForm extends StatefulWidget{
  /// The user
  final UserModel user;

  const ProfileForm({Key key, @required this.user}) : super(key: key);

  @override
  _ProfileFormState createState()=>_ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>{
  /// Controls profile picture path
  final TextEditingController _filePathController = TextEditingController();

  /// Controls profile first name
  final TextEditingController _firstNameController = TextEditingController();

  /// Controls profile last name
  final TextEditingController _lastNameController = TextEditingController();

  /// Controls profile phone number
  final TextEditingController _phoneNumberController = TextEditingController();

  /// The form key
  /// Unique globally
  final _formKey = GlobalKey<FormState>();

  /// Error text displayed at the bottom
  String _errorText;

  /// Set the error text
  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  /// Submit the form
  Future<void> submit(int profileId) async {
    // validate it
    if (_formKey.currentState.validate()){
      // send patch request to update user
      bool _res = await AuthAPI.patchUser(
        context,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneNumberController.text,
        picturePath: _filePathController.text,
        profileId: profileId
      );

      // if successful move to profile page
      if(_res == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
          ModalRoute.withName("/home"),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // set existing values
    UserModel _userObj = widget.user;

    _firstNameController.text = _userObj.firstName;
    _lastNameController.text = _userObj.lastName;
    _phoneNumberController.text = _userObj.phoneNumber;

    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            MyFileInput(
              hintText: 'upload profile picture *',
              controller: _filePathController,
            ),
            Container(
              child: MyTextInput(
                controller: _firstNameController,
                hintText: 'First name *',
                validator: Validators.requiredValidator,
              ),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            Container(
              child: MyTextInput(
                controller: _lastNameController,
                hintText: 'Last name *',
                validator: Validators.requiredValidator,
              ),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            Container(
              child: MyTextInput(
                controller: _phoneNumberController,
                hintText: 'Phone number *',
                // calling multiple validators
                validator: (val){
                  List<ValidatorCallback> validators = [Validators.requiredValidator, Validators.numberValidator];
                  String _res;

                  for(ValidatorCallback validator in validators){
                    _res = validator(val);
                    if(_res != null){
                      return _res;
                    }
                  }

                  return _res;
                },
              ),
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: MySubmitButton(
                  buttonText: 'Submit',
                  submitCallback: () async =>submit(_userObj.profileId),
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