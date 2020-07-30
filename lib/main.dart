import 'package:flutter/material.dart';

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
        // This optional block of code can be used to run
        // code when the user saves the form.
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

class WelcomeFormState extends State<WelcomeForm>{
  final _formKey = GlobalKey<FormState>();

  void submit(){
    if (_formKey.currentState.validate()){
      /* *
      *
      * Check if email exists
      *
      * */
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