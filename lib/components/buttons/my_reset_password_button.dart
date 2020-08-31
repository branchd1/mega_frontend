import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_async_button.dart';
import 'package:mega/components/my_dialog.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/callback_types.dart';

class MyResetPasswordButton extends StatelessWidget{

  final String email;

  MyResetPasswordButton({Key key, @required this.email}) : super(key: key);

  Future<void> doResetPassword(BuildContext context) async {
    bool _res = await AuthAPI.resetPassword(context, email);

    String _alertTitle;
    String _alertText;
    if(_res == true) {
      _alertTitle = 'Password Reset Email Sent';
      _alertText = 'Please check your email to complete the password reset action.';
    } else {
      _alertTitle = 'Something went wrong';
      _alertText = 'The password reset email could not be sent. Please try again.';
    }

    MyDialog.showMyDialog(context, _alertTitle, _alertText);
  }

  @override
  Widget build(BuildContext context) {
    return MyAsyncButton(buttonText: 'reset password', onPressCallback: ()=>doResetPassword(context),);
  }
}