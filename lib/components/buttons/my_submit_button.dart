import 'package:flutter/material.dart';
import 'package:mega/services/callback_types.dart';

class MySubmitButton extends StatefulWidget{
  final String buttonText;

  final FutureVoidCallback submitCallback;

  MySubmitButton({Key key, @required this.buttonText, this.submitCallback}) : super(key: key);

  @override
  _MySubmitButtonState createState() => _MySubmitButtonState();
}

class _MySubmitButtonState extends State<MySubmitButton>{

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
        widget.submitCallback().then((value){
          setState(() {
            isLoading = false;
          });
        });
      },
    );
  }
}