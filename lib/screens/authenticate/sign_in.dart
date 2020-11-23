import 'package:menu/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleAuthView;

  SignIn(this.toggleAuthView);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String err = '';
  String email;
  String pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
                height: 200,
                width: 300,
                margin: new EdgeInsets.only(top: 100.0, bottom: 20.0),
                child: Image.asset('assets/images/fake-logo.jpg')),
            Container(
              margin: EdgeInsets.all(10),
              child:
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'email',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2))
                ),
                validator: (val) => val.isNotEmpty ? null : 'Enter an email address',
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: 'password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2))
                ),
                validator: (val) => val.isNotEmpty ? null : 'Enter a password',
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    pwd = val;
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: RaisedButton(
                child: Text('Sign In'),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    var res = await _auth.signInEmail(email, pwd);
                    if (res == null){
                      setState(() {
                        err = 'Invalid credentials';
                      });
                    }
                  }
                },
              ),
            ),
            Text(
              err,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
            Text('or'),
            RaisedButton(
              child: Text('Register'),
              onPressed: () => widget.toggleAuthView(),
            ),
          ],
        ),
      ),
    );
  }
}
