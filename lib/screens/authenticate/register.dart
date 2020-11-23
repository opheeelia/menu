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
      backgroundColor: Colors.amber,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical:50.0),
              child: Text('Welcome to me-n-u!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
            ),
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
                decoration: InputDecoration(
                    hintText: 'password',
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2))
                ),
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
            Text('or'),
            RaisedButton(
              child: Text('Sign In'),
              onPressed: () => widget.toggleAuthView(),
            ),
          ],
        ),
      ),
    );
  }
}
