
import 'package:flutter/material.dart';

class FeatureScreenBackButtonModel extends ChangeNotifier {
  bool _showBackButton = true;

  bool get showBackButton => _showBackButton;

  void setShowBackButton(bool val){
    _showBackButton = val;
    notifyListeners();
  }
}