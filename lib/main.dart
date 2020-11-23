import 'package:flutter/material.dart';
import 'package:menu/screens/wrapper.dart';
import 'package:menu/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:menu/models/user.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  final ThemeData appTheme = ThemeData(
    fontFamily: 'Source Sans Pro',
    primaryColor: Color(0xFFF9A620),
    accentColor: Colors.amberAccent,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          theme: appTheme,
          home: Wrapper(),
        )
    );
  }
}
