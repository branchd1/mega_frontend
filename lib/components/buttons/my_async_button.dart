import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

class MyAsyncButton extends StatefulWidget {
  final String buttonText;

  final FutureVoidCallback onPressCallback;

  MyAsyncButton({Key key, @required this.buttonText, this.onPressCallback}) : super(key: key);

  @override
  _MyAsyncButtonState createState() => _MyAsyncButtonState();
}

class _MyAsyncButtonState extends State<MyAsyncButton>{

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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