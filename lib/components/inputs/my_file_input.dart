import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/texts/error_text_plain.dart';
import 'package:mega/services/callback_types.dart';

/// File input widget
class MyFileInput extends StatefulWidget{
  /// The input placeholder
  final String hintText;

  /// Callback to validate the input value
  final ValidatorCallback validator;

  /// Text controller used to track changes in the input
  final TextEditingController controller;

  MyFileInput({@required this.hintText, @required this.controller, this.validator});

  @override
  _MyFileInputState createState()=> _MyFileInputState();
}

class _MyFileInputState extends State<MyFileInput>{

  /// The file path of the file chosen
  String _filePath = '';

  /// Set the file path attribute to the chosen file
  void setFile() async {
    // get the file path
    String _tempFilePath = await FilePicker.getFilePath(type: FileType.image);

    if(_tempFilePath != null) {
      setState(() {
        // Set the file path to the chosen file
        _filePath = _tempFilePath;
      });

      // set the controller text to the file path
      widget.controller.text = _filePath;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (field){
        return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      // show placeholder when file path is empty
                      child: _filePath.length == 0 ? Image.asset('assets/img/placeholder.png') : Image.file(File(_filePath)),
                      constraints: BoxConstraints.tight(Size.square(50)),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: MyButton(
                        buttonText: widget.hintText,
                        onPressCallback: setFile,
                      ),
                    ),
                  ],
                ),
                if(field.hasError) Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    child: ErrorTextPlain(field.errorText),
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  )
                )
              ],
            ),
        );
      },
      validator: (val){
        if(widget.validator != null){
          return widget.validator(_filePath);
        }
        return null;
      },
    );
  }
}