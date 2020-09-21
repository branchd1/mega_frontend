import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/buttons/my_reset_password_button.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/components/bars/my_app_bars.dart';
import 'package:mega/components/texts/error_text_with_icon.dart';
import 'package:mega/models/user_model.dart';
import 'package:mega/screens/profile/edit_profile_screen.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/constants.dart';

import '../home/add/add_community_screen.dart';

class ProfileScreen extends StatelessWidget{
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context){
    Future<UserModel> _user = AuthAPI.getUser(context);

    return Scaffold(
        appBar: MyAppBars.myAppBar2(),
        body: Padding(
          child: Column(
            children: <Widget>[
              BigText(text:'Your profile'),
              Padding(
                child: FutureBuilder<UserModel>(
                    future: _user,
                    builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot){
                      Widget _widget;
                      if(snapshot.hasData){
                        UserModel _userObj = snapshot.data;

                        _widget = Column(
                          children: <Widget>[
                            _userObj.pictureUrl != null ?
                            CircleAvatar(
                              backgroundImage: NetworkImage(_userObj.pictureUrl),
                              backgroundColor: Color(grey),
                              radius: 80,
                            ) :
                            CircleAvatar(
                              child: Icon(Icons.person, size: 150, color: Colors.black54,),
                              backgroundColor: Color(grey),
                              radius: 80,
                            ),
                            MyButton(
                              buttonText: 'edit profile',
                              onPressCallback: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProfileScreen(user: snapshot.data,))
                                );// do something
                              },
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
                            ListTile(
                              title: Text('phone: ' + (_userObj.phoneNumber != null ? _userObj.phoneNumber : '')),
                            ),
                            Divider(),
                            Align(
                              child: MyResetPasswordButton(email: _userObj.email,),
                              alignment: Alignment.bottomLeft,
                            )
                          ],
                        );
                      } else if (snapshot.hasError){
                        _widget = ErrorTextWithIcon(text: 'Cannot retrieve profile', subtext: 'Try again',);
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