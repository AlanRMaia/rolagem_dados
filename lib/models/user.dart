import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String image;
  String phone;

  UserModel({this.id, this.name, this.email, this.image, this.phone});

  UserModel.fromDocumentSnapsho(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc['name'] as String;
    email = doc['email'] as String;
    image = doc['image'] as String;
    phone = doc['phone'] as String;
  }

  // Map<String, dynamic> toJson(){
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // data['name'] = this.name;
  // return data;
  // }
}
