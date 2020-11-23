import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu/models/user.dart';

class DatabaseServices{

  final String uid;

  DatabaseServices(this.uid);

  final CollectionReference userDataCollection = Firestore.instance.collection('userData');
//
//  Stream<List<User>> get users {
//    var stuff = userDataCollection.document(uid).collection('userData').snapshots().map();
//    return stuff;
//  }


}