import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/screens/profile/profile_screen.dart';
import 'package:mega/services/logout.dart';

class Menu extends StatefulWidget{
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu>{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget> [
          DrawerHeader(child: BigText('Menu'),),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            onTap: (){
              Navigator.pop(context);
              doLogout(context);
            },
          ),
          Divider(),
          AboutListTile(),
        ],
      )
    );
  }
}