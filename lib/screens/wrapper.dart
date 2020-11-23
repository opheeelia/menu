import 'package:menu/models/user.dart';
import 'package:menu/screens/authenticate/authenticate.dart';
import 'package:menu/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:menu/screens/page_wrapper.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final User user = Provider.of<User>(context);

    //return either home or authenticate
    if (user == null){
      return Authenticate();
    }else{
      return PageWrapper();
    }
  }
}
