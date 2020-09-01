import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/forms/edit_profile_form.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/services/api/auth_api.dart';

class EditProfileScreen extends StatelessWidget{

  final UserModel user;

  const EditProfileScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context){
    Future<UserModel> _user = AuthAPI.getUser(context);

    return Scaffold(
        appBar: MyAppBars.myAppBar2(),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText('Edit profile'),
              Padding(
                child: FutureBuilder<UserModel>(
                    future: _user,
                    builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot){
                      Widget _widget;
                      if(snapshot.hasData){
                        UserModel _userObj = snapshot.data;

                        _widget = ProfileForm(user: _userObj,);
                      } else if (snapshot.hasError){
                        _widget = Text('Error');
                      } else {
                        _widget = CircularProgressIndicator();
                      }
                      return _widget;
                    }
                ),
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        ),
    );
  }
}