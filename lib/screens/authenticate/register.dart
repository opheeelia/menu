import 'package:menu/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleAuthView;

  Register(this.toggleAuthView);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String err = '';
  String email;
  String pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person_outline),
            label: Text('Sign In'),
            onPressed: () => widget.toggleAuthView,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child:
              TextFormField(
                decoration: InputDecoration(hintText: 'email'),
                validator: (val) => val.contains('@') && val.isNotEmpty ? null : 'Must be a valid email address',
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
                decoration: InputDecoration(hintText: 'password'),
                validator: (val) => val.length >= 6 ? null : 'Password must be at least 6 characters',
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
                child: Text('Register'),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    var res = await _auth.registerEmail(email, pwd);
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
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
