import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// for http

void main()=>runApp(MegaApp());

class MegaApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Mega App',
      home: WelcomeScreen()
    );
  }
}

class MyAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[
        Image.asset('assets/img/logo/small/logo.png')
      ],
    );
  }
}

class WelcomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return(
      Scaffold(
        body: Padding(
          child: Column(
            children: <Widget>[
              Image.asset('assets/img/logo/logo.png'),
              Center(
                child: Column(
                  children: <Widget>[
                    BigText(
                      text:'Welcome'
                    ),
                    Padding(
                      child: WelcomeForm(),
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                    )
                  ],
                )
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          padding: const EdgeInsets.all(30),
        )
      )
    );
  }
}

class BigText extends StatelessWidget{
  final String text;

  const BigText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        'Welcome',
        textScaleFactor: 3,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
      alignment: Alignment.bottomLeft,
    );
  }
}

class MyEmailInput extends StatelessWidget{
  final RegExp emailRegex = new RegExp(
    r"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$",
    caseSensitive: false,
    multiLine: false,
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'email *',
        border: OutlineInputBorder()
      ),
      onSaved: (String value) {
        print(API().checkEmailExists(value));
      },
      validator: (String value) {
        return emailRegex.hasMatch(value) ? null : 'Enter a valid email';
      },
    );
  }
}

typedef void FormSubmitCallback();

class MySubmitButton extends StatelessWidget{
  final String buttonText;

  final FormSubmitCallback submitCallback;

  const MySubmitButton({Key key, @required this.buttonText, this.submitCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Column(
        children: <Widget>[
          Icon(Icons.arrow_forward),
          Text(buttonText)
        ],
      ),
      onPressed: submitCallback,
    );
  }
}

class WelcomeForm extends StatefulWidget{
  @override
  WelcomeFormState createState() => WelcomeFormState();
}

class API {
  static const String url = 'http://0.0.0.0:9000/';

  Future<http.Response> post(String endpoint, Map<String, String> data, Map<String, String> additionalHeaders){
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    headers = {
      ...headers,
      ...additionalHeaders
    };

    return http.post(
      url + endpoint,
      headers: headers,
      body: jsonEncode(data),
    );
  }

  Future<http.Response> checkEmailExists(String email){
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    Map<String, String> data = <String, String>{
      'email': email,
    };

    return this.post(
      'api/check_email',
      headers,
      data
    );
  }
}

class WelcomeFormState extends State<WelcomeForm>{
  final _formKey = GlobalKey<FormState>();

  void submit(){
    if (_formKey.currentState.validate()){
      _formKey.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MyEmailInput(),
          Align(
              alignment: Alignment.bottomRight,
              child: MySubmitButton(
                buttonText: 'Go',
                submitCallback: submit
              )
          )
        ],
      )
    );
  }
}