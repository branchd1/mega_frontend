import 'package:flutter/material.dart';
import 'package:mega/screens/home/HomeScreen.dart';
import 'package:mega/screens/profile/ProfileScreen.dart';
import 'package:mega/screens/search/SearchScreen.dart';
import 'package:mega/screens/welcome_screens/WelcomeScreen.dart';
import 'package:mega/services/Constants.dart';

enum BottomNavActivePage{
  home,
  search,
  profile
}

class MyBottomNav extends StatelessWidget{
  final BottomNavActivePage bottomNavActivePage;

  const MyBottomNav({Key key, this.bottomNavActivePage}) : super(key: key);

  void pushToHome(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),);
  }

  void pushToSearch(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()),);
  }

  void pushToProfile(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()),);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: bottomNavActivePage == BottomNavActivePage.home ? Colors.blue : Colors.black,
              onPressed: bottomNavActivePage == BottomNavActivePage.home ?
                () {} : (){
                  pushToHome(context);
                },
              iconSize: 35,
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: bottomNavActivePage == BottomNavActivePage.search ? Colors.blue : Colors.black,
              onPressed: bottomNavActivePage == BottomNavActivePage.search ?
                  () {} : (){
                pushToSearch(context);
              },
              iconSize: 35,
            ),
            IconButton(
              icon: Icon(Icons.person),
              color: bottomNavActivePage == BottomNavActivePage.profile ? Colors.blue : Colors.black,
              onPressed: bottomNavActivePage == BottomNavActivePage.profile ?
                  () {} : (){
                pushToProfile(context);
              },
              iconSize: 35,
            ),
          ],
        ),
        color: Color(Constants.grey),
      ),
      height: 60,
    );
  }
}