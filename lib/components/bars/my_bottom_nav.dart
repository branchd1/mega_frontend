import 'package:flutter/material.dart';
import 'package:mega/screens/home/home_screen.dart';
import 'package:mega/screens/profile/profile_screen.dart';
import 'package:mega/screens/search/search_screen.dart';
import 'package:mega/screens/welcome/welcome_screen.dart';
import 'package:mega/services/constants.dart';

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
        backgroundColor: Color(Constants.grey),
      ),
      height: 60,
    );
  }
}