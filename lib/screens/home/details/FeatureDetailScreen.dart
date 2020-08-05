import 'package:flutter/material.dart';
import 'package:mega/components/bars/MyAppBars.dart';
import 'package:mega/components/bars/MyBottomNav.dart';

class FeatureDetailScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBars.myAppBar3(),
      body: Container()
    );
  }
}