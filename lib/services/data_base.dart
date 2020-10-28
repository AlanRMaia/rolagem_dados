import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rolagem_dados/controllers/user_controller.dart';
import 'package:rolagem_dados/models/user.dart';

class Database extends GetxController {

  Database(){
    _loadMessages();
  }

  static Database get to => Get.find();
  final Firestore _firestore = Firestore.instance;
  final List<Map<String, dynamic>> _messages = [];
  
  List<Map<String, dynamic>> get messages => _messages;       
  

  Future<bool> createNewUser(UserModel user) async {

    try {
      await _firestore.collection('users').document(user.id).setData({
        'name': user.name,
        'email': user.email
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
       final DocumentSnapshot doc =  await _firestore.collection('users').document(uid).get();

       return UserModel.fromDocumentSnapsho(doc);

    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> _loadMessages() async {
    final QuerySnapshot snapshot =  await _firestore.collection('messages').getDocuments();
    for (final message in snapshot.documents) {
      messages.add(message.data);
    } 
    update();
  }

  void handleSubmitted(String text) {      
    if(UserController.to.user != null){
      _sendMessage(text: text, user: UserController.to.user );
    } 
  }

  Future<void> _sendMessage({String text, String imgUrl, UserModel user}) async {
    try {
      
      await _firestore.collection('messages').add(
        {
          'text': text,
          'imgUrl': imgUrl,
          'senderName': user.name,
          'senderPhotoUrl': user.image ?? 'https://www.google.com/imgres?imgurl=https%3A%2F%2Fimg1.gratispng.com%2F20180530%2Fwbi%2Fkisspng-user-profile-computer-icons-profile-avatar-5b0ee85eda0852.0428819015277036468931.jpg&imgrefurl=https%3A%2F%2Fwww.gratispng.com%2Fbaixar%2Fprofile-avatar.html&tbnid=W4xOgY7WMPeqLM&vet=12ahUKEwjP6c-go9jsAhVICbkGHQHPACAQMyg6egQIARAm..i&docid=m1NZK1RYzcla6M&w=260&h=300&q=imagem%20de%20usu%C3%A1rio%20sem%20imagem&ved=2ahUKEwjP6c-go9jsAhVICbkGHQHPACAQMyg6egQIARAm'
        }
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

}