import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_reset_password_button.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/constants.dart';

class ProfileForm extends StatefulWidget{
  @override
  _ProfileFormState createState()=>_ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm>{
  @override
  Widget build(BuildContext context) {
    Future<UserModel> _user = AuthAPI.getUser(context);

    return FutureBuilder<UserModel>(
      future: _user,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot){
        Widget _widget;
        if(snapshot.hasData){
          UserModel _userObj = snapshot.data;
          _widget = Column(
            children: <Widget>[
              _userObj.pictureUrl != null ?
                Image.network(_userObj.pictureUrl) :
                CircleAvatar(
                  child: Icon(Icons.person, size: 150, color: Colors.black54,),
                  backgroundColor: Color(grey),
                  minRadius: 80,
                ),
              ListTile(
                title: Text('email: ' + _userObj.email),
              ),
              Divider(),
              ListTile(
                title: Text('first name: ' + (_userObj.firstName != null ? _userObj.firstName : '')),
              ),
              Divider(),
              ListTile(
                title: Text('last name: ' + (_userObj.lastName != null ? _userObj.lastName : '')),
              ),
              Divider(),
              Align(
                child: MyResetPasswordButton(email: _userObj.email,),
                alignment: Alignment.bottomLeft,
              )
            ],
          );
        } else if (snapshot.hasError){
          _widget = Text('Error');
        } else {
          _widget = CircularProgressIndicator();
        }
        return _widget;
      }
    );
  }
}