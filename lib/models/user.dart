import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String image;
  String phone;
  String about;
  bool isDarkMode;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phone,
    this.about,
    this.isDarkMode,
  });

  UserModel.fromDocumentSnapsho(DocumentSnapshot doc) {
    id = doc.documentID;
    name = doc['name'] as String ?? '';
    email = doc['email'] as String ?? '';
    image = doc['image'] as String ?? '';
    phone = doc['phone'] as String ?? '';
    about = doc['about'] as String ?? '';
    isDarkMode = doc['isDarkMode'] as bool ?? false;
  }

  // Map<String, dynamic> toJson(){
  // final Map<String, dynamic> data = new Map<String, dynamic>();
  // data['name'] = this.name;
  // return data;
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'phone': phone,
      'about': about,
      'isDarkMode': isDarkMode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'].toString(),
      name: map['name'].toString(),
      email: map['email'].toString(),
      image: map['image'].toString(),
      phone: map['phone'].toString(),
      about: map['about'].toString(),
      isDarkMode: map['isDarkMode'] as bool,
    );
  }

  UserModel copyWith({
    String id,
    String name,
    String email,
    String image,
    String phone,
    String about,
    bool isDarkMode,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, image: $image, phone: $phone, about: $about, isDarkMode: $isDarkMode)';
  }

  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.image == image &&
        other.phone == phone &&
        other.about == about &&
        other.isDarkMode == isDarkMode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        image.hashCode ^
        phone.hashCode ^
        about.hashCode ^
        isDarkMode.hashCode;
  }
}
