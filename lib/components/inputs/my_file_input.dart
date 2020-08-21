import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_button.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/services/callback_types.dart';

class MyFileInput extends StatefulWidget{
  final String hintText;
  final ValidatorCallback validator;
  final TextEditingController controller;

  MyFileInput({this.hintText, this.validator, this.controller});

  @override
  _MyFileInputState createState()=> _MyFileInputState();
}

class _MyFileInputState extends State<MyFileInput>{
  String _filePath;

  void setFile() async {
    String _tempFilePath = await FilePicker.getFilePath(type: FileType.image);
    if(!(_filePath != null && _tempFilePath == null)) setState(() {
      _filePath = _tempFilePath;
    });
    widget.controller.text = _filePath;
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
                      child: _filePath == null ? Image.network('https://via.placeholder.com/150'): Image.file(File(_filePath)),
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
                    child: ErrorText(field.errorText),
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  )
                )
              ],
            ),
        );
      },
      validator: (val)=> _filePath == null ? widget.validator('') : widget.validator(_filePath),
      initialValue: '',
    );
  }
}