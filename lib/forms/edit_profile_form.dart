import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_reset_password_button.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_file_input.dart';
import 'package:mega/components/inputs/my_text_input.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/screens/profile/profile_screen.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/callback_types.dart';
import 'package:mega/services/constants.dart';
import 'package:mega/services/validators.dart';

class ProfileForm extends StatefulWidget{
  final UserModel user;

  const ProfileForm({Key key, this.user}) : super(key: key);

  @override
  _ProfileFormState createState()=>_ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>{

  final TextEditingController _filePathController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _errorText;

  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  void submit(int profileId) async {
    if (_formKey.currentState.validate()){
      bool _res = await AuthAPI.patchUser(
        context,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber: _phoneNumberController.text,
        picturePath: _filePathController.text,
        profileId: profileId
      );

      if(_res == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
          ModalRoute.withName("/home")
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  submitCallback: ()=>submit(_userObj.profileId),
                )
            ),
            if(_errorText!=null) Align(
              alignment: Alignment.bottomLeft,
              child: ErrorText(_errorText),
            )
          ],
        )
    );
  }
}