import 'package:flutter/material.dart';
import 'package:mega/services/type_defs.dart';

/// Button used to submit forms
class MySubmitButton extends StatefulWidget{
  /// The button text
  final String buttonText;

  /// Callback when button is clicked
  final FutureVoidCallback submitCallback;

  MySubmitButton({Key key, @required this.buttonText, this.submitCallback}) : super(key: key);

  @override
  _MySubmitButtonState createState() => _MySubmitButtonState();
}

class _MySubmitButtonState extends State<MySubmitButton>{

  /// Is the form action loading?
  /// True if yes, False otherwise
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Show loading icon when form action is processing
    return isLoading == true ? CircularProgressIndicator() : FlatButton(
      child: Column(
        children: <Widget>[
          Icon(Icons.arrow_forward),
          Text(widget.buttonText)
        ],
      ),
      onPressed: (){
        setState(() {
          isLoading = true;
        });
        if( widget.submitCallback != null ) widget.submitCallback().whenComplete((){
          setState(() {
            isLoading = false;
          });
        });
      },
    );
  }
}