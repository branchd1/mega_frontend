import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

/// Async button with loading functionality
class MyAsyncButton extends StatefulWidget {
  /// The button text
  final String buttonText;

  /// The callback when button is pressed
  final FutureVoidCallback onPressCallback;

  MyAsyncButton({Key key, @required this.buttonText, this.onPressCallback}) : super(key: key);

  @override
  _MyAsyncButtonState createState() => _MyAsyncButtonState();
}

class _MyAsyncButtonState extends State<MyAsyncButton>{

  /// Reflects if the button is current performing an async operation.
  /// True if it is, false otherwise
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // if its loading, show loading icon
    return isLoading == true ? CircularProgressIndicator() : RaisedButton(
      child: Text(widget.buttonText),
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        widget.onPressCallback().then((value){
          setState(() {
            isLoading = false;
          });
        });
      },
    );
  }
}