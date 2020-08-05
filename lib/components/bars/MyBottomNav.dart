import 'package:flutter/material.dart';
import 'package:mega/screens/home/HomeScreen.dart';
import 'package:mega/screens/profile/ProfileScreen.dart';
import 'package:mega/screens/search/SearchScreen.dart';
import 'package:mega/screens/welcome/WelcomeScreen.dart';
import 'package:mega/services/Constants.dart';

class MyBottomNav extends StatefulWidget {
  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav>{
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Container(),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Container()
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Container()
          ),
        ],
        currentIndex: index == null ? 0 : index,
        onTap: (newIndex) => setState(() => index = newIndex),
      ),
      height: 60,
    );
  }
}