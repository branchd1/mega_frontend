import 'package:flutter/material.dart';

/// Maintains state of the feature dev screen's back button
class FeatureScreenBackButtonStateModel extends ChangeNotifier {
  /// Decides whether back button is visible or not.
  /// True if visible, false otherwise
  bool _showBackButton = true;

  // Getters
  bool get showBackButton => _showBackButton;

  /// Setter for _showBackButton
  void setShowBackButton(bool val){
    _showBackButton = val;

    // notify listeners of changes
    notifyListeners();
  }
}