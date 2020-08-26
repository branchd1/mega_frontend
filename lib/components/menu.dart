import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';

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
            onTap: () {},
          ),
          Divider(),
          AboutListTile(),
        ],
      )
    );
  }
}