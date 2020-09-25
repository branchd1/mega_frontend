import 'package:flutter/material.dart';
import 'package:mega/services/type_defs.dart';

/// Delete icon button for the data list
class DeleteIconListButton extends StatefulWidget{

  /// Function to execute when button pressed
  final FutureVoidCallback onPressCallback;

  const DeleteIconListButton({Key key, @required this.onPressCallback}) : super(key: key);

  @override
  _DeleteIconListButtonState createState()=> _DeleteIconListButtonState();
}

class _DeleteIconListButtonState extends State<DeleteIconListButton>{
  /// Tracks if the request is loading
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator() : IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        setState(() {
          isLoading = true;
        });
        widget.onPressCallback()?.whenComplete((){
          setState(() {
            isLoading = false;
          });
        });
      },
      color: Colors.red,
    );
  }
}