import 'package:flutter/material.dart';
import 'package:mega/components/texts/big_text.dart';
import 'package:mega/screens/profile/profile_screen.dart';
import 'package:mega/services/auth_services.dart';

/// Widget representing the apps menu
class MyMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget> [
          DrawerHeader(child: BigText(text: 'Menu'),),
          ListTile(
            title: Text('Profile'),
            // push to profile screen when tapped
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
            // logout when tapped
            onTap: (){
              Navigator.pop(context);
              doLogout(context);
            },
          ),
          Divider(),
          AboutListTile(
            icon: Icon(Icons.info),
            applicationName: 'Mega App',
            applicationIcon: Image.asset('assets/img/logo/small/logo.png'),
            applicationVersion: '1.2.0',
            aboutBoxChildren: [
              Text('The Mega App is a Low Code Platform that enables '
                  'organisations to create MiniApps for their customers '
                  'and staff.'),
            ],
          ),
        ],
      )
    );
  }
}