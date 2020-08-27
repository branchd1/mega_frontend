import 'package:flutter/material.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/services/api/auth_api.dart';

class ProfileForm extends StatefulWidget{
  @override
  _ProfileFormState createState()=>_ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>{
  @override
  Widget build(BuildContext context) {
    Future<UserModel> _user = AuthAPI.getUser(context);

    return Column(
      children: <Widget>[

      ],
    );
  }
}