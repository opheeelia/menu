import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:menu/services/database.dart';
import '../models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user{
    return _auth.onAuthStateChanged.map(user_from_firebase_user);
  }

  User user_from_firebase_user(FirebaseUser user){
    return user != null ? User(user.uid) : null;
  }

  Future signInEmail(String email, String pwd) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      return user_from_firebase_user(result.user);
    }catch (e){
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future registerEmail(String email, String pwd) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
      User user = user_from_firebase_user(result.user);

      //create new document for user
//      await DatabaseService(user.uid).updateTasksData('Your first task', false);

      return user;
    }catch (e){
      print('Error: ${e.toString()}');
      return null;
    }
  }

  Future signOut() async {
    try{
      await _auth.signOut();
    }catch (e){
      print(e.toString());
      return null;
    }
  }
}