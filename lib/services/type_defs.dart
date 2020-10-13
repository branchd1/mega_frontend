import 'package:flutter/material.dart';

// Callbacks

/// Callback to set forms error texts
typedef void SetErrorTextCallback(String text);

/// Callback to validate inputs
typedef String ValidatorCallback(String text);

/// Callback to simulate controller for dropdown input
typedef void DropDownChangedCallback(String val);

/// Callback for mega components actions
typedef void CreatableCallback({VoidCallback doAfter});

/// Callback when a card is tapped on a grid
typedef void TapCardCallback(BuildContext context, dynamic item);

/// Void callback for async
typedef Future<void> FutureVoidCallback();

/// Callback to control input values
typedef void OnChangeCallback(String val);

// Enums

/// Represents the different states of AddCommunityScreen
enum AddCommunityMethods {
  join,
  create
}